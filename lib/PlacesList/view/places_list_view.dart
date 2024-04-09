import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/PlacesList/FilterBox/view/filter_box.dart';
import 'package:lindenhofpark/PlacesList/view/places_list_item.dart';
import 'package:lindenhofpark/PlacesList/view_model/places_list_view_model.dart';
import 'package:provider/provider.dart';

class PlacesListView extends StatelessWidget {
  PlacesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlacesListViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Liste"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(CupertinoIcons.xmark))
          ],
        ),
        body: ListView(
          shrinkWrap: false,
          children: [
            Expanded(
              child: Wrap(
                spacing: 20,
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  const FilterBox(),
                  Consumer<PlacesListViewModel>(
                    builder: (context, viewModel, child) {
                      return Column(
                        children: [
                          for (MapObject mapObject
                              in viewModel.filteredMapObjects)
                            PlacesListItem(mapObject: mapObject)
                        ],
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
