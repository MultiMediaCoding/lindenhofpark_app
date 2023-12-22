import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/PlaceDetails/view_model/place_view_model.dart';

class PlaceDetailsView extends StatelessWidget {
  PlaceDetailsView({super.key, required this.mapObject});

  final MapObject mapObject;
  final PlaceViewModel viewModel = PlaceViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(CupertinoIcons.arrow_left)),
        ),
        body: viewModel.getViewOfMapObject(mapObject));
  }
}
