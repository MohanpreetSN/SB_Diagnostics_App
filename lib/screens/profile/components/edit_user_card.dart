import 'package:flutter/material.dart';

import 'user_card.dart';
import '../../../constants.dart';

class EditUserImage extends StatelessWidget {
  const EditUserImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: medPadding,
        vertical: medPadding,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: medPadding,
      ),
      height: 150,
      width: 150,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage("assets/Backgrounds/smallTriangleLight.png"),
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
      child: const UserImage(),
    );
  }
}
