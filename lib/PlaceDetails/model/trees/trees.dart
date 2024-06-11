import 'package:lindenhofpark/PlaceDetails/model/trees/leaf_type.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree.dart';

final List<Tree> trees = [
  Tree("Urweltmammutbaum", "sample_tree.jpeg", "Metasequoia glyptostroboides",
      24, null, "China", LeafType.needle, null),
  Tree("Bergahorn", "sample_tree.jpeg", "Acer pseudoplatanos", 30,
      DateTime(1846, 01, 01), "Schneehalde", LeafType.needle, null),
  Tree("Roteiche", "sample_tree.jpeg", "Quercus rubra", 21,
      DateTime(1846, 01, 01), "Schneehalde", LeafType.needle, null),
  Tree("Urweltmammutbaum", "sample_tree.jpeg", "Metasequoia glyptostroboide",
      25, DateTime(1971, 01, 01), "Schneehalde", LeafType.needle, null),
];
