import 'package:lindenhofpark/MapView/map_object.dart';
import 'package:lindenhofpark/MapView/map_object_categories.dart';
import 'package:lindenhofpark/MapView/map_object_category.dart';
import 'package:latlong2/latlong.dart';

final List<MapObject> mapObjects = [
  MapObject(
      "Gartendenkmal",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.tree),
      const LatLng(47.557530, 9.659670),
      "imagePath"),
  MapObject(
      "Infotafel",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.infoSign),
      const LatLng(47.557653, 9.657740),
      "imagePath"),
];
