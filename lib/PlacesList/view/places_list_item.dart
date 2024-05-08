import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          width: 20,
          height: 20,
          child: ClipRect(
            child: SvgPicture.asset(mapObject.category.iconPath,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
          ),
        ),
        onTap: () => openMapObjectInDetailsView(mapObject, context),
      ),
    );
  }

  void openMapObjectInDetailsView(MapObject mapObject, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlaceDetailsView(mapObject: mapObject)));
  }
}
