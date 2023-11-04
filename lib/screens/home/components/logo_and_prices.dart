import 'package:flutter/material.dart';

import 'glass_icon.dart';
import 'glass_morph.dart';
import '../../../constants.dart';
import '../../../models/package_model.dart';

class LogoAndPrices extends StatelessWidget {
  const LogoAndPrices({
    Key? key,
    required this.package,
  }) : super(key: key);

  final PackageModel package;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: medPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GlassIcon(package: package),
          RetailPrice(package: package),
          DiscountPrice(package: package),
        ],
      ),
    );
  }
}

class DiscountPrice extends StatelessWidget {
  const DiscountPrice({
    super.key,
    required this.package,
  });

  final PackageModel package;

  @override
  Widget build(BuildContext context) {
    return GlassMorph(
      width: 88,
      height: 36,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      sigma: 10,
      child: Container(
        //padding: const EdgeInsets.only(top: smallPadding),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: smallPadding),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              "₹ ${package.discountPrice}",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class RetailPrice extends StatelessWidget {
  const RetailPrice({
    super.key,
    required this.package,
  });

  final PackageModel package;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: smallPadding, bottom: smallPadding),
      child: Text(
        "₹ ${package.retailPrice}",
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: const Color.fromARGB(255, 196, 181, 216), fontWeight: FontWeight.w600, decoration: TextDecoration.lineThrough),
      ),
    );
  }
}
