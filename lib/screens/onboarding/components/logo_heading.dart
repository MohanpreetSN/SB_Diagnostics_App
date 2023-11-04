import 'package:flutter/material.dart';

import '../../../constants.dart';

class LogoHeading extends StatelessWidget {
  const LogoHeading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: hugePadding,
            bottom: medPadding,
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white70,
            radius: 100,
            child: Image.asset("assets/Backgrounds/20230415_205413-removebg-preview.png", height: 160),
          ),

          //   child: CircleAvatar(
          //     backgroundColor: Colors.white70,
          //     radius: 100,
          //     child: Text(
          //       'SB Logo',
          //       style: TextStyle(fontSize: 25),
          //     ),
          //   ),
        ),
        const Padding(
          padding: EdgeInsets.all(smallPadding),
          child: Text(
            "SB Diagnostics",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: backgroundColorDark,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: smallPadding),
          child: Text(
            "Care you can trust",
            style: TextStyle(
              fontSize: 24,
              fontFamily: "Pacifico",
            ),
          ),
        ),
      ],
    );
  }
}
