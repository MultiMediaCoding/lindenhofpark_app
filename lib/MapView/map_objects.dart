import 'package:lindenhofpark/MapView/map_manager.dart';
import 'package:lindenhofpark/MapView/map_object.dart';
import 'package:lindenhofpark/MapView/map_object_categories.dart';
import 'package:lindenhofpark/MapView/map_object_category.dart';

final List<MapObject> mapObjects = [
  MapObject(
      "SuperBaum",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.tree),
      MapManager().lindenhofparkPosition,
      "imagePath")
];
