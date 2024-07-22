import 'package:flutter/material.dart';

class ToolbarButton extends StatelessWidget {
  const ToolbarButton(
      {super.key, required this.icon, required this.onPressed, this.alignment});

  final Widget icon;
  final Function onPressed;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: alignment ?? Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.surface,
            ),
            child: IconButton(onPressed: onPressed(), icon: icon),
          ),
        ),
      ),
    );
  }
}
