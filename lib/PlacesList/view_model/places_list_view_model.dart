import 'package:flutter/material.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/model/map_object_category.dart';
import 'package:lindenhofpark/Map/model/map_objects.dart';
import 'package:lindenhofpark/PlaceDetails/model/historical_places/historical_place.dart';
import 'package:lindenhofpark/PlaceDetails/model/historical_places/historical_places.dart';
import 'package:lindenhofpark/PlacesList/FilterBox/model/map_objects_dropdown_labels.dart';

class PlacesListViewModel with ChangeNotifier {
  List<MapObject> filteredMapObjects = allMapObjects;
  String selectedCategoryName = "Alle";

  // Filter the mapObjects by their title
  // Find words matching the searchText in long texts
  void findMapObjects(String searchText) {
    selectedCategoryName = "Alle";
    final query = searchText.toLowerCase();
    filteredMapObjects = allMapObjects
        .where((mapObject) =>
            mapObject.title.toLowerCase().contains(query) ||
            mapObject.keywords.toLowerCase().contains(query))
        .toList();

    // Find words matching the searchText in long texts
    final historicalPlacesSearchResults = mapObjects
        .where((mapObject) =>
            mapObject.category.category ==
                MapObjectCategoryType.historicalPlace &&
            historicalPlaces
                .getHistoricalPlaceByTitle(mapObject.title)
                .description
                .toLowerCase()
                .contains(searchText.toLowerCase()))
        .toList();

    // Combine findings
    filteredMapObjects.addAll(historicalPlacesSearchResults);

    // Remove duplicates
    filteredMapObjects = filteredMapObjects.toSet().toList();

    notifyListeners();
  }

  void setCategory(MapObjectDropdownCategoryLabel categoryLabel) {
    selectedCategoryName = categoryLabel.title;

    if (categoryLabel.title == "Alle") {
      filteredMapObjects = allMapObjects;
    } else {
      filteredMapObjects = allMapObjects
          .where((mapObject) =>
              mapObject.category.categoryName == categoryLabel.title)
          .toList();
    }
    notifyListeners();
  }
}
