import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:sb_diagnostics/entry_point.dart';
import 'package:sb_diagnostics/firebase_stuff/signup_email_failure.dart';

import 'package:sb_diagnostics/screens/onboarding/onboarding_screen.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;
  var justLoggedIn = false.obs;

  // void changeJustLoggedIn(bool val) {
  //   justLoggedIn = val;
  // }

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
    super.onReady();
  }

  _setInitialScreen(
    User? user,
  ) {
    if (justLoggedIn.isFalse) {
      user == null ? Get.offAll(() => const OnboardingScreen()) : Get.offAll(() => const EntryPoint());
    }
  }

  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return firebaseUser.value != null;
      //firebaseUser.value != null ? Get.offAll(() => const EntryPoint()) : Get.to(() => const OnboardingScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar(
        "Oops",
        ex.message,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red[200],
      );
      return false;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      Get.snackbar(
        "Oops",
        ex.message,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red[200],
      );
      return false;
    }
  }

  // Future<bool> phoneAuth(String phoneNum) async {
  //   bool verificationSuccessful = false;
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: phoneNum,
  //     verificationCompleted: (credential) async {
  //       verificationSuccessful = true;
  //       await _auth.signInWithCredential(credential);
  //     },
  //     verificationFailed: (e) {
  //       if (e.code == 'invalid-phone-number') {
  //         Get.snackbar(
  //           "Oops",
  //           "The provided phone number is invalid.",
  //           duration: const Duration(seconds: 3),
  //           backgroundColor: Colors.red[200],
  //         );
  //       } else {
  //         //print(e.code);
  //         Get.snackbar(
  //           "Oops",
  //           "Could not sign in, please try again.",
  //           duration: const Duration(seconds: 3),
  //           backgroundColor: Colors.red[200],
  //         );
  //       }
  //     },
  //     codeSent: (verificationId, resendToken) {
  //       this.verificationId.value = verificationId;
  //     },
  //     codeAutoRetrievalTimeout: (verificationId) {
  //       this.verificationId.value = verificationId;
  //     },
  //   );
  //   return verificationSuccessful;
  // }

  // Future<bool> verifyOtp(String otp) async {
  //   try {
  //     var credentials = await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: otp));
  //     return credentials.user != null ? true : false;
  //   } on FirebaseException catch (e) {
  //     final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
  //     Get.snackbar(
  //       "Oops",
  //       "Could not sign in, please try again. ${ex.message}",
  //       duration: const Duration(seconds: 3),
  //       backgroundColor: Colors.red[200],
  //     );
  //     //print('Firebase auth exception - ${ex.message}');
  //     return false;
  //   }
  // }

  // Future<void> createUserWithEmailAndPassword(
  //     String email, String password) async {
  //   try {
  //     await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //   } catch (_) {}
  // }

  Future<void> logout() async => await _auth.signOut();
}
