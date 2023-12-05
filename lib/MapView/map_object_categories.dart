import 'package:flutter/cupertino.dart';
import 'package:lindenhofpark/MapView/map_object_category.dart';

final List<MapObjectCategory> mapObjectCategories = [
  MapObjectCategory(
      "tree.fill", const Color(0xFFA9B388), MapObjectCategoryType.tree),
  MapObjectCategory("building.columns.fill", const Color(0xFFA8835F),
      MapObjectCategoryType.historicalPlace),
  MapObjectCategory("theatermasks.fill", const Color(0xFFB97070),
      MapObjectCategoryType.culturalPlace),
  MapObjectCategory(
      "chair.lounge", const Color(0xFFBF4343), MapObjectCategoryType.bench),
  MapObjectCategory(
      "toilet", const Color(0xFF83A9CD), MapObjectCategoryType.toilet),
  MapObjectCategory(
      "fork.knife", const Color(0xFFE99D56), MapObjectCategoryType.food),
  MapObjectCategory(
      "info", const Color(0xFFA4A4A4), MapObjectCategoryType.infoSign),
  MapObjectCategory("figure.open.water.swim", const Color(0xFF95BBC7),
      MapObjectCategoryType.seasideResort),
];
