import 'package:flutter/cupertino.dart';
import 'package:lindenhofpark/Map/model/map_object_category.dart';

final List<MapObjectCategory> mapObjectCategories = [
  MapObjectCategory("grip-solid", Color.fromARGB(255, 255, 255, 255),
      MapObjectCategoryType.all),
  MapObjectCategory(
      "tree-solid", const Color(0xFFA9B388), MapObjectCategoryType.tree),
  MapObjectCategory("landmark-solid", const Color(0xFFA8835F),
      MapObjectCategoryType.historicalPlace),
  MapObjectCategory(
      "utensils-solid", const Color(0xFFE99D56), MapObjectCategoryType.food),
  MapObjectCategory(
      "info-solid", const Color(0xFFA4A4A4), MapObjectCategoryType.infoSign),
  MapObjectCategory("person-swimming-solid", const Color(0xFF95BBC7),
      MapObjectCategoryType.seasideResort),
];
