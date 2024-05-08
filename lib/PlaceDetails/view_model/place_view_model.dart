import 'package:flutter/material.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/model/map_object_categories.dart';
import 'package:lindenhofpark/Map/model/map_object_category.dart';
import 'package:lindenhofpark/PlaceDetails/model/historical_places/historical_place.dart';
import 'package:lindenhofpark/PlaceDetails/model/historical_places/historical_places.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/trees.dart';
import 'package:lindenhofpark/PlaceDetails/view/historical_place/historical_place_view.dart';
import 'package:lindenhofpark/PlaceDetails/view/tree/tree_view.dart';

class PlaceViewModel {
  Widget getViewOfMapObject(MapObject mapObject) {
    if (mapObject.category ==
        mapObjectCategories.getObjectByCategory(MapObjectCategoryType.tree)) {
      return TreeView(
          mapObject: mapObject, tree: trees.getTreeByTitle(mapObject.title));
    } else if (mapObject.category ==
        mapObjectCategories
            .getObjectByCategory(MapObjectCategoryType.historicalPlace)) {
      return HistoricalPlaceView(
          mapObject: mapObject,
          historicalPlace:
              historical_places.getHistoricalPlaceByTitle(mapObject.title));
    }

    return Container();
  }
}
