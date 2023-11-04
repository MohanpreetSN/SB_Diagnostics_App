import 'package:flutter/material.dart';

import '../../../constants.dart';

class ContactIconText extends StatelessWidget {
  const ContactIconText({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 2 * medPadding,
      margin: const EdgeInsets.symmetric(horizontal: medPadding, vertical: smallPadding),
      padding: const EdgeInsets.symmetric(vertical: medPadding, horizontal: medPadding),
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
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: medPadding),
            child: GestureDetector(
              onTap: onTap,
              child: ContactIcon(
                icon: icon,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              maxLines: 4,
              style: const TextStyle(
                fontSize: 15,
              ),
              //textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class ContactIcon extends StatelessWidget {
  const ContactIcon({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 55,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: darkPurple,
        image: DecorationImage(image: AssetImage("assets/Backgrounds/trianglePurple.png"), fit: BoxFit.cover),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 35,
      ),
    );
  }
}
