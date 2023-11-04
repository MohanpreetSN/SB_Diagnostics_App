import 'package:flutter/material.dart';

import '../../../constants.dart';

class PackageBullet extends StatelessWidget {
  const PackageBullet({
    super.key,
    required this.text,
    this.textColor = darkTextPurple,
  });

  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: smallPadding / 2),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
