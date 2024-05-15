import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationBackButton extends StatelessWidget {
  const NavigationBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: SafeArea(
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: EdgeInsets.only(right: 2.5),
            margin: EdgeInsets.all(10),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Theme.of(context).colorScheme.background.withOpacity(0.95)),
            child: Icon(CupertinoIcons.chevron_back),
          ),
        ),
      ),
    );
  }
}
