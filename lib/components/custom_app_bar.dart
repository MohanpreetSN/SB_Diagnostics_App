import 'package:flutter/material.dart';

import '/constants.dart';
import 'custom_back_button.dart';
import 'heading.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    Key? key,
    required this.heading,
  }) : super(key: key);

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: smallPadding),
          child: CustomBackButton(),
        ),
        const Spacer(),
        Heading(text: heading),
        const Spacer(),
        const SizedBox(
          width: 40,
        )
      ],
    );
  }
}
