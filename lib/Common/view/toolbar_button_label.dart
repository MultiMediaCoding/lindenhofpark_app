import 'package:flutter/material.dart';

class ToolbarButton extends StatelessWidget {
  const ToolbarButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
    this.alignment,
  });

  final Widget icon;
  final VoidCallback onPressed;
  final String semanticLabel;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: alignment ?? Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.surface,
            ),
            child: IconButton(
              onPressed: onPressed,
              tooltip: semanticLabel,
              icon: icon,
            ),
          ),
        ),
      ),
    );
  }
}
