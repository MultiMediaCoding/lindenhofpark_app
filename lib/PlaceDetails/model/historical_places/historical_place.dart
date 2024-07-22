import 'package:lindenhofpark/PlaceDetails/model/historical_places/historical_places.dart';

class HistoricalPlace {
  final String title;
  final String image;
  final String description;

  HistoricalPlace(this.title, this.image, this.description);
}

extension HistoricalPlaceObjectListExtension on List<HistoricalPlace> {
  HistoricalPlace getHistoricalPlaceByTitle(String title) {
    return firstWhere((place) => place.title == title,
        orElse: () => historical_places.first);
  }
}
