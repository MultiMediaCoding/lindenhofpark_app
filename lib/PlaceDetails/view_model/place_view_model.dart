import 'package:flutter/material.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/model/map_object_categories.dart';
import 'package:lindenhofpark/Map/model/map_object_category.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/trees.dart';
import 'package:lindenhofpark/PlaceDetails/view/tree/tree_view.dart';

class PlaceViewModel {
  Widget getViewOfMapObject(MapObject mapObject) {
    // Map Object is a tree
    if (mapObject.category ==
        mapObjectCategories.getObjectByCategory(MapObjectCategoryType.tree)) {
      return TreeView(
          mapObject: mapObject, tree: trees.getTreeByTitle(mapObject.title));
    }

    return Container();
  }
}
