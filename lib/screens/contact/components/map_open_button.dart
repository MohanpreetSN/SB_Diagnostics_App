import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../onboarding/components/custom_buttons.dart';

class MapOpenButton extends StatelessWidget {
  const MapOpenButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: medPadding),
      child: RoundedRectangleButton(
        color: darkPurple,
        onpressed: onTap,
        label: "Open in Maps",
      ),
    );
  }
}
