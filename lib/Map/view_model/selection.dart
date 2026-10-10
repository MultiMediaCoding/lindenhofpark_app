import 'package:flutter/foundation.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';

/// Der gerade gewählte Baum oder Ort. Karte, Detailblatt und Suchliste
/// lesen und schreiben ihn gemeinsam.
final ValueNotifier<MapObject?> selectedMapObject = ValueNotifier(null);
