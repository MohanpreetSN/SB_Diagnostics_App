import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sb_diagnostics/firebase_stuff/test_controller.dart';
import 'package:sb_diagnostics/firebase_stuff/user_repo.dart';
import 'package:sb_diagnostics/screens/onboarding/components/login_dialog.dart';

import '../../../constants.dart';

void openSignInDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Sign In",
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (context, a1, a2, widget) {
      final curvedValue = Curves.easeInOut.transform(a1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
        //child: Opacity(opacity: a1.value, child: const SignInDialog2()),
        child: Opacity(opacity: a1.value, child: const LoginDialog()),
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) => Container(),
  );
}

class SignInButton extends StatelessWidget {
  SignInButton({
    Key? key,
  }) : super(key: key);

  final tController = Get.put(TestController());
  final uController = Get.put(UserRepo());

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        Future.delayed(
          const Duration(milliseconds: 200),
          () {
            tController.refreshValues = true;
            uController.valuesChanged = true;
            openSignInDialog(context);
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: darkPurple,
        minimumSize: const Size(250, 50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      child: const Text(
        "Sign In",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
