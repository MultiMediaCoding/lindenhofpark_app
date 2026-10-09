import 'package:flutter/material.dart';
import 'package:lindenhofpark/Common/view/big_space.dart';
import 'package:lindenhofpark/Common/view/small_space.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/PlaceDetails/common/view/place_details_layout.dart';
import 'package:lindenhofpark/PlaceDetails/view/info_box.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree.dart';
import 'package:lindenhofpark/PlaceDetails/view/tree/biological_details_button.dart';

class TreeView extends StatelessWidget {
  const TreeView({super.key, required this.mapObject, required this.tree});

  final MapObject mapObject;
  final Tree tree;

  @override
  Widget build(BuildContext context) {
    return PlaceDetailsLayout(
      image: tree.image,
      minSheetSize: 0.4,
      maxSheetSize: 0.65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tree.title,
            style: Theme.of(context).textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            tree.latinName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SmallSpace(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                if (tree.age != null) ...[
                  InfoBox(
                    description: "Alter",
                    content: "${tree.age!}",
                    subtitle: "jahre",
                  ),
                  Spacer(),
                ],
                InfoBox(
                  description: "Höhe",
                  content: tree.height.toString(),
                  subtitle: "meter",
                ),
                Spacer(),
                InfoBox(description: "Blätter", content: tree.leafTypeName),
                Spacer(),
              ],
            ),
          ),
          const SmallSpace(),
          InfoBox(description: "Herkunft", content: tree.origin),
          const BigSpace(),
          if (tree.biologicalFacts.isNotEmpty) ...[
            BiologicalDetailsButton(facts: tree.biologicalFacts),
          ],
        ],
      ),
    );
  }
}
