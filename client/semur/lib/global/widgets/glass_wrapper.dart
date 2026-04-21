import 'dart:ui';
import 'package:flutter/material.dart';

class GlassWrapper extends StatelessWidget {
  final double sigma;
  final Widget child;

  const GlassWrapper({super.key, required this.sigma, required this.child});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: child,
      ),
    );
  }
}
