import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/package_model.dart';
import 'glass_morph.dart';

class GlassIcon extends StatelessWidget {
  const GlassIcon({
    super.key,
    required this.package,
  });

  final PackageModel package;

  @override
  Widget build(BuildContext context) {
    return GlassMorph(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      height: 110,
      width: 100,
      sigma: 10,
      color: Colors.white.withOpacity(0.4),
      child: Container(
        height: 110,
        width: 100,
        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
        child: SvgPicture.asset(
          package.svgLocation,
          height: 80,
          width: 80,
        ),
      ),
    );
  }
}
