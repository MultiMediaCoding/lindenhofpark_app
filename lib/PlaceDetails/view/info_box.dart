import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  const InfoBox(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Color.fromARGB(255, 84, 163, 87),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.titleSmall,
            )
          ],
        )
      ],
    );
  }
}
