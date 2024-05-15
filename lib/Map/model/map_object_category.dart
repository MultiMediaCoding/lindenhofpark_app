import 'package:flutter/material.dart';
import 'package:lindenhofpark/Map/model/map_object_categories.dart';

class MapObjectCategory {
  final String iconName;
  final Color pinColor;
  final MapObjectCategoryType category;
  String categoryName = "";

  MapObjectCategory(this.iconName, this.pinColor, this.category) {
    categoryName = mapObjectCategoryNames[category] ?? "";
  }
}

final mapObjectCategoryNames = {
  MapObjectCategoryType.all: "Alle",
  MapObjectCategoryType.tree: "Baum",
  MapObjectCategoryType.historicalPlace: "Historischer Ort",
  MapObjectCategoryType.food: "Restaurant",
  MapObjectCategoryType.infoSign: "Infotafel",
  MapObjectCategoryType.seasideResort: "Schwimmstelle",
};

enum MapObjectCategoryType {
  all,
  tree,
  historicalPlace,
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
