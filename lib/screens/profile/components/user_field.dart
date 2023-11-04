import 'package:flutter/material.dart';

import '/constants.dart';

class UserField extends StatelessWidget {
  const UserField({
    Key? key,
    required this.label,
    required this.text,
  }) : super(key: key);

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 2 * medPadding,
      height: 50,
      margin: const EdgeInsets.symmetric(
          horizontal: medPadding, vertical: smallPadding),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            //color: pinkPurple.withOpacity(0.5),
            offset: Offset(1, 1),
            blurRadius: 2.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width - 2 * medPadding) * 0.25,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: pinkPurple),
              color: scaffoldColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: smallPadding),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 2 * medPadding) * 0.75,
            height: 50,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: AssetImage("assets/Backgrounds/smallTriangleLight.png"),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: smallPadding),
              child: Text(
                text,
                maxLines: 1,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
