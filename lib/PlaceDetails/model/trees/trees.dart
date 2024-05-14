import 'package:lindenhofpark/PlaceDetails/model/trees/leaf_type.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree.dart';

final List<Tree> trees = [
  Tree("Urweltmammutbaum", "sample_tree.jpeg", "Metasequoia glyptostroboides",
      24, null, "China", LeafType.needle),
  Tree("Bergahorn", "sample_tree.jpeg", "Acer pseudoplatanos", 30,
      DateTime(1846, 01, 01), "Schneehalde", LeafType.needle),
  Tree("Roteiche", "sample_tree.jpeg", "Quercus rubra", 21,
      DateTime(1846, 01, 01), "Schneehalde", LeafType.needle),
  Tree("Urweltmammutbaum", "sample_tree.jpeg", "Metasequoia glyptostroboide",
      25, DateTime(1971, 01, 01), "Schneehalde", LeafType.needle),
  Tree("Weihrauchzeder", "sample_tree.jpeg", "Calocedrus decurrens", 33,
      DateTime(1846, 01, 01), "Finnland", LeafType.needle),
  Tree("Douglasie", "sample_tree.jpeg", "Pseudotsuga menziesii", 35,
      DateTime(1846, 01, 01), "Schneehalde", LeafType.needle),
  Tree("Riesenlebensbaum", "sample_tree.jpeg", "Thuja plicata", 30,
      DateTime(1846, 01, 01), "Schneehalde", LeafType.needle),
  Tree("Schwarzkiefer", "sample_tree.jpeg", "Pinus nigra", 22,
      DateTime(1846, 01, 01), "Schneehalde", LeafType.needle),
  Tree("Schwarznuss", "sample_tree.jpeg", "Iuglans nigra", 22,
      DateTime(1846, 01, 01), "Schneehalde", LeafType.needle),
  Tree("Nordmann-Tanne", "sample_tree.jpeg", "Abies Nordmanniana", 33,
      DateTime(1846, 01, 01), "Schneehalde", LeafType.needle),
  Tree("Hängebirke", "sample_tree.jpeg", "Betula pendula", 30,
      DateTime(1901, 01, 01), "Schneehalde", LeafType.needle),
  Tree("Ahornplättrige Platane", "sample_tree.jpeg", "Platanus hispanica ", 32,
      DateTime(1851, 01, 01), "Schneehalde", LeafType.needle),
  Tree(
      "Urweltmammutbaum+älter",
      "sample_tree.jpeg",
      "Metasequoia glyptostroboide",
      23,
      DateTime(1846, 01, 01),
      "Schneehalde",
      LeafType.needle),
];
