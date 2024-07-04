import 'package:lindenhofpark/Home/view/SearchButton.dart';
import 'package:lindenhofpark/Map/view/map_view.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/PlaceDetails/common/view/sheet/draggable_sheet.dart';
import 'package:lindenhofpark/PlacesList/view/places_list_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapView(),
          SearchButton(),
        ],
      ),
    );
  }
}
