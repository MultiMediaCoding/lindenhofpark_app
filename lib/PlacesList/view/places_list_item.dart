import 'package:flutter/material.dart';
import 'package:lindenhofpark/Common/view/vector_icon.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/view_model/selection.dart';

class PlacesListItem extends StatelessWidget {
  const PlacesListItem({super.key, required this.mapObject});

  final MapObject mapObject;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2),
      height: 60,
      child: ListTile(
        title:
            Text(mapObject.title, style: Theme.of(context).textTheme.bodyLarge),
        subtitle: Text(
          mapObject.subtitle == null
              ? mapObject.category.categoryName
              : "${mapObject.category.categoryName} · ${mapObject.subtitle}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
        leading: VectorIcon(
            icon: mapObject.category.icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary),
        onTap: () => select(mapObject, context),
      ),
    );
  }

  /// Schließt die Suche und wählt den Ort auf der Karte aus.
  void select(MapObject mapObject, BuildContext context) {
    Navigator.of(context).pop();
    selectedMapObject.value = mapObject;
  }
}
