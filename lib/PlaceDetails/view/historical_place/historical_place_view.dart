import 'package:flutter/material.dart';
import 'package:lindenhofpark/Common/view/small_space.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/PlaceDetails/common/view/back_button.dart';
import 'package:lindenhofpark/PlaceDetails/common/view/draggable_sheet.dart';
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
            "assets/images/trees/sample_tree.jpeg",
            fit: BoxFit.cover,
          ),
        ),
        NavigationBackButton(),
        DraggableSheet(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                historicalPlace.title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "Historischer Ort",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SmallSpace(),
              Text(historicalPlace.description),
            ],
          ),
        ),
      ],
    );
  }
}
