import 'package:latlong2/latlong.dart';
import 'package:lindenhofpark/MapView/map_object_category.dart';

class MapObject {
  final String title;
  final MapObjectCategory category;
  final LatLng location;
  final String imagePath;

  MapObject(this.title, this.category, this.location, this.imagePath);
}
