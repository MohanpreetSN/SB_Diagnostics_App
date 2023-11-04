import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/user_model.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  late UserModel userx;
  UserModel? localUserData;
  bool valuesChanged = false;

  Future<UserModel> fetchUserData(String email) async {
    if (localUserData == null || valuesChanged) {
      localUserData = await getUserDetailsx(email);
      valuesChanged = false;
      return localUserData!;
    }
    return localUserData!;
  }

  Future<void> createUser(UserModel user) async {
    await _db.collection("Users").add(user.toJson()).whenComplete(() {
      () => Get.snackbar("Success", "You account has been created.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green.withOpacity(0.1), colorText: Colors.green);
    }).catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent.withOpacity(0.1), colorText: Colors.red);
      //print(error.toString());
      throw error;
    });
  }

  Future<bool> userExists(String email) async {
    return await _db.collection("Users").where("Email", isEqualTo: email).get().then((value) => value.size > 0 ? true : false);
  }

  Future<UserModel> getUserDetailsx(String email) async {
    final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();

    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<void> updateUserRecord(UserModel user) async {
    await _db.collection("Users").doc(user.id).update(user.toJson());
  }
}
