import 'package:flutter/material.dart';
import 'package:lindenhofpark/Map/model/map_object_categories.dart';

class MapObjectCategory {
  final String iconName;
  String iconPath = "";
  final Color pinColor;
  final MapObjectCategoryType category;
  String categoryName = "";

  MapObjectCategory(this.iconName, this.pinColor, this.category) {
    iconPath = "assets/images/map_category_icons/$iconName.svg";
    categoryName = mapObjectCategoryNames[category] ?? "";
  }
}

final mapObjectCategoryNames = {
  MapObjectCategoryType.all: "Alle",
  MapObjectCategoryType.tree: "Baum",
  MapObjectCategoryType.historicalPlace: "Historischer Ort",
  MapObjectCategoryType.culturalPlace: "Kultureller Ort",
  MapObjectCategoryType.bench: "Bank",
  MapObjectCategoryType.toilet: "Toilette",
  MapObjectCategoryType.food: "Essen",
  MapObjectCategoryType.infoSign: "Infotafel",
  MapObjectCategoryType.seasideResort: "Schwimmstelle",
};

enum MapObjectCategoryType {
  all,
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
