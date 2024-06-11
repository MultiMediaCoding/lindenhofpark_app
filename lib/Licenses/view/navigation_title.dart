import 'package:flutter/material.dart';

class NavigationTitle extends StatelessWidget {
  const NavigationTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold));
  }
}
