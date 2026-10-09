import 'package:flutter_test/flutter_test.dart';
import 'package:lindenhofpark/Map/model/map_object_category.dart';
import 'package:lindenhofpark/Map/model/map_objects.dart';
import 'package:lindenhofpark/PlaceDetails/model/historical_places/historical_places.dart';

void main() {
  test('every historical place on the map has matching details', () {
    final titles = historicalPlaces.map((place) => place.title).toSet();
    final mapPlaces = mapObjects.where(
        (o) => o.category.category == MapObjectCategoryType.historicalPlace);

    expect(mapPlaces, isNotEmpty);
    for (final mapPlace in mapPlaces) {
      expect(titles, contains(mapPlace.title));
    }
  });
}
