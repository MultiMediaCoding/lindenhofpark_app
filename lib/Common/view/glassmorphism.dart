import 'dart:ui';
import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  final Widget child;
  final double? borderRadius;

  const GlassMorphism({super.key, required this.child, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ??
          0), // Stellen Sie sicher, dass dieser Wert gesetzt ist
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.2),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius: BorderRadius.circular(
                borderRadius ?? 0), // Wird bereits verwendet
          ),
          child: child,
        ),
      ),
    );
  }
}
