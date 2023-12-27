import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/model/map_objects.dart';
import 'package:lindenhofpark/PlacesList/view/places_list_item.dart';

class PlacesListView extends StatelessWidget {
  const PlacesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              for (MapObject mapObject in mapObjects)
                PlacesListItem(mapObject: mapObject)
            ],
          )),
    );
  }
}
