import 'package:latlong2/latlong.dart';
import 'package:lindenhofpark/Map/model/map_object_category.dart';

class MapObject {
  final String title;
  final String imagePath;
  final MapObjectCategory category;
  final LatLng location;

  MapObject(this.title, this.imagePath, this.category, this.location);
}
