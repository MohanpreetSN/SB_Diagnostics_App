import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sb_diagnostics/constants.dart';

import '../../firebase_stuff/test_controller.dart';
import '../home/components/report_card.dart';
import '/components/heading.dart';
import 'components/reports_error_page.dart';
//import '../../constants.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
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
              const Heading(text: "Reports"),
              FutureBuilder(
                future: testController.fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      TestsPackagesReports testsAndPackages = snapshot.data as TestsPackagesReports;

                      final listOfReports = testsAndPackages.listOfReports;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (listOfReports.isNotEmpty)
                            Column(
                              children: [
                                ...List.generate(
                                  listOfReports.length,
                                  (index) => ReportCard(
                                    report: listOfReports[index],
                                  ),
                                ),
                                const SizedBox(
                                  height: 120,
                                ),
                              ],
                            ),
                          if (listOfReports.isEmpty) ReportErrorPage(),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return ReportErrorPage(isError: true);
                    } else {
                      return ReportErrorPage(isError: true);
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
