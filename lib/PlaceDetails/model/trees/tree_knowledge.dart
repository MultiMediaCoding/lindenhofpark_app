import 'package:lindenhofpark/BiologicalFacts/model/biolocial_fact.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/park_tree.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/trees.dart';

/// Von Hand gepflegte Bäume ([trees]) und ihr Baum im Kataster (Plakette).
/// Zugeordnet über die Koordinaten der alten Kartenmarker; passte die Art
/// dort nicht, gilt der nächste Baum derselben Art.
const Map<String, String> curatedTreeIds = {
  'Rotbuche': '000486',
  'Urweltmammutbaum': '000030',
  'Schwarzkiefer': '000366',
  'Winterlinde': '000122',
  'Weihrauchzeder': '000160',
};

/// Führt Katasterdaten und handgepflegte Inhalte zusammen:
/// - der zugeordnete Baum zeigt alle seine Fakten, Foto, Herkunft, Pflanzjahr;
/// - jeder andere Baum derselben Art zeigt die artbezogenen Fakten und das
///   Foto der Art (nicht, was nur an einem einzelnen Baum gilt);
/// - alle übrigen Bäume zeigen nur die Katasterdaten.
class TreeKnowledge {
  const TreeKnowledge._();

  /// Der handgepflegte Eintrag genau dieses Baums.
  static Tree? specimen(ParkTree tree) {
    for (final entry in curatedTreeIds.entries) {
      if (entry.value == tree.id) return trees.getTreeByTitle(entry.key);
    }
    return null;
  }

  /// Der handgepflegte Eintrag der Art dieses Baums.
  static Tree? species(ParkTree tree) {
    final latin = tree.latinName.toLowerCase();
    for (final curated in trees) {
      if (curated.latinName.toLowerCase() == latin) return curated;
    }
    return null;
  }

  static String nameOf(ParkTree tree) =>
      (specimen(tree) ?? species(tree))?.title ?? tree.name;

  static String? imageOf(ParkTree tree) =>
      (specimen(tree) ?? species(tree))?.image;

  static List<BiologicalFact> factsOf(ParkTree tree) {
    final own = specimen(tree);
    if (own != null) return own.biologicalFacts;
    return species(tree)?.biologicalFacts
            .where((fact) => fact.speciesWide)
            .toList() ??
        const [];
  }
}
