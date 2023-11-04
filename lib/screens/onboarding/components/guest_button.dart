import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sb_diagnostics/firebase_stuff/auth_repo.dart';

import '../../../constants.dart';
import '../../../firebase_stuff/test_controller.dart';
import '../../../firebase_stuff/user_repo.dart';
import '../../../models/user_model.dart';

class GuestButton extends StatelessWidget {
  GuestButton({
    Key? key,
  }) : super(key: key);

  final aController = Get.put(AuthRepo());
  final uController = Get.put(UserRepo());
  final tController = Get.put(TestController());

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        Future.delayed(
          const Duration(milliseconds: 200),
          () async {
            tController.refreshValues = true;
            uController.valuesChanged = true;
            final user =
                UserModel(firstName: "Guest", lastName: "", phoneNo: "+910000000000", dob: "", gender: "", email: "guest@gmail.com");
            UserRepo.instance.userx = user;
            await aController.loginWithEmailAndPassword("guest@gmail.com", "password");
            // UserModel localUser = UserRepo.instance.userx;
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: darkBlue,
        minimumSize: const Size(250, 50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      child: const Text(
        "Guest",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
