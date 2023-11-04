import 'package:get/get.dart';
import 'package:sb_diagnostics/firebase_stuff/test_repo.dart';
import 'package:sb_diagnostics/models/package_model.dart';
import 'package:sb_diagnostics/models/report_model.dart';

import '../models/test_model.dart';
import 'report_repo.dart';

class TestController extends GetxController {
  static TestController get instance => Get.find();

  final _testRepo = Get.put(TestRepo());
  final _rController = Get.put(ReportRepo());
  TestsPackagesReports? testsPackagesReports;
  bool refreshValues = false;

  Future<TestsPackagesReports> fetchData() async {
    if (testsPackagesReports == null || refreshValues) {
      testsPackagesReports = await getTestsPackagesAndReports(refreshValues);
      refreshValues = false;
      return Future.delayed(Duration.zero, () => testsPackagesReports!);
    }
    return testsPackagesReports!;
  }

  Future<TestsPackagesReports> getTestsPackagesAndReports(bool refreshvalues) async {
    final listOfTests = await getAllTests();
    final listOfPackages = await getAllPackages();
    final listOfReports = await _rController.fetchReports(refreshValues: refreshvalues);
    return TestsPackagesReports(listOfTests: listOfTests, listOfPackages: listOfPackages, listOfReports: listOfReports);
  }

  Future<List<TestModel>> getAllTests() async {
    return await _testRepo.allTests();
  }

  Future<List<PackageModel>> getAllPackages() async {
    return await _testRepo.allPackages();
  }
}

class TestsPackagesReports {
  final List<TestModel> listOfTests;
  final List<PackageModel> listOfPackages;
  final List<ReportModel> listOfReports;

  TestsPackagesReports({required this.listOfTests, required this.listOfPackages, required this.listOfReports});

  // Future<TestsPackagesReports> fetchData() async {
  //   final testController = Get.put(TestController());
  //   if (testController.testsAndPackagers == null) {
  //     testController.testsAndPackagers = await testController.getTestsAndPackages();
  //     return Future.delayed(Duration.zero, () => testController.testsAndPackagers!);
  //   }
  //   return testController.testsAndPackagers!;
  // }
}
