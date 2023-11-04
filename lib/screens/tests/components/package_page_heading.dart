import 'package:flutter/material.dart';

import '../../../constants.dart';

class PackagePageHeading extends StatelessWidget {
  const PackagePageHeading({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: medPadding,
        right: medPadding,
        top: medPadding,
        bottom: smallPadding,
      ),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
