import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';

class PlacesListItem extends StatelessWidget {
  const PlacesListItem({super.key, required this.mapObject});

  final MapObject mapObject;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(mapObject.imagePath),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mapObject.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              mapObject.category.categoryName,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        )
      ],
    );
  }
}
