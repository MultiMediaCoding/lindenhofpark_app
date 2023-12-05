import 'package:flutter/material.dart';
import 'package:lindenhofpark/MapView/map_object_categories.dart';

class MapObjectCategory {
  final String iconName;
  String iconPath = "";
  final Color pinColor;
  final MapObjectCategoryType category;

  MapObjectCategory(this.iconName, this.pinColor, this.category) {
    iconPath = "assets/images/map_category_icons/$iconName.svg";
  }
}

enum MapObjectCategoryType {
  tree,
  historicalPlace,
  culturalPlace,
  bench,
  toilet,
  food,
  infoSign,
  seasideResort
}

extension MyObjectListExtension on List<MapObjectCategory> {
  MapObjectCategory getObjectByCategory(MapObjectCategoryType category) {
    return firstWhere((obj) => obj.category == category,
        orElse: () => mapObjectCategories.first);
  }
}
