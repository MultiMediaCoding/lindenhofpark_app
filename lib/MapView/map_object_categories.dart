import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/MapView/map_object_category.dart';

final List<MapObjectCategory> mapObjectCategories = [
  MapObjectCategory(
      CupertinoIcons.tree, Colors.green, MapObjectCategoryType.tree),
  MapObjectCategory(
      CupertinoIcons.info, Colors.red, MapObjectCategoryType.sighn),
  MapObjectCategory(
      CupertinoIcons.bed_double, Colors.purple, MapObjectCategoryType.bench),
  MapObjectCategory(CupertinoIcons.clock, Colors.orange,
      MapObjectCategoryType.historicalPlace),
];
