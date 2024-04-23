import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  const InfoBox(
      {super.key,
      required this.description,
      required this.content,
      this.subtitle});

  final String description;
  final String content;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey, fontSize: 12),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  content,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 5,
                ),
                if (subtitle != null)
                  Text(
                    subtitle ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
              ],
            )
          ],
        )
      ],
    );
  }
}
