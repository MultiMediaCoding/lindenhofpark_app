import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
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
///
/// Das Blatt hat eine feste Höhe und wird nur verschoben (`Transform`), damit
/// beim Ziehen weder Inhalt noch die native Glasfläche neu gelayoutet werden.
/// Das Einrasten läuft über eine Feder, die die Fingergeschwindigkeit
/// übernimmt; Ziehen am Inhalt, am Griff und Scrollen sind ein einziger
/// Gestenpfad.
class PlaceSheet extends StatefulWidget {
  const PlaceSheet({
    super.key,
    required this.mapObject,
    required this.visible,
    required this.onDismissed,
  });

  final MapObject mapObject;

  /// `false`: das Blatt fährt per Feder aus (Auswahl wurde aufgehoben).
  final bool visible;

  /// Das Blatt ist ganz heruntergefahren und kann entfernt werden.
  final VoidCallback onDismissed;

  @override
  State<PlaceSheet> createState() => _PlaceSheetState();
}

class _PlaceSheetState extends State<PlaceSheet>
    with SingleTickerProviderStateMixin {
  static const double _smallFraction = 0.45;
  static const double _largeFraction = 0.93;

  /// Unter dem Rand versteckter Überstand, damit die Feder über die große
  /// Raste hinausschwingen darf, ohne dass unten eine Lücke aufblitzt.
  static const double _overscan = 80;

  /// Etwa Apples Standardfeder (Response 0,4 s, Dämpfung 0,85).
  static const _spring = SpringDescription(
    mass: 1,
    stiffness: 250,
    damping: 27,
  );

  /// Sichtbare Höhe des Blatts in Punkten; wird direkt vom Controller
  /// getrieben (0 = ausgeblendet).
  late final AnimationController _extent = AnimationController.unbounded(
    vsync: this,
  );
  final _scroll = ScrollController();

  double _height = 0;
  int? _pointer;
  VelocityTracker? _tracker;
  bool _sheetDragged = false;
  bool _dismissing = false;
  double _lastDetent = 0;

  double get _small => _height * _smallFraction;
  double get _large => _height * _largeFraction;

  /// Scrollen im Inhalt ist gesperrt, solange das Blatt nicht ganz oben ist und
  /// für den Rest einer Geste, in der das Blatt bewegt wurde. So rutscht der
  /// Inhalt nicht mit, wenn man das Blatt nur hochzieht; gescrollt wird erst
  /// mit einer neuen Geste. (Das Flag bleibt bis zum nächsten Antippen stehen,
  /// damit auch das Nachlaufen nach dem Loslassen unterdrückt wird.)
  bool get _scrollBlocked => _sheetDragged || _extent.value < _large - 0.5;

  MapObject get mapObject => widget.mapObject;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _precacheHero();
      _lastDetent = _small;
      _animateTo(_small, 0);
    });
  }

  @override
  void didUpdateWidget(PlaceSheet old) {
    super.didUpdateWidget(old);
    if (old.mapObject != widget.mapObject) {
      if (_scroll.hasClients) _scroll.jumpTo(0);
      _precacheHero();
    }
    if (widget.visible && !old.visible) {
      _dismissing = false;
      if (_extent.value < _small) _animateTo(_small, 0);
    } else if (!widget.visible && old.visible) {
      _dismiss(haptic: false);
    }
  }

  @override
  void dispose() {
    _extent.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _precacheHero() {
    final path = _heroPath();
    if (path != null) precacheImage(_sheetImage(context, path), context);
  }

  String? _heroPath() {
    if (mapObject.category.category == MapObjectCategoryType.tree) {
      final tree = treeCatalog.byId(mapObject.treeId!);
      return tree == null ? null : TreeKnowledge.imageOf(tree);
    }
    return historicalPlaces.getHistoricalPlaceByTitle(mapObject.title).image;
  }

  void _animateTo(double target, double velocity) {
    _extent
        .animateWith(SpringSimulation(_spring, _extent.value, target, velocity))
        .then((_) {
          if (target == 0 && mounted && _dismissing) widget.onDismissed();
        });
  }

  void _dismiss({bool haptic = true}) {
    if (_dismissing) return;
    _dismissing = true;
    if (haptic) HapticFeedback.lightImpact();
    _animateTo(0, 0);
  }

  void _settle(double velocity) {
    final projected = _extent.value + velocity * 0.12;
    final target = [0.0, _small, _large].reduce(
      (a, b) => (a - projected).abs() < (b - projected).abs() ? a : b,
    );
    if (target == 0 || !widget.visible) {
      _dismiss();
      return;
    }
    if (target != _lastDetent) HapticFeedback.selectionClick();
    _lastDetent = target;
    _animateTo(target, velocity);
  }

  void _onDown(PointerDownEvent e) {
    if (_pointer != null) return;
    _pointer = e.pointer;
    _tracker = VelocityTracker.withKind(e.kind)
      ..addPosition(e.timeStamp, e.position);
    _sheetDragged = false;
    _dismissing = false;
    _extent.stop();
  }

  void _onMove(PointerMoveEvent e) {
    if (e.pointer != _pointer) return;
    _tracker?.addPosition(e.timeStamp, e.position);
    final dy = e.delta.dy;
    final atTop = !_scroll.hasClients || _scroll.offset <= 0.5;
    // Das Blatt nimmt die Bewegung, solange es nicht ganz oben ist oder der
    // Inhalt oben anliegt und nach unten gezogen wird (Scroll ist dann gesperrt
    // beziehungsweise geklemmt, siehe [_SheetScrollPhysics]).
    if (_extent.value < _large - 0.5 || (dy > 0 && atTop)) {
      _extent.value = (_extent.value - dy).clamp(0.0, _large);
      _sheetDragged = true;
    }
  }

  void _onUp(PointerEvent e) {
    if (e.pointer != _pointer) return;
    _pointer = null;
    final velocity = -(_tracker?.getVelocity().pixelsPerSecond.dy ?? 0);
    _tracker = null;
    if (_sheetDragged || e is PointerCancelEvent) {
      if (_sheetDragged) _settle(velocity);
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
        builder: (context, constraints) {
          _height = constraints.maxHeight;
          final large = _large;
          final sheet = RepaintBoundary(
            child: NativeGlass(
              radius: 32,
              child: DefaultTextStyle.merge(
                style: const TextStyle(fontFamily: sheetFont),
                child: Listener(
                  onPointerDown: _onDown,
                  onPointerMove: _onMove,
                  onPointerUp: _onUp,
                  onPointerCancel: _onUp,
                  child: CustomScrollView(
                    controller: _scroll,
                    physics: _SheetScrollPhysics(
                      isLocked: () => _scrollBlocked,
                    ),
                    slivers: [
                      SliverToBoxAdapter(child: _Header(onClose: _dismiss)),
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          16,
                          0,
                          16,
                          bottomInset + 24 + _overscan,
                        ),
                        sliver: SliverToBoxAdapter(child: _content()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: -_overscan,
                height: large + _overscan,
                child: AnimatedBuilder(
                  animation: _extent,
                  child: sheet,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(0, large - _extent.value),
                    child: child,
                  ),
                ),
              ),
            ],
          );
        },
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

/// iOS-Scrollen im Blatt: Gummiband unten, oben geklemmt (dort übernimmt das
/// Blatt die Bewegung) und gesperrt, solange das Blatt nicht ganz oben ist.
class _SheetScrollPhysics extends BouncingScrollPhysics {
  const _SheetScrollPhysics({required this.isLocked, super.parent})
    : super(decelerationRate: ScrollDecelerationRate.fast);

  final bool Function() isLocked;

  @override
  _SheetScrollPhysics applyTo(ScrollPhysics? ancestor) =>
      _SheetScrollPhysics(isLocked: isLocked, parent: buildParent(ancestor));

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) =>
      isLocked() ? 0 : super.applyPhysicsToUserOffset(position, offset);

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) => isLocked() ? null : super.createBallisticSimulation(position, velocity);

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.minScrollExtent &&
        position.minScrollExtent <= position.pixels) {
      return value - position.minScrollExtent; // oben anschlagen
    }
    if (value < position.pixels && position.pixels <= position.minScrollExtent) {
      return value - position.pixels; // schon oben: nicht weiter hinein
    }
    return 0;
  }
}

/// Bild in der Größe, in der es angezeigt wird (spart Dekodierzeit/Speicher).
ImageProvider _sheetImage(
  BuildContext context,
  String path, {
  double fraction = 1,
}) {
  final width = MediaQuery.sizeOf(context).width * fraction;
  final pixels = (width * MediaQuery.devicePixelRatioOf(context)).round();
  return ResizeImage(AssetImage(path), width: pixels, policy: ResizeImagePolicy.fit);
}

class _Header extends StatelessWidget {
  const _Header({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: Stack(
        children: [
          Align(
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
          child: Image(
            image: _sheetImage(context, image),
            fit: BoxFit.cover,
          ),
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
            RepaintBoundary(child: _FactCard(fact: fact)),
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
                        child: Image(
                          image: _sheetImage(context, image, fraction: 0.5),
                          fit: BoxFit.cover,
                        ),
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
