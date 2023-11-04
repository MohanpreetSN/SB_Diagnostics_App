import 'package:flutter/material.dart';

import '../../../constants.dart';

class WhiteBackground extends StatelessWidget {
  const WhiteBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: largePadding,
        left: medPadding,
        right: medPadding,
      ),
      padding: const EdgeInsets.symmetric(vertical: medPadding),
      width: MediaQuery.of(context).size.width - 2 * medPadding,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 250, 251, 253),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 1),
            blurRadius: 1.0,
            spreadRadius: 1.0,
          ), //BoxShadow
        ],
      ),
      child: child,
    );
  }
}
