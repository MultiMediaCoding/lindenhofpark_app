import 'package:latlong2/latlong.dart';

/// Ursprung und Meter-pro-Grad des Park-Koordinatensystems der 3D-Karte
/// (`assets/map3d/index.html`: LAT0, LON0, KX, KY).
const double _originLatitude = 47.55735;
const double _originLongitude = 9.6614;
const double _metersPerDegreeLongitude = 75130;
const double _metersPerDegreeLatitude = 111320;

/// Ein Baum aus dem Baumkataster der GTL (Stand 2023).
class ParkTree {
  const ParkTree({
    required this.id,
    required this.name,
    required this.latinName,
    required this.isNeedle,
    required this.x,
    required this.y,
    required this.height,
    required this.crownDiameter,
    required this.trunkCircumferenceCm,
    required this.ageStage,
    required this.parcel,
  });

  /// Plakettennummer, z. B. "000122". Eindeutig und stabil.
  final String id;
  final String name;
  final String latinName;
  final bool isNeedle;

  /// Meter östlich / nördlich vom Ursprung des Park-Koordinatensystems.
  final double x;
  final double y;

  /// Meter.
  final double height;
  final double crownDiameter;
  final double trunkCircumferenceCm;

  /// "Jungbaum", "Reifephase", "Alterungsphase" oder "Altbaum".
  final String ageStage;
  final String parcel;

  LatLng get location => LatLng(
    _originLatitude + y / _metersPerDegreeLatitude,
    _originLongitude + x / _metersPerDegreeLongitude,
  );

  double get trunkDiameterM => trunkCircumferenceCm / 100 / 3.141592653589793;
}
