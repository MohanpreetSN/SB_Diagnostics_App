import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sb_diagnostics/screens/tests/components/package_view_screen.dart';

import '../../../models/package_model.dart';
import '../../../constants.dart';
import 'custom_package_bullet.dart';
import 'glass_morph.dart';
import 'logo_and_prices.dart';

// ignore: must_be_immutable
class PackageCard extends StatelessWidget {
  PackageCard({
    Key? key,
    required this.package,
  }) : super(key: key);

  final PackageModel package;
  late int testLen = package.listOfTests!.length;
  double width(context) {
    return MediaQuery.of(context).size.width - 2 * medPadding;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: smallPadding, horizontal: medPadding),
      child: GestureDetector(
        onTap: () => Get.to(() => PackageViewScreen(package: package)),
        child: Container(
          height: 288,
          width: width(context),
          decoration: const BoxDecoration(
            //color: color,
            image: DecorationImage(
              image: AssetImage("assets/Backgrounds/trianglePurple.png"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(1, 1),
                blurRadius: 3.0,
                spreadRadius: 2.0,
              ), //BoxShadow
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: medPadding),
                child: PackageCardTitle(package: package),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width(context) - 3 * medPadding - 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...List.generate(
                          testLen <= 7 ? testLen : 7,
                          (index) => CustomPackageBullet(package.listOfTests![index].tests),
                        ),
                        if (testLen > 7) const CustomPackageBullet("And more ...")
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: medPadding),
                    child: LogoAndPrices(package: package),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PackageCardTitle extends StatelessWidget {
  const PackageCardTitle({
    Key? key,
    required this.package,
  }) : super(key: key);

  final PackageModel package;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GlassMorph(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        height: 40,
        width: (MediaQuery.of(context).size.width - 6 * medPadding),
        sigma: 4,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: medPadding),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              package.title,
              maxLines: 1,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
