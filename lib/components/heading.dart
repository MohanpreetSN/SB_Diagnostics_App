import 'package:flutter/material.dart';

import '/constants.dart';

class Heading extends StatelessWidget {
  const Heading({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        top: medPadding,
        bottom: smallPadding,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
      ),
    );
  }
}
