import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sb_diagnostics/constants.dart';
import 'package:sb_diagnostics/screens/profile/components/user_button.dart';
import 'package:sb_diagnostics/screens/tests/components/white_background.dart';

import '../../../components/custom_app_bar.dart';
import '../../../models/package_model.dart';
import '../../contact/contact_screen.dart';
import 'package_bullet.dart';
import 'package_header_card.dart';

class PackageViewScreen extends StatelessWidget {
  const PackageViewScreen({super.key, required this.package});

  final PackageModel package;

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
                    const CustomAppbar(heading: "Package Details"),
                    const SizedBox(height: medPadding),
                    PackageHeaderCard(package: package),
                    WhiteBackground(
                      child: Column(
                        children: [
                          ...List.generate(
                            package.listOfTests!.length,
                            (index) => PackageBullet(
                              text: package.listOfTests![index].tests,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned.fill(
                bottom: hugePadding,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: UserButton(
                    width: 300,
                    color: darkPurple,
                    icon: const Icon(Icons.phone),
                    label: "Book Package",
                    topPadding: smallPadding,
                    onPressed: () => Get.to(() => const ContactScreen()),
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
