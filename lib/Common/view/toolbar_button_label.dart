import 'package:flutter/material.dart';

class ToolbarButton extends StatelessWidget {
  const ToolbarButton(
      {super.key, required this.iconData, required this.onPressed});

  final IconData iconData;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.background,
            ),
            child: IconButton(onPressed: onPressed(), icon: Icon(iconData)),
          ),
        ),
      ),
    );
  }
}
