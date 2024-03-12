import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:lindenhofpark/Map/model/map_styler.dart';
import 'package:lindenhofpark/Map/model/position_locator.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/model/map_objects.dart';
import 'package:lindenhofpark/Map/view/map_view.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

class MapViewModel extends ChangeNotifier {
  MapController controller = MapController();

  final lindenhofparkPosition = const LatLng(47.557868, 9.661412);

  // Map Style
  Style? style;
  Object? error;

  List<Marker> markers = [];

  final positionLocator = PositionLocator();
  static const LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 5,
  );
  final positionStream =
      Geolocator.getPositionStream(locationSettings: locationSettings);

  Future _initStyle() async {
    try {
      style = await MapStyler().readStyle();
    } catch (e, stack) {
      // ignore: avoid_print
      print(e);
      // ignore: avoid_print
      print(stack);
      error = e;
    }
    notifyListeners();
  }

  void _initMarkers() {
    for (MapObject mapObject in mapObjects) {
      final marker = Marker(
        width: 40,
        height: 40,
        point: mapObject.location,
        child: MapPin(mapObject: mapObject),
      );

      markers.add(marker);
    }
    notifyListeners();
  }

  void determinePosition() {
    positionLocator.determinePosition();
  }

  MapViewModel() {
    _initMarkers();
    _initStyle();
    determinePosition();
  }
}
