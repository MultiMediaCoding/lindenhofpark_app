import 'package:flutter/material.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/model/map_objects.dart';

class PlacesListViewModel with ChangeNotifier {
  List<MapObject> filteredMapObjects = mapObjects;

  void filterMapObjects(String searchText) {
    filteredMapObjects = mapObjects
        .where((mapObject) =>
            mapObject.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
