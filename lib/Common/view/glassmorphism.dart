import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  final Widget child;
  final double? borderRadius;

  const GlassMorphism({super.key, required this.child, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius ?? 0);
    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: radius,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.35),
              width: 0.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
