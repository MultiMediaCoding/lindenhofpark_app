import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/model/map_objects.dart';
import 'package:lindenhofpark/Map/view/map_view.dart';
import 'package:lindenhofpark/Map/service/map_api_key.dart';

class MapViewModel {
  MapController controller = MapController();

  List<Marker> markers = [];

  final String mapUrl =
      "https://tiles-eu.stadiamaps.com/tiles/osm_bright/{z}/{x}/{y}{r}.png?api_key=$stadiaMapsApiKey";

  final lindenhofparkPosition = const LatLng(47.557868, 9.661412);
  static const LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 5,
  );

  final positionStream =
      Geolocator.getPositionStream(locationSettings: locationSettings);

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  MapViewModel() {
    for (MapObject mapObject in mapObjects) {
      final marker = Marker(
        width: 40,
        height: 40,
        point: mapObject.location,
        child: MapPin(mapObject: mapObject),
      );

      markers.add(marker);
    }
  }
}
