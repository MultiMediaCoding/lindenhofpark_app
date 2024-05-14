import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/PlacesList/FilterBox/view/category_picker.dart';
import 'package:lindenhofpark/PlacesList/FilterBox/view/search_field.dart';
import 'package:lindenhofpark/PlacesList/view/places_list_item.dart';
import 'package:lindenhofpark/PlacesList/view_model/places_list_view_model.dart';
import 'package:provider/provider.dart';

class PlacesListView extends StatelessWidget {
  PlacesListView({super.key});

  final _backgroundColor = Colors.grey.withOpacity(0.3);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlacesListViewModel(),
      child: Scaffold(
        backgroundColor: _backgroundColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            shrinkWrap: false,
            children: [
              const SearchField(),
              const SizedBox(
                height: 10,
              ),
              const CategoryPicker(),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 20,
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    Consumer<PlacesListViewModel>(
                      builder: (context, viewModel, child) {
                        return Column(
                          children: [
                            for (MapObject mapObject
                                in viewModel.filteredMapObjects) ...[
                              PlacesListItem(mapObject: mapObject),
                            ]
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
      ),
    );
  }
}
