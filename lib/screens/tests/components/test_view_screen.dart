import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sb_diagnostics/constants.dart';
import 'package:sb_diagnostics/models/test_model.dart';
import 'package:sb_diagnostics/screens/profile/components/user_button.dart';

import '../../../components/custom_app_bar.dart';
import '../../contact/contact_screen.dart';
import 'test_header_card.dart';
import 'white_background.dart';

class TestViewScreen extends StatelessWidget {
  const TestViewScreen({super.key, required this.test});

  final TestModel test;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    //const SizedBox(height: 30),
                    const CustomAppbar(heading: "Test Details"),
                    const SizedBox(height: medPadding),
                    TestHeaderCard(text: test.title),
                    WhiteBackground(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: medPadding),
                        child: Text(
                          test.details,
                          style: const TextStyle(fontSize: 18, color: darkTextPurple, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                bottom: hugePadding * 0.75,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FittedBox(
                    child: UserButton(
                      width: 300,
                      color: pinkPurple,
                      icon: const Icon(Icons.phone),
                      topPadding: smallPadding,
                      label: "Book Test",
                      onPressed: () => Get.to(() => const ContactScreen()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
