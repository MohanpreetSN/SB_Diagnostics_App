// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sb_diagnostics/firebase_stuff/auth_repo.dart';
// import 'package:sb_diagnostics/firebase_stuff/user_repo.dart';
// import 'package:sb_diagnostics/models/user_model.dart';

// class SignUpController extends GetxController {
//   static SignUpController get instance => Get.find();

//   var signInOtp = false.obs;
//   var signUpOtp = false.obs;
//   var signInValid = true.obs;
//   var signUpValid = false.obs;

//   final name = TextEditingController();
//   final phoneNum = TextEditingController();
//   String fullNum = '';

//   final userRepo = Get.put(UserRepo());

//   // void registerUser(String email, String password) {
//   //   AuthRepo.instance.createUserWithEmailAndPassword(email, password);
//   // }

//   Future<void> phoneAuthentication(String phoneNum) async {
//     await AuthRepo.instance.phoneAuth(phoneNum);
//   }

//   Future<void> createUser(UserModel user) async {
//     bool userExists = await userRepo.userExists(user.email);
//     if (!userExists) {
//       await userRepo.createUser(user);
//     }
//   }
// }
