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
import 'package:lindenhofpark/PlaceDetails/view/fact_symbol.dart';
import 'package:lindenhofpark/PlaceDetails/view/glass_card.dart';

String _meters(double value) => value.toStringAsFixed(value % 1 == 0 ? 0 : 1);

/// Detailblatt über der Karte: Liquid-Glass-Sheet mit zwei Rasten (klein /
/// groß); die Karte dahinter bleibt bedienbar.
class PlaceSheet extends StatefulWidget {
  const PlaceSheet({super.key, required this.mapObject, required this.onClose});

  final MapObject mapObject;
  final VoidCallback onClose;

  @override
  State<PlaceSheet> createState() => _PlaceSheetState();
}

class _PlaceSheetState extends State<PlaceSheet> {
  static const double _min = 0.2;
  static const double _small = 0.45;
  static const double _large = 0.93;

  final _controller = DraggableScrollableController();
  bool _closing = false;

  MapObject get mapObject => widget.mapObject;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _close() {
    if (_closing) return;
    _closing = true;
    widget.onClose();
  }

  /// Zieher am Griff: das Blatt folgt dem Finger, beim Loslassen rastet es auf
  /// die nächste Stufe ein oder schließt sich, wenn es tief genug gezogen ist.
  void _dragHandle(double deltaY, double height) {
    if (!_controller.isAttached) return;
    _controller.jumpTo(
      (_controller.size - deltaY / height).clamp(_min, _large),
    );
  }

  void _releaseHandle(double velocityY, double height) {
    if (!_controller.isAttached) return;
    final size = _controller.size;
    final flick = velocityY / height; // Anteile der Höhe pro Sekunde
    final target = flick.abs() > 0.8
        ? (flick > 0
              ? (size > _small ? _small : _min)
              : (size < _small ? _small : _large))
        : [
            _min,
            _small,
            _large,
          ].reduce((a, b) => (a - size).abs() < (b - size).abs() ? a : b);
    if (target == _min) {
      _close();
    } else {
      _controller.animateTo(
        target,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    return Positioned(
      left: 10,
      right: 10,
      top: 0,
      bottom: 0,
      child: LayoutBuilder(
        builder: (context, constraints) => DraggableScrollableSheet(
          controller: _controller,
          initialChildSize: _small,
          minChildSize: _min,
          maxChildSize: _large,
          snap: true,
          snapSizes: const [_small, _large],
          builder: (context, scrollController) =>
              NotificationListener<DraggableScrollableNotification>(
                onNotification: (n) {
                  if (n.extent <= _min + 0.001) _close();
                  return false;
                },
                child: NativeGlass(
                  radius: 32,
                  child: DefaultTextStyle.merge(
                    style: const TextStyle(fontFamily: sheetFont),
                    child: CustomScrollView(
                      controller: scrollController,
                      physics: const ClampingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: _Header(
                            onClose: widget.onClose,
                            onDrag: (dy) =>
                                _dragHandle(dy, constraints.maxHeight),
                            onRelease: (v) =>
                                _releaseHandle(v, constraints.maxHeight),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(
                            16,
                            0,
                            16,
                            bottomInset + 24,
                          ),
                          sliver: SliverToBoxAdapter(child: _content()),
                        ),
                      ],
                    ),
                  ),
                ),
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
      place: historicalPlaces.getHistoricalPlaceByTitle(mapObject.title),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.onClose,
    required this.onDrag,
    required this.onRelease,
  });

  final VoidCallback onClose;
  final ValueChanged<double> onDrag;
  final ValueChanged<double> onRelease;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragUpdate: (d) => onDrag(d.delta.dy),
              onVerticalDragEnd: (d) =>
                  onRelease(d.velocity.pixelsPerSecond.dy),
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Container(
                    width: 57,
                    height: 3.5,
                    decoration: BoxDecoration(
                      color: sheetInk.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 12,
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

/// Maße aus Apple Karten (Punkte): Foto 4:3, 23 Seitenrand, Ecken 22.
class _Hero extends StatelessWidget {
  const _Hero({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 0, 7, 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: Image.asset(image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

/// Titel wie in Apple Karten: groß, normal stark, breite Schrift.
class _Title extends StatelessWidget {
  const _Title({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 0, 7, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              height: 1.1,
              letterSpacing: 0.2,
              fontFamily: sheetTitleFont,
              fontVariations: [FontVariation('wdth', 125)],
              color: sheetInk,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 15,
              height: 1.2,
              color: sheetInkSoft,
            ),
          ),
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
        InfoRows(
          rows: [
            if (specimen?.age != null)
              ("Alter", "${specimen!.age} Jahre")
            else
              ("Alter", tree.ageStage),
            (
              "Höhe",
              "${_meters(specimen?.height.toDouble() ?? tree.height)} m",
            ),
            ("Krone", "${_meters(tree.crownDiameter)} m Durchmesser"),
            ("Stammumfang", "${_meters(tree.trunkCircumferenceCm / 100)} m"),
            ("Blätter", leaves ?? ""),
            if (specimen != null) ("Herkunft", specimen.origin),
            ("Standort", tree.parcel),
            ("Baumplakette", tree.id),
          ],
        ),
        if (facts.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.fromLTRB(7, 14, 7, 12),
            child: Text(
              "Wissenswertes",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: sheetInk,
              ),
            ),
          ),
          for (final fact in facts) ...[
            _FactCard(fact: fact),
            const SizedBox(height: 16),
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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
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
                      borderRadius: BorderRadius.circular(14),
                      child: SizedBox(
                        height: 110,
                        child: Image.asset(image, fit: BoxFit.cover),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 14),
          ],
          Row(
            spacing: 12,
            children: [
              FactSymbol(title: fact.title),
              Expanded(
                child: Text(
                  fact.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: sheetInk,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 25,
            thickness: 0.5,
            color: sheetInk.withValues(alpha: 0.18),
          ),
          Text(
            fact.content,
            style: const TextStyle(fontSize: 17, height: 1.25, color: sheetInk),
          ),
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
          child: Text(
            place.description,
            style: const TextStyle(fontSize: 16, height: 1.4, color: sheetInk),
          ),
        ),
      ],
    );
  }
}
