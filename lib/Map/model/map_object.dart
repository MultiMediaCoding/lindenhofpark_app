import 'package:latlong2/latlong.dart';
import 'package:lindenhofpark/Map/model/map_object_category.dart';

class MapObject {
  final String title;
  final MapObjectCategory category;
  final LatLng location;

  /// Plakettennummer, wenn das Objekt ein Baum aus dem Kataster ist. Titel
  /// sind bei Bäumen nicht eindeutig (es gibt 100 Winter-Linden).
  final String? treeId;

  /// Zusatzzeile in der Liste, z. B. die Parzelle eines Baums.
  final String? subtitle;

  /// Zusätzliche Suchbegriffe, z. B. der lateinische Name.
  final String keywords;

  MapObject(
    this.title,
    this.category,
    this.location, {
    this.treeId,
    this.subtitle,
    this.keywords = "",
  });
}
