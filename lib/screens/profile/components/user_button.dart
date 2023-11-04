import 'package:flutter/material.dart';

import '../../../constants.dart';

class UserButton extends StatelessWidget {
  const UserButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.width = 0,
    this.topPadding = medPadding,
  }) : super(key: key);

  final Color color;
  final Icon icon;
  final String label;
  final VoidCallback onPressed;
  final double width;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == 0 ? MediaQuery.of(context).size.width - 2 * medPadding : width,
      height: 50,
      margin: EdgeInsets.only(left: medPadding, right: medPadding, top: topPadding, bottom: smallPadding),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            //color: pinkPurple.withOpacity(0.5),
            offset: Offset(1, 1),
            blurRadius: 3.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: Size(MediaQuery.of(context).size.width - 2 * medPadding, 50),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: smallPadding),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
