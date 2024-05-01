import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/PlaceDetails/view/place_details_view.dart';

class PlacesListItem extends StatelessWidget {
  const PlacesListItem({super.key, required this.mapObject});

  final MapObject mapObject;

  @override
  Widget build(BuildContext context) {
    final widthWithPadding = MediaQuery.of(context).size.width - 10;
    return Container(
      width: widthWithPadding,
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
        leading: SizedBox(
          width: 50,
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              mapObject.imagePath,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        trailing: const Icon(CupertinoIcons.chevron_right),
        onTap: () => openMapObjectInDetailsView(mapObject, context),
      ),
    );
  }

  void openMapObjectInDetailsView(MapObject mapObject, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlaceDetailsView(mapObject: mapObject)));
  }
}
