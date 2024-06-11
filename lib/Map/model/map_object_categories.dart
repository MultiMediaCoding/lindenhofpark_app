import 'package:flutter/cupertino.dart';
import 'package:lindenhofpark/Map/model/map_object_category.dart';
import 'package:lindenhofpark/resources/resources.dart';

final List<MapObjectCategory> mapObjectCategories = [
  MapObjectCategory(FontAwesomeIcon.gripSolid,
      Color.fromARGB(255, 255, 255, 255), MapObjectCategoryType.all),
  MapObjectCategory(FontAwesomeIcon.treeSolid, const Color(0xFFA9B388),
      MapObjectCategoryType.tree),
  MapObjectCategory(FontAwesomeIcon.landmarkSolid, const Color(0xFFA8835F),
      MapObjectCategoryType.historicalPlace),
  MapObjectCategory(FontAwesomeIcon.utensilsSolid, const Color(0xFFE99D56),
      MapObjectCategoryType.food),
  MapObjectCategory(FontAwesomeIcon.infoSolid, const Color(0xFFA4A4A4),
      MapObjectCategoryType.infoSign),
  MapObjectCategory(FontAwesomeIcon.personSwimmingSolid,
      const Color(0xFF95BBC7), MapObjectCategoryType.seasideResort),
];
