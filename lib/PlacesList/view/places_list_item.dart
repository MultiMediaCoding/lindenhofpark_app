import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lindenhofpark/Common/view/vector_icon.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/PlaceDetails/view/place_details_view.dart';

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
          mapObject.category.categoryName,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
        leading: VectorIcon(
            icon: mapObject.category.icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary),
        onTap: () => openMapObjectInDetailsView(mapObject, context),
      ),
    );
  }

  void openMapObjectInDetailsView(MapObject mapObject, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlaceDetailsView(mapObject: mapObject)));
  }
}
