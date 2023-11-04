import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../firebase_stuff/auth_repo.dart';

class ReportErrorPage extends StatelessWidget {
  ReportErrorPage({
    super.key,
    this.isError = false,
  });

  final bool isError;
  final aController = Get.put(AuthRepo());

  String pageText() {
    if (isError) {
      return "Oops! Something went wrong, please try again soon.\n Contact us if the issue doesn't resolve soon.";
    }
    if (aController.firebaseUser.value!.email == "guest@gmail.com") {
      return "Please login to view and download your reports. \n You will be texted your user name and password when your register at the lab.";
    }
    return "Looks like you don't have any reports available right now.\nAny reports you get will be shown here.";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: medPadding),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset(
                  "assets/Backgrounds/empty_folder_purple.png",
                  height: 220,
                ),
                Text(
                  pageText(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: blueGrey),
                )
                // Text(
                //   isError
                //       ? "Oops! Something went wrong, please try again soon.\n Contact us if the issue doesn't resolve soon."
                //       : "Looks like you don't have any reports available right now.\nAny reports you get will be shown here.",
                //   textAlign: TextAlign.center,
                //   style: const TextStyle(fontSize: 18, color: blueGrey),
                // )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
