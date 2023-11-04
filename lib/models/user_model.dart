import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String firstName;
  final String lastName;
  final String phoneNo;
  final String email;
  final String dob;
  final String gender;

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.dob,
    required this.gender,
    required this.email,
  });

  toJson() {
    return {
      "FirstName": firstName,
      "LastName": lastName,
      "PhoneNo": phoneNo,
      "Dob": dob,
      "Gender": gender,
      "Email": email,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      firstName: data["FirstName"],
      lastName: data["LastName"],
      phoneNo: data["PhoneNo"],
      dob: data["Dob"],
      gender: data["Gender"],
      email: data["Email"],
    );
  }
}
