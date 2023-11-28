import 'package:flutter/material.dart';
import 'package:lindenhofpark/MapView/map_object_categories.dart';

class MapObjectCategory {
  final IconData iconData;
  final Color pinColor;
  final MapObjectCategoryType category;

  MapObjectCategory(this.iconData, this.pinColor, this.category);
}

enum MapObjectCategoryType { tree, sighn, bench, historicalPlace }

extension MyObjectListExtension on List<MapObjectCategory> {
  MapObjectCategory getObjectByCategory(MapObjectCategoryType category) {
    return firstWhere((obj) => obj.category == category,
        orElse: () => mapObjectCategories.first);
  }
}
