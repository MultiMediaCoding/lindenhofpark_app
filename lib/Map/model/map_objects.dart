import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/model/map_object_categories.dart';
import 'package:lindenhofpark/Map/model/map_object_category.dart';
import 'package:latlong2/latlong.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree_catalog.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree_knowledge.dart';

/// Orte mit handgepflegten Details. Bäume kommen aus dem [treeCatalog].
final List<MapObject> mapObjects = [
  // NOTE: Historical Places
  MapObject(
    "Badestelle Lindenhof",
    mapObjectCategories.getObjectByCategory(
      MapObjectCategoryType.historicalPlace,
    ),
    const LatLng(47.55657241058119, 9.658343701465512),
  ),
  MapObject(
    "Villa Lindenhof",
    mapObjectCategories.getObjectByCategory(
      MapObjectCategoryType.historicalPlace,
    ),
    const LatLng(47.55788511597358, 9.660986738915682),
  ),
  MapObject(
    "Geschichte des Guts Lindenhof",
    mapObjectCategories.getObjectByCategory(
      MapObjectCategoryType.historicalPlace,
    ),
    const LatLng(47.5576710, 9.6625540),
  ),
  MapObject(
    "Friedensräume",
    mapObjectCategories.getObjectByCategory(
      MapObjectCategoryType.historicalPlace,
    ),
    const LatLng(47.5579659264289, 9.661221768796072),
  ),
  MapObject(
    "Nutz- und Ziergartenbereich",
    mapObjectCategories.getObjectByCategory(
      MapObjectCategoryType.historicalPlace,
    ),
    const LatLng(47.5577210, 9.6598350),
  ),
  MapObject(
    "Ruine Degelstein",
    mapObjectCategories.getObjectByCategory(
      MapObjectCategoryType.historicalPlace,
    ),
    const LatLng(47.5572110, 9.6584389),
  ),
  MapObject(
    "Grab von Friedrich Gruber",
    mapObjectCategories.getObjectByCategory(
      MapObjectCategoryType.historicalPlace,
    ),
    const LatLng(47.55649787856096, 9.659373838914766),
  ),
  MapObject(
    "Lindenallee",
    mapObjectCategories.getObjectByCategory(
      MapObjectCategoryType.historicalPlace,
    ),
    const LatLng(47.55686705265851, 9.661183836407744),
  ),
  MapObject(
    "Gärtnerhaus",
    mapObjectCategories.getObjectByCategory(
      MapObjectCategoryType.historicalPlace,
    ),
    const LatLng(47.558293926343616, 9.65924219808936),
  ),
  MapObject(
    "Buchenwäldle",
    mapObjectCategories.getObjectByCategory(
      MapObjectCategoryType.historicalPlace,
    ),
    const LatLng(47.55795636758571, 9.658321044197328),
  ),
  MapObject(
    "Friedenssäule",
    mapObjectCategories.getObjectByCategory(
      MapObjectCategoryType.historicalPlace,
    ),
    const LatLng(47.55681531949221, 9.661631534605224),
  ),
  MapObject(
    "Seeschlössle",
    mapObjectCategories.getObjectByCategory(
      MapObjectCategoryType.historicalPlace,
    ),
    const LatLng(47.55728735540322, 9.662609679084067),
  ),
];

/// Orte und alle Bäume des Katasters.
List<MapObject> get allMapObjects => [...mapObjects, ...treeMapObjects()];

List<MapObject>? _treeMapObjects;

List<MapObject> treeMapObjects() => _treeMapObjects ??= _buildTreeMapObjects();

List<MapObject> _buildTreeMapObjects() {
  final category = mapObjectCategories.getObjectByCategory(
    MapObjectCategoryType.tree,
  );
  return [
    for (final tree in treeCatalog.trees)
      MapObject(
        TreeKnowledge.nameOf(tree),
        category,
        tree.location,
        treeId: tree.id,
        keywords: tree.latinName,
      ),
  ];
}
