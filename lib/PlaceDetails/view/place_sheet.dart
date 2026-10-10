import 'package:flutter/material.dart';
import 'package:lindenhofpark/BiologicalFacts/model/biolocial_fact.dart';
import 'package:lindenhofpark/Common/view/native_glass.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/model/map_object_category.dart';
import 'package:lindenhofpark/PlaceDetails/model/historical_places/historical_place.dart';
import 'package:lindenhofpark/PlaceDetails/model/historical_places/historical_places.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/leaf_type.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/leave_types.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/park_tree.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree_catalog.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree_knowledge.dart';
import 'package:lindenhofpark/PlaceDetails/view/glass_card.dart';

String _meters(double value) => value.toStringAsFixed(value % 1 == 0 ? 0 : 1);

/// Detailblatt über der Karte: Liquid-Glass-Sheet mit zwei Rasten (klein /
/// groß); die Karte dahinter bleibt bedienbar.
class PlaceSheet extends StatelessWidget {
  const PlaceSheet({super.key, required this.mapObject, required this.onClose});

  final MapObject mapObject;
  final VoidCallback onClose;

  static const double _small = 0.45;
  static const double _large = 0.93;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    return Positioned(
      left: 10,
      right: 10,
      top: 0,
      bottom: 0,
      child: DraggableScrollableSheet(
        key: ValueKey(mapObject),
        initialChildSize: _small,
        minChildSize: _small,
        maxChildSize: _large,
        snap: true,
        snapSizes: const [_small, _large],
        builder: (context, scrollController) => NativeGlass(
          radius: 40,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(child: _Header(onClose: onClose)),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, bottomInset + 24),
                sliver: SliverToBoxAdapter(child: _content()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _content() {
    if (mapObject.category.category == MapObjectCategoryType.tree) {
      return _TreeContent(tree: treeCatalog.byId(mapObject.treeId!)!);
    }
    return _PlaceContent(
        place: historicalPlaces.getHistoricalPlaceByTitle(mapObject.title));
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 36,
            height: 5,
            decoration: BoxDecoration(
              color: sheetInk.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Positioned(
            right: 12,
            top: 8,
            child: Semantics(
              label: "Schließen",
              button: true,
              child: GestureDetector(
                onTap: onClose,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: sheetInk.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, size: 17, color: sheetInkSoft),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: AspectRatio(
          aspectRatio: 16 / 10,
          child: Image.asset(image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                  color: sheetInk)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(fontSize: 17, color: sheetInkSoft)),
        ],
      ),
    );
  }
}

class _TreeContent extends StatelessWidget {
  const _TreeContent({required this.tree});

  final ParkTree tree;

  @override
  Widget build(BuildContext context) {
    final specimen = TreeKnowledge.specimen(tree);
    final facts = TreeKnowledge.factsOf(tree);
    final image = TreeKnowledge.imageOf(tree);
    final leaves = leaveTypes[tree.isNeedle ? LeafType.needle : LeafType.broud];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (image != null) _Hero(image: image),
        _Title(title: TreeKnowledge.nameOf(tree), subtitle: tree.latinName),
        InfoRows(rows: [
          if (specimen?.age != null)
            ("Alter", "${specimen!.age} Jahre")
          else
            ("Alter", tree.ageStage),
          ("Höhe", "${_meters(specimen?.height.toDouble() ?? tree.height)} m"),
          ("Krone", "${_meters(tree.crownDiameter)} m Durchmesser"),
          ("Stammumfang", "${_meters(tree.trunkCircumferenceCm / 100)} m"),
          ("Blätter", leaves ?? ""),
          if (specimen != null) ("Herkunft", specimen.origin),
          ("Standort", tree.parcel),
          ("Baumplakette", tree.id),
        ]),
        if (facts.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 22, 8, 10),
            child: Text("Wissenswertes",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: sheetInk)),
          ),
          for (final fact in facts) ...[
            _FactCard(fact: fact),
            const SizedBox(height: 10),
          ],
        ],
      ],
    );
  }
}

class _FactCard extends StatelessWidget {
  const _FactCard({required this.fact});

  final BiologicalFact fact;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (fact.images.isNotEmpty) ...[
            Row(
              spacing: 8,
              children: [
                for (final image in fact.images.take(2))
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                          height: 110,
                          child: Image.asset(image, fit: BoxFit.cover)),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 14),
          ],
          Text(fact.title,
              style: const TextStyle(
                  fontSize: 17, fontWeight: FontWeight.w700, color: sheetInk)),
          const SizedBox(height: 4),
          Text(fact.content,
              style: const TextStyle(
                  fontSize: 16, height: 1.35, color: sheetInk)),
        ],
      ),
    );
  }
}

class _PlaceContent extends StatelessWidget {
  const _PlaceContent({required this.place});

  final HistoricalPlace place;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Hero(image: place.image),
        _Title(title: place.title, subtitle: "Historischer Ort"),
        GlassCard(
          padding: const EdgeInsets.all(18),
          child: Text(place.description,
              style: const TextStyle(
                  fontSize: 16, height: 1.4, color: sheetInk)),
        ),
      ],
    );
  }
}
