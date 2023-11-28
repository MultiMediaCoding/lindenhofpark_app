import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/MapView/map_object_category.dart';

final List<MapObjectCategory> mapObjectCategories = [
  MapObjectCategory(
      CupertinoIcons.tree, const Color(0xFFA9B388), MapObjectCategoryType.tree),
  MapObjectCategory(
      CupertinoIcons.info, const Color(0xFFA4A4A4), MapObjectCategoryType.sign),
  MapObjectCategory(CupertinoIcons.bed_double, const Color(0xFFBF4343),
      MapObjectCategoryType.bench),
  MapObjectCategory(CupertinoIcons.building_2_fill, const Color(0xFFA8835F),
      MapObjectCategoryType.historicalPlace),
];
