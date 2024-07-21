import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/model/map_object_categories.dart';
import 'package:lindenhofpark/Map/model/map_object_category.dart';
import 'package:latlong2/latlong.dart';

final List<MapObject> mapObjects = [
  // NOTE: Historical Places
  MapObject(
      "Badestelle Lindenhof",
      mapObjectCategories
          .getObjectByCategory(MapObjectCategoryType.historicalPlace),
      const LatLng(47.55657241058119, 9.658343701465512)),
  MapObject(
      "Villa Lindenhof",
      mapObjectCategories
          .getObjectByCategory(MapObjectCategoryType.historicalPlace),
      const LatLng(47.55788511597358, 9.660986738915682)),
  MapObject(
      "Villa Lindenhof",
      mapObjectCategories
          .getObjectByCategory(MapObjectCategoryType.historicalPlace),
      const LatLng(47.55788511597358, 9.660986738915682)),
  MapObject(
      "Schweizerhaus",
      mapObjectCategories
          .getObjectByCategory(MapObjectCategoryType.historicalPlace),
      const LatLng(47.55777817046658, 9.662811303771745)),
  MapObject(
      "Friedensräume",
      mapObjectCategories
          .getObjectByCategory(MapObjectCategoryType.historicalPlace),
      const LatLng(47.5579659264289, 9.661221768796072)),
  MapObject(
      "Ziergarten",
      mapObjectCategories
          .getObjectByCategory(MapObjectCategoryType.historicalPlace),
      const LatLng(47.55763352201423, 9.659679051394953)),
  MapObject(
      "Ruine Degelstein",
      mapObjectCategories
          .getObjectByCategory(MapObjectCategoryType.historicalPlace),
      const LatLng(47.55725215795993, 9.6588190891186)),
  MapObject(
      "Grab von Friedrich Gruber",
      mapObjectCategories
          .getObjectByCategory(MapObjectCategoryType.historicalPlace),
      const LatLng(47.55649787856096, 9.659373838914766)),
  MapObject(
      "Lindenallee",
      mapObjectCategories
          .getObjectByCategory(MapObjectCategoryType.historicalPlace),
      const LatLng(47.55686705265851, 9.661183836407744)),
  MapObject(
      "Gärtnerhaus",
      mapObjectCategories
          .getObjectByCategory(MapObjectCategoryType.historicalPlace),
      const LatLng(47.558293926343616, 9.65924219808936)),
  MapObject(
      "Buchenwäldle",
      mapObjectCategories
          .getObjectByCategory(MapObjectCategoryType.historicalPlace),
      const LatLng(47.55795636758571, 9.658321044197328)),
  MapObject(
      "Friedenssäule",
      mapObjectCategories
          .getObjectByCategory(MapObjectCategoryType.historicalPlace),
      const LatLng(47.55681531949221, 9.661631534605224)),
  MapObject(
      "Seeschlössle",
      mapObjectCategories
          .getObjectByCategory(MapObjectCategoryType.historicalPlace),
      const LatLng(47.55728735540322, 9.662609679084067)),

  // NOTE: Trees
  MapObject(
      "Urweltmammutbaum",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.tree),
      const LatLng(47.55746132, 9.66226002)),
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
  MapObject(
      "Rotbuche",
      mapObjectCategories.getObjectByCategory(MapObjectCategoryType.tree),
      const LatLng(47.557861, 9.658639)),
];
