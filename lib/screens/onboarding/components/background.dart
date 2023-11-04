import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'dart:ui';

List<Widget> backgroundWidgets(context) {
  return [
    Positioned(
      bottom: 200,
      left: 100,
      width: MediaQuery.of(context).size.width * 1.7,
      child: Image.asset("assets/Backgrounds/Spline.png"),
    ),
    Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 10,
        ),
        child: const SizedBox(),
      ),
    ),
    const RiveAnimation.asset("assets/RiveAssets/shapes2.riv"),
    Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 30,
          sigmaY: 30,
        ),
        child: const SizedBox(),
      ),
    ),
  ];
}
