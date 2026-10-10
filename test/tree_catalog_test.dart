import 'package:flutter_test/flutter_test.dart';
import 'package:lindenhofpark/Map/model/map_objects.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree_catalog.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree_knowledge.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/trees.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await loadTreeCatalog();
  });

  test('catalog holds every tree with a unique id', () {
    expect(treeCatalog.trees.length, 476);
    expect(treeCatalog.trees.map((t) => t.id).toSet().length, 476);
  });

  test('every curated tree points at a catalog tree of the same species', () {
    for (final tree in trees) {
      final id = curatedTreeIds[tree.title];
      expect(id, isNotNull, reason: '${tree.title} has no catalog id');
      final parkTree = treeCatalog.byId(id!);
      expect(parkTree, isNotNull, reason: '$id missing in catalog');
      expect(parkTree!.latinName.toLowerCase(), tree.latinName.toLowerCase());
      expect(TreeKnowledge.specimen(parkTree)?.title, tree.title);
    }
  });

  test('other trees of a curated species get species facts, not specimen ones',
      () {
    final other = treeCatalog.trees.firstWhere((t) =>
        t.latinName == 'Fagus sylvatica' && t.id != curatedTreeIds['Rotbuche']);
    final titles = TreeKnowledge.factsOf(other).map((f) => f.title);
    expect(titles, contains('Borke'));
    expect(titles, isNot(contains('Fledermauskasten')));
    final own = treeCatalog.byId(curatedTreeIds['Rotbuche']!)!;
    expect(TreeKnowledge.factsOf(own).map((f) => f.title),
        contains('Fledermauskasten'));
  });

  test('coordinates land in the park', () {
    for (final tree in treeCatalog.trees) {
      expect(tree.location.latitude, inInclusiveRange(47.553, 47.561));
      expect(tree.location.longitude, inInclusiveRange(9.655, 9.666));
    }
  });

  test('every tree is on the map list', () {
    expect(allMapObjects.where((o) => o.treeId != null).length, 476);
  });
}
