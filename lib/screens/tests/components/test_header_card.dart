import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'package_page_heading.dart';

class TestHeaderCard extends StatelessWidget {
  const TestHeaderCard({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 200,
      width: MediaQuery.of(context).size.width - 2 * medPadding,
      decoration: const BoxDecoration(
        //color: color,
        image: DecorationImage(
          image: AssetImage("assets/Backgrounds/smallTriangleLight.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(1, 1),
            blurRadius: 3.0,
            spreadRadius: 2.0,
          ), //BoxShadow
        ],
      ),
      child: Column(
        children: [
          PackagePageHeading(text: text),
          const SizedBox(height: smallPadding),
        ],
      ),
    );
  }
}
