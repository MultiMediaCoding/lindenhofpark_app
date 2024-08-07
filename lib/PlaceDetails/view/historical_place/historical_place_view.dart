import 'package:flutter/material.dart';
import 'package:lindenhofpark/Common/view/big_space.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/PlaceDetails/common/view/back_button.dart';
import 'package:lindenhofpark/PlaceDetails/common/view/sheet/draggable_sheet.dart';
import 'package:lindenhofpark/PlaceDetails/model/historical_places/historical_place.dart';

class HistoricalPlaceView extends StatelessWidget {
  const HistoricalPlaceView(
      {super.key, required this.mapObject, required this.historicalPlace});

  final MapObject mapObject;
  final HistoricalPlace historicalPlace;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            historicalPlace.image,
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(child: NavigationBackButton()),
        DraggableSheet(
          stops: [0.4, 0.9],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                historicalPlace.title,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text(
                "Historischer Ort",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              const BigSpace(),
              Text(historicalPlace.description, style: TextStyle(fontSize: 18)),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ],
    );
  }
}
