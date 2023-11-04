import 'package:flutter/material.dart';

import 'components/background.dart';
import '../../constants.dart';
import 'components/guest_button.dart';
import 'components/logo_heading.dart';
import 'components/signin_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ...backgroundWidgets(context),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: smallPadding),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const LogoHeading(),
                  const Spacer(),
                  SignInButton(),
                  const SizedBox(height: largePadding),
                  GuestButton(),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
