import 'dart:ui';
import 'package:flutter/material.dart';

class GlassMorph extends StatelessWidget {
  const GlassMorph({
    Key? key,
    required this.borderRadius,
    required this.height,
    required this.width,
    required this.child,
    required this.sigma,
    this.color = Colors.white24,
  }) : super(key: key);

  final BorderRadiusGeometry? borderRadius;
  final double height;
  final double width;
  final Widget? child;
  final double sigma;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: sigma,
          sigmaY: sigma,
          //tileMode: TileMode.mirror,
        ),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
          ),
          child: child,
        ),
      ),
    );
  }
}
