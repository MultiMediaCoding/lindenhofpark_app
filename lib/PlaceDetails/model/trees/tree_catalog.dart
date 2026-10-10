import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/park_tree.dart';

/// Alle Bäume des Parks. Die Daten liegen genau einmal vor, in
/// `assets/map3d/data.js`; dieselbe Datei zeichnet auch die 3D-Karte.
class TreeCatalog {
  TreeCatalog(this.trees) : _byId = {for (final t in trees) t.id: t};

  static const assetPath = 'assets/map3d/data.js';

  final List<ParkTree> trees;
  final Map<String, ParkTree> _byId;

  ParkTree? byId(String id) => _byId[id];

  static Future<TreeCatalog> load() async =>
      TreeCatalog.parse(await rootBundle.loadString(assetPath));

  /// `data.js` ist `var DATA = {...};`: nur das JSON-Objekt wird gelesen.
  /// Baumzeile: [Plakette, Art, x, y, Höhe, Krone, Stammhöhe, Umfang cm,
  /// Altersstufe, Parzelle]; Art: [Name, lat. Name, Wuchsform, Nadelbaum].
  factory TreeCatalog.parse(String source) {
    final data = jsonDecode(
            source.substring(source.indexOf('{'), source.lastIndexOf('}') + 1))
        as Map<String, dynamic>;
    final species = data['species'] as List;
    final ages = data['age'] as List;
    final parcels = data['parz'] as List;
    return TreeCatalog([
      for (final row in data['trees'] as List)
        ParkTree(
          id: row[0] as String,
          name: (species[row[1] as int] as List)[0] as String,
          latinName: (species[row[1] as int] as List)[1] as String,
          isNeedle: (species[row[1] as int] as List)[3] == 1,
          x: (row[2] as num).toDouble(),
          y: (row[3] as num).toDouble(),
          height: (row[4] as num).toDouble(),
          crownDiameter: (row[5] as num).toDouble(),
          trunkCircumferenceCm: (row[7] as num).toDouble(),
          ageStage: ages[row[8] as int] as String,
          parcel: parcels[row[9] as int] as String,
        ),
    ]);
  }
}

late TreeCatalog treeCatalog;

Future<void> loadTreeCatalog() async {
  treeCatalog = await TreeCatalog.load();
}
