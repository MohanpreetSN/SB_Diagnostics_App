import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/package_model.dart';
import '../../home/components/glass_icon.dart';
import '../../home/components/logo_and_prices.dart';
import 'package_page_heading.dart';

class PackageHeaderCard extends StatelessWidget {
  const PackageHeaderCard({
    super.key,
    required this.package,
  });

  final PackageModel package;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 200,
      width: MediaQuery.of(context).size.width - 2 * medPadding,
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
        children: [
          PackagePageHeading(text: package.title),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: medPadding),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: smallPadding + 2),
                    child: RetailPrice(package: package),
                  ),
                  GlassIcon(package: package),
                  DiscountPrice(package: package),
                ],
              ),
            ),
          ),
          const SizedBox(height: medPadding),
        ],
      ),
    );
  }
}
