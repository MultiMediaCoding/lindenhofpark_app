import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/model/map_object_category.dart';
import 'package:lindenhofpark/Map/model/map_objects.dart';
import 'package:lindenhofpark/Map/model/position_locator.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree_knowledge.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Steuert die 3D-Karte (`assets/map3d/index.html`, three.js im WebView).
///
/// Flutter ruft `ParkApp.*` im Seitenskript auf; die Seite meldet über den
/// Kanal `ParkChannel` JSON-Ereignisse zurück:
/// `ready`, `tree {id}`, `place {title}`, `deselect`, `heading {deg}`, `outside`.
class MapViewModel extends ChangeNotifier {
  MapViewModel({this.onTreeTapped, this.onPlaceTapped, this.onDeselected, this.onOutsidePark}) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF3F2EC))
      ..addJavaScriptChannel('ParkChannel', onMessageReceived: _onMessage)
      ..loadFlutterAsset('assets/map3d/index.html');
    _startLocation();
  }

  late final WebViewController controller;

  final ValueChanged<String>? onTreeTapped;
  final ValueChanged<String>? onPlaceTapped;
  final VoidCallback? onDeselected;
  final VoidCallback? onOutsidePark;

  /// Drehung der Karte in Grad (0 = Norden oben), für den Kompass.
  double heading = 0;
  bool is3D = true;
  bool isNight = false;

  bool _ready = false;
  Position? _position;
  StreamSubscription<Position>? _positionSubscription;

  void _onMessage(JavaScriptMessage message) {
    final event = jsonDecode(message.message) as Map<String, dynamic>;
    switch (event['t']) {
      case 'ready':
        _ready = true;
        _run('ParkApp.setPlaces(${jsonEncode(_places())})');
        _run('ParkApp.setStars(${jsonEncode(curatedTreeIds.values.toList())})');
        if (_position != null) _sendPosition(_position!);
      case 'tree':
        onTreeTapped?.call(event['id'] as String);
      case 'place':
        onPlaceTapped?.call(event['title'] as String);
      case 'deselect':
        onDeselected?.call();
      case 'heading':
        heading = (event['deg'] as num).toDouble();
        notifyListeners();
      case 'tilt':
        is3D = event['on'] as bool;
        notifyListeners();
      case 'outside':
        onOutsidePark?.call();
    }
  }

  List<Map<String, Object>> _places() => [
        for (final o in mapObjects)
          if (o.category.category == MapObjectCategoryType.historicalPlace)
            {
              'title': o.title,
              'lat': o.location.latitude,
              'lon': o.location.longitude,
            },
      ];

  Future<void> _startLocation() async {
    try {
      _position = await PositionLocator().determinePosition();
      _sendPosition(_position!);
      _positionSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 3,
        ),
      ).listen((position) {
        _position = position;
        _sendPosition(position);
      }, onError: (_) {});
    } catch (_) {
      // Ohne Standort bleibt die Karte voll nutzbar, nur ohne blauen Punkt.
    }
  }

  void _sendPosition(Position p) {
    if (_ready) _run('ParkApp.setLocation(${p.latitude}, ${p.longitude})');
  }

  void _run(String js) => controller.runJavaScript(js);

  void locate() => _run('ParkApp.locate()');

  void resetNorth() => _run('ParkApp.resetNorth()');

  void toggleTilt() {
    is3D = !is3D;
    _run('ParkApp.toggleTilt()');
    notifyListeners();
  }

  void toggleNight() {
    isNight = !isNight;
    _run('ParkApp.setNight($isNight)');
    notifyListeners();
  }

  void selectTree(String id) => _run('ParkApp.selectTree(${jsonEncode(id)})');

  void selectPlace(String title) =>
      _run('ParkApp.selectPlace(${jsonEncode(title)})');

  /// Hebt die Hervorhebung auf, wenn ein Detailblatt geschlossen wurde.
  void clearSelection() => _run('ParkApp.clearSelection()');

  MapObject? mapObjectForTree(String id) {
    for (final o in treeMapObjects()) {
      if (o.treeId == id) return o;
    }
    return null;
  }

  MapObject? mapObjectForPlace(String title) {
    for (final o in mapObjects) {
      if (o.title == title) return o;
    }
    return null;
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }
}
