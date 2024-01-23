import 'package:flutter/material.dart';

class BorderBox extends StatelessWidget {
  const BorderBox({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: Theme.of(context).colorScheme.onSurface),
          borderRadius: BorderRadius.circular(20)),
      child: child,
    );
  }
}
