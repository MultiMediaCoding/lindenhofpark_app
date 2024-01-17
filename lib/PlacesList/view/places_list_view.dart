import 'package:flutter/material.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/model/map_objects.dart';
import 'package:lindenhofpark/PlacesList/FilterBox/view/border_box.dart';
import 'package:lindenhofpark/PlacesList/FilterBox/view/category_picker.dart';
import 'package:lindenhofpark/PlacesList/FilterBox/view/filter_box.dart';
import 'package:lindenhofpark/PlacesList/view/places_list_item.dart';

class PlacesListView extends StatelessWidget {
  const PlacesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste"),
      ),
      body: ListView(
        shrinkWrap: false,
        children: [
          Expanded(
            child: Wrap(
              spacing: 20,
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                FilterBox(),
                Column(
                  children: [
                    for (MapObject mapObject in mapObjects)
                      PlacesListItem(mapObject: mapObject)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
