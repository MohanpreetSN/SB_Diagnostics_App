import 'package:flutter/material.dart';

import '../../home/components/glass_morph.dart';
import '/constants.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

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
      height: 200,
      width: MediaQuery.of(context).size.width - 2 * medPadding,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
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
      child: Column(
        children: [
          const UserImage(),
          UserName(
            name: name,
          ),
        ],
      ),
    );
  }
}

class UserName extends StatelessWidget {
  const UserName({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        name,
        maxLines: 1,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class UserImage extends StatelessWidget {
  const UserImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: medPadding),
      child: GlassMorph(
        borderRadius: const BorderRadius.all(Radius.circular(60)),
        height: 120,
        width: 120,
        sigma: 4,
        child: Padding(
          padding: const EdgeInsets.all(smallPadding * 1.5),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset(
              "assets/icons/user_purple.png",
              height: 75,
            ),
          ),
        ),
      ),
    );
  }
}
