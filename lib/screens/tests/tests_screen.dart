import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sb_diagnostics/components/heading.dart';
import 'package:sb_diagnostics/firebase_stuff/test_controller.dart';

import '../../components/general_error_page.dart';
import '../../constants.dart';
import '../home/components/package_card.dart';
import '../home/components/test_card.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  final testController = Get.put(TestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //const SizedBox(height: 30),
              const Heading(text: "Tests"),
              FutureBuilder(
                future: testController.fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      TestsPackagesReports testsAndPackages = snapshot.data as TestsPackagesReports;
                      final listOfTests = testsAndPackages.listOfTests;
                      final listOfPackages = testsAndPackages.listOfPackages;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: medPadding, bottom: smallPadding),
                            child: Text(
                              "Health Packages",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),
                            ),
                          ),
                          ...List.generate(
                            listOfPackages.length,
                            (index) => PackageCard(
                              package: listOfPackages[index],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: smallPadding,
                              left: medPadding,
                            ),
                            child: Text(
                              "All Tests",
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          ...List.generate(
                            listOfTests.length,
                            (index) => TestCard(
                              test: listOfTests[index],
                            ),
                          ),
                          const SizedBox(
                            height: 120,
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return GeneralErrorPage(errorString: snapshot.error.toString());
                    } else {
                      return const GeneralErrorPage();
                    }
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        const Center(
                          child: CircularProgressIndicator(color: darkPurple),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
