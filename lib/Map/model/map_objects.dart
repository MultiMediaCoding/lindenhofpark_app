import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/model/map_object_categories.dart';
import 'package:lindenhofpark/Map/model/map_object_category.dart';
import 'package:latlong2/latlong.dart';

final List<MapObject> mapObjects = [
  MapObject(
      "Gartendenkmal",
      "assets/images/trees/sample_tree.jpeg",
      mapObjectCategories
          .getObjectByCategory(MapObjectCategoryType.historicalPlace),
      const LatLng(47.557530, 9.659670)),
  MapObject(
      "Infotafel",
      "assets/images/trees/sample_tree.jpeg",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.infoSign),
      const LatLng(47.557653, 9.657740)),
  MapObject(
      "Lindenhofbad",
      "assets/images/trees/sample_tree.jpeg",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.food),
      const LatLng(47.556856, 9.658038)),
  MapObject(
      "Mamutbaum",
      "assets/images/trees/sample_tree.jpeg",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.tree),
      const LatLng(47.557317, 9.661553)),
];
