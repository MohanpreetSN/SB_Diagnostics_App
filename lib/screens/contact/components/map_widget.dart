import 'package:flutter/material.dart';

import '../../../constants.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: medPadding, vertical: medPadding),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
            image: AssetImage("assets/Backgrounds/sb_map.png"),
            fit: BoxFit.cover,
          ),
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
      ),
    );
  }
}
