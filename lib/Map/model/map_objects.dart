import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/model/map_object_categories.dart';
import 'package:lindenhofpark/Map/model/map_object_category.dart';
import 'package:latlong2/latlong.dart';

final List<MapObject> mapObjects = [
  MapObject(
      "titel1",
      mapObjectCategories
          .getObjectByCategory(MapObjectCategoryType.historicalPlace),
      const LatLng(47.557530, 9.659670)),
  MapObject(
      "Bergahorn",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.infoSign),
      const LatLng(47.557209, 9.660162)),
  MapObject(
      "Roteiche",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.food),
      const LatLng(47.557689, 9.660577)),
  MapObject(
      "Urweltmammutbaum",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.tree),
      const LatLng(47.557208, 9.661616)),
  MapObject(
      "Weihrauchzeder",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.tree),
      const LatLng(47.55731, 9.660326)),
  MapObject(
      "Riesenlebensbaum",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.tree),
      const LatLng(47.557868, 9.662008)),
  MapObject(
      "Schwarzkiefer",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.tree),
      const LatLng(47.557116, 9.658103)),
  MapObject(
      "Schwarznuss",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.tree),
      const LatLng(47.558002, 9.657898)),
  MapObject(
      "Nordmanntanne",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.tree),
      const LatLng(47.557807, 9.662035)),
  MapObject(
      "Hängebirke",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.tree),
      const LatLng(47.557315, 9.661381)),
  MapObject(
      "Ahornblättrige Platane",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.tree),
      const LatLng(47.557707, 9.664709)),
  MapObject(
      "Urweltmammutbaum+älter",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.tree),
      const LatLng(47.557419, 9.662324)),
];
