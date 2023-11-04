import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String? id;
  final String reference;
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNo;
  final String downloadUrl;
  final String date;
  final String testName;

  ReportModel({
    this.id,
    required this.reference,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.downloadUrl,
    required this.date,
    required this.testName,
    required this.email,
  });

  toJson() {
    return {
      "Reference": reference,
      "UserId": userId,
      "FirstName": firstName,
      "LastName": lastName,
      "PhoneNo": phoneNo,
      "DownloadUrl": downloadUrl,
      "Date": date,
      "TestName": testName,
      "Email": email,
    };
  }

  String dateConverter(String date) {
    String day = date.substring(0, 2);
    String month = date.substring(3, 5);
    String year = date.substring(6);

    int monthNo = int.parse(month);

    List<String> monthsList = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    String dateString = "$day ${monthsList[monthNo - 1]}, $year";
    return dateString;
  }

  factory ReportModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    String dateConverter(String date) {
      String day = date.substring(0, 2);
      String month = date.substring(3, 5);
      String year = date.substring(6);

      int monthNo = int.parse(month);

      List<String> monthsList = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
      ];

      String dateString = "$day ${monthsList[monthNo - 1]}, $year";
      return dateString;
    }

    return ReportModel(
      id: document.id,
      reference: data["Reference"],
      userId: data["UserId"],
      firstName: data["FirstName"],
      lastName: data["LastName"],
      phoneNo: data["PhoneNo"],
      downloadUrl: data["DownloadUrl"],
      date: dateConverter(data["Date"]),
      testName: data["TestName"],
      email: data["Email"],
    );
  }
}
