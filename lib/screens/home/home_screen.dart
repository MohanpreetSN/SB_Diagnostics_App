import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sb_diagnostics/components/general_error_page.dart';
import 'package:sb_diagnostics/firebase_stuff/test_controller.dart';

import '/components/heading.dart';
import 'components/report_card.dart';
import '/constants.dart';
import 'components/package_card.dart';
import 'components/test_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final testController = Get.put(TestController());
  // late final testPackageFuture =
  //     _memoizer1.runOnce(() => testController.getTestsAndPackages());

  // @override
  // void initState() {
  //   super.initState();
  //   testPackageFuture = testController.getTestsAndPackages();
  // }

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
              const Heading(text: "Home"),
              FutureBuilder(
                future: testController.fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      TestsPackagesReports testsAndPackages = snapshot.data as TestsPackagesReports;
                      final listOfTests = testsAndPackages.listOfTests;
                      final listOfPackages = testsAndPackages.listOfPackages;
                      final listOfReports = testsAndPackages.listOfReports;
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
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...List.generate(
                                  listOfPackages.length,
                                  (index) => PackageCard(
                                    package: listOfPackages[index],
                                  ),
                                ),
                                // ...List.generate(
                                //   packages.length,
                                //   (index) => PackageCard(
                                //     package: packages[index],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          if (listOfReports.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: smallPadding,
                                left: medPadding,
                              ),
                              child: Text(
                                "Your Reports",
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ...List.generate(
                            listOfReports.length,
                            (index) => ReportCard(
                              report: listOfReports[index],
                            ),
                          ),
                          if (listOfReports.isNotEmpty) const SizedBox(height: smallPadding),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: smallPadding,
                              left: medPadding,
                            ),
                            child: Text(
                              "Suggested Tests",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Padding(
//                 padding: const EdgeInsets.only(
//                     left: medPadding, bottom: smallPadding),
//                 child: Text(
//                   "Health Packages",
//                   style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 28),
//                 ),
//               ),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     ...List.generate(
//                       testController.listOfPackages.length,
//                       (index) => PackageCard(
//                         package: testController.listOfPackages[index],
//                       ),
//                     ),
//                     // ...List.generate(
//                     //   packages.length,
//                     //   (index) => PackageCard(
//                     //     package: packages[index],
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: smallPadding,
//                   left: medPadding,
//                 ),
//                 child: Text(
//                   "Your Reports",
//                   style: Theme.of(context)
//                       .textTheme
//                       .headlineSmall!
//                       .copyWith(fontWeight: FontWeight.w600),
//                 ),
//               ),
//               const ReportCard(),
//               const ReportCard(),
//               const ReportCard(),
//               const ReportCard(),
//               const ReportCard(),
//               const ReportCard(),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: medPadding,
//                   left: medPadding,
//                 ),
//                 child: Text(
//                   "Suggested Tests",
//                   style: Theme.of(context)
//                       .textTheme
//                       .headlineSmall!
//                       .copyWith(fontWeight: FontWeight.w600),
//                 ),
//               ),
//               ...List.generate(
//                 testController.listOfTests.length,
//                 (index) => SmallCard(
//                   test: testController.listOfTests[index],
//                 ),
//               ),
//               const SizedBox(
//                 height: 120,
//               ),