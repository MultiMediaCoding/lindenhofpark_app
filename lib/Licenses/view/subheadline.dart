import 'package:flutter/material.dart';

class Subheadline extends StatelessWidget {
  const Subheadline({super.key, required this.subheadline});

  final String subheadline;

  @override
  Widget build(BuildContext context) {
    return Text(subheadline,
        style: TextStyle(
            fontSize: 17, color: Theme.of(context).colorScheme.secondary));
  }
}
