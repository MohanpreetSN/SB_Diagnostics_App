import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/constants.dart';

class HalfRoundedButton extends StatelessWidget {
  const HalfRoundedButton({
    Key? key,
    required this.onpressed,
    required this.label,
  }) : super(key: key);

  final VoidCallback onpressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: smallPadding, bottom: smallPadding),
      child: ElevatedButton.icon(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: darkBlue,
          minimumSize: const Size(200, 40),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),
        icon: const Icon(CupertinoIcons.arrow_left),
        label: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class RoundedRectangleButton extends StatelessWidget {
  const RoundedRectangleButton({
    Key? key,
    required this.onpressed,
    required this.label,
    this.padding = const EdgeInsets.only(top: medPadding, bottom: medPadding),
    this.color = lightPurple,
  }) : super(key: key);

  final EdgeInsets padding;
  final VoidCallback onpressed;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton.icon(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(double.infinity, 56),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),
        icon: const Icon(CupertinoIcons.arrow_right),
        label: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class CustomPosition extends StatelessWidget {
  const CustomPosition({Key? key, required this.child, this.size = 100}) : super(key: key);

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: size,
            width: size,
            child: child,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
