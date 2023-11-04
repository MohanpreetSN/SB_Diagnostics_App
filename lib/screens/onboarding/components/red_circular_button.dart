import 'package:flutter/material.dart';

import '../../../constants.dart';

class RedCircularButton extends StatelessWidget {
  const RedCircularButton({
    Key? key,
    required this.label,
    required this.width,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final double width;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: lightRed,
        minimumSize: Size(width, 36),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(10),
          ),
        ),
      ),
      child: Text(label),
      //icon: const Icon(CupertinoIcons.question),
      //label: const Text("Forgot Password"),
    );
  }
}
