import 'package:cloud_firestore/cloud_firestore.dart';

class PackageModel {
  final String? id;
  final String title, svgLocation;
  final String retailPrice, discountPrice;
  final double order;
  List<PackageTest>? listOfTests;

  PackageModel({
    this.id,
    required this.title,
    required this.svgLocation,
    required this.retailPrice,
    required this.discountPrice,
    required this.order,
    this.listOfTests,
  });

  factory PackageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    List<String> svgLocations = [
      "assets/icons/stethoscope.svg",
      "assets/icons/injection_purple.svg",
      "assets/icons/microscope_purple.svg",
      "assets/icons/flask_purple.svg",
      "assets/icons/symbol_purple.svg"
    ];

    String logoAssigner(String value) {
      if (value == "Stethoscope") {
        return svgLocations[0];
      } else if (value == "Injection") {
        return svgLocations[1];
      } else if (value == "Microscope") {
        return svgLocations[2];
      } else if (value == "Flask") {
        return svgLocations[3];
      } else if (value == "Symbol") {
        return svgLocations[4];
      } else {
        return svgLocations[0];
      }
    }

    return PackageModel(
        id: document.id,
        title: data["Title"],
        retailPrice: data["RetailPrice"],
        discountPrice: data["DiscountPrice"],
        svgLocation: logoAssigner(data["Logo"]),
        order: double.parse(data["Order"]));
  }
}

class PackageTest {
  final String? id;
  final String tests;
  final double order;

  PackageTest({
    this.id,
    required this.tests,
    required this.order,
  });

  factory PackageTest.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PackageTest(
      id: document.id,
      tests: data["Tests"],
      order: double.parse(data["Order"]),
    );
  }
}

// List<PackageModel> packages = [
//   PackageModel(
//     title: "Primary Health Panel 1",
//     retailPrice: "2400",
//     discountPrice: "999",
//     svgLocation: "assets/icons/stethoscope.svg",
//     listOfTests: [
//       "CBC, LFT, TSH",
//       "Blood Sugar Random",
//       "Lipid Profile",
//       "Blood Urea",
//       "Serum Creatinine",
//       "X-Ray Chest",
//     ],
//   ),
//   PackageModel(
//     title: "Primary Health Panel 2",
//     retailPrice: "4000",
//     discountPrice: "1899",
//     svgLocation: "assets/icons/injection_purple.svg",
//     //svgLocation: "assets/icons/injection.svg",
//     listOfTests: [
//       "CBC, ESR, ABO, RH Factor",
//       "Blood Sugar Random",
//       "LFT, Lipid Profile",
//       "Blood Urea, S. Creatinine",
//       "HBA1C, TSH",
//       "X-Ray Chest PA",
//       "Urine R/M, ECG"
//     ],
//   ),
//   PackageModel(
//     title: "Complete Health Panel 1",
//     retailPrice: "6500",
//     discountPrice: "2999",
//     svgLocation: "assets/icons/microscope_purple.svg",
//     //svgLocation: "assets/icons/microscope.svg",
//     listOfTests: [
//       "CBC, ESR, ECG, Urine R/M",
//       "Blood Sugar Fasting, Urea",
//       "Lipid Profile, ABO",
//       "Uric Acid, S. Creatinine",
//       "Bilirubin(T.D.I), SGPT",
//       "Alkaline, Phosphate, HIV ",
//       "RH Factor, SGOT",
//       "USG Whole ABD"
//     ],
//   )
// ];