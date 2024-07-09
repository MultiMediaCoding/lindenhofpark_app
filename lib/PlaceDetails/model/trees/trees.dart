import 'package:lindenhofpark/BiologicalFacts/model/biolocial_fact.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/leaf_type.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree.dart';

final List<Tree> trees = [
  Tree("Urweltmammutbaum", "sample_tree.jpeg", "Metasequoia glyptostroboides",
      24, null, "China", LeafType.needle, [
    BiolocialFact(
        title: "Schuppenborke",
        content:
            """Die Schuppenborke ist eine besondere Rindenstruktur bei Bäumen, die aus mehreren übereinanderliegenden Schichten besteht und sich im Laufe der Zeit ablöst. Diese Form der Borke dient dem Baum als Schutz vor äußeren Einflüssen wie Schädlingen und Krankheiten.""",
        images: [
          "assets/images/trees/sample_tree.jpeg",
          "assets/images/trees/sample_tree.jpeg"
        ]),
    BiolocialFact(
        title: "Borke",
        content:
            """Die Schuppenborke ist eine besondere Rindenstruktur bei Bäumen, die aus mehreren übereinanderliegenden Schichten besteht und sich im Laufe der Zeit ablöst. Diese Form der Borke dient dem Baum als Schutz vor äußeren Einflüssen wie Schädlingen und Krankheiten.""",
        images: [
          "assets/images/trees/sample_tree.jpeg",
          "assets/images/trees/sample_tree.jpeg"
        ]),
  ]),
  Tree("Bergahorn", "sample_tree.jpeg", "Acer pseudoplatanos", 30,
      DateTime(1846, 01, 01), "Schneehalde", LeafType.needle, []),
  Tree("Roteiche", "sample_tree.jpeg", "Quercus rubra", 21,
      DateTime(1846, 01, 01), "Schneehalde", LeafType.needle, []),
];
