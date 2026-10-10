import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lindenhofpark/Common/view/symbol_icon.dart';
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

/// Detailblatt über der Karte: auf Apple-Geräten ein Liquid-Glass-Sheet, sonst
/// das Material-3-Bottom-Sheet.
class PlaceSheet extends StatelessWidget {
  const PlaceSheet({
    super.key,
    required this.mapObject,
    required this.visible,
    required this.onDismissed,
  });

  final MapObject mapObject;

  /// `false`: das Blatt fährt aus (Auswahl wurde aufgehoben).
  final bool visible;

  /// Das Blatt ist ganz heruntergefahren und kann entfernt werden.
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) => hasSfSymbols
      ? _CupertinoPlaceSheet(
          mapObject: mapObject,
          visible: visible,
          onDismissed: onDismissed,
        )
      : _MaterialPlaceSheet(
          mapObject: mapObject,
          visible: visible,
          onDismissed: onDismissed,
        );
}

/// Android: Standard-Bottom-Sheet von Material 3 mit Ziehgriff, zwei Rasten
/// und Wegwischen nach unten. Die Karte dahinter bleibt bedienbar.
class _MaterialPlaceSheet extends StatefulWidget {
  const _MaterialPlaceSheet({
    required this.mapObject,
    required this.visible,
    required this.onDismissed,
  });

  final MapObject mapObject;
  final bool visible;
  final VoidCallback onDismissed;

  @override
  State<_MaterialPlaceSheet> createState() => _MaterialPlaceSheetState();
}

class _MaterialPlaceSheetState extends State<_MaterialPlaceSheet> {
  static const _small = 0.45;
  static const _large = 0.93;

  final _controller = DraggableScrollableController();
  bool _opened = false;
  bool _dismissed = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onExtent);
  }

  @override
  void didUpdateWidget(_MaterialPlaceSheet old) {
    super.didUpdateWidget(old);
    if (!_controller.isAttached) return;
    if (old.mapObject != widget.mapObject && widget.visible) {
      _animate(_small);
    } else if (!widget.visible && old.visible) {
      _animate(0);
    } else if (widget.visible && !old.visible) {
      _dismissed = false;
      _animate(_small);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animate(double size) => _controller.animateTo(
    size,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOutCubic,
  );

  /// Ganz heruntergewischt: Auswahl aufheben und Blatt entfernen.
  void _onExtent() {
    if (!_controller.isAttached) return;
    if (_controller.size > 0.5 * _small) {
      _opened = true;
      return;
    }
    if (_opened && !_dismissed && _controller.size < 0.02) {
      _dismissed = true;
      widget.onDismissed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    return Positioned.fill(
      child: DraggableScrollableSheet(
        controller: _controller,
        initialChildSize: _small,
        minChildSize: 0,
        maxChildSize: _large,
        snap: true,
        snapSizes: const [_small],
        shouldCloseOnMinExtent: false,
        builder: (context, scrollController) => Material(
          color: scheme.surfaceContainerLow,
          elevation: 1,
          surfaceTintColor: scheme.surfaceTint,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          clipBehavior: Clip.antiAlias,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    width: 32,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: scheme.onSurfaceVariant.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, bottomInset + 24),
                sliver: SliverToBoxAdapter(child: _content(widget.mapObject)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _content(MapObject mapObject) {
  if (mapObject.category.category == MapObjectCategoryType.tree) {
    return _TreeContent(tree: treeCatalog.byId(mapObject.treeId!)!);
  }
  return _PlaceContent(
    place: historicalPlaces.getHistoricalPlaceByTitle(mapObject.title),
  );
}

/// Apple: Liquid-Glass-Sheet mit zwei Rasten (klein /
/// groß); die Karte dahinter bleibt bedienbar.
///
/// Das Blatt hat eine feste Höhe und wird nur verschoben (`Transform`), damit
/// beim Ziehen weder Inhalt noch die native Glasfläche neu gelayoutet werden.
/// Das Einrasten läuft über eine Feder, die die Fingergeschwindigkeit
/// übernimmt; Ziehen am Inhalt, am Griff und Scrollen sind ein einziger
/// Gestenpfad.
class _CupertinoPlaceSheet extends StatefulWidget {
  const _CupertinoPlaceSheet({
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
  State<_CupertinoPlaceSheet> createState() => _PlaceSheetState();
}

class _PlaceSheetState extends State<_CupertinoPlaceSheet>
    with SingleTickerProviderStateMixin {
  static const double _smallFraction = 0.45;
  static const double _largeFraction = 0.93;

  /// Unter dem Rand versteckter Überstand, damit die Feder über die große
  /// Raste hinausschwingen darf, ohne dass unten eine Lücke aufblitzt.
  static const double _overscan = 100;

  /// Größtes Dehnen über die große Raste hinaus (Gummiband).
  static const double _stretch = 90;

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

  /// Wo der Finger das Blatt hinzöge, ohne Gummiband.
  double _raw = 0;

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
  void didUpdateWidget(_CupertinoPlaceSheet old) {
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
    final target = [
      0.0,
      _small,
      _large,
    ].reduce((a, b) => (a - projected).abs() < (b - projected).abs() ? a : b);
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
    _raw = _extent.value;
  }

  void _onMove(PointerMoveEvent e) {
    if (e.pointer != _pointer) return;
    _tracker?.addPosition(e.timeStamp, e.position);
    final dy = e.delta.dy;
    final atTop = !_scroll.hasClients || _scroll.offset <= 0.5;
    // Das Blatt nimmt die Bewegung, solange es nicht ganz oben ist oder der
    // Inhalt oben anliegt und nach unten gezogen wird (Scroll ist dann gesperrt
    // beziehungsweise geklemmt, siehe [_SheetScrollPhysics]).
    if (_sheetDragged || _extent.value < _large - 0.5 || (dy > 0 && atTop)) {
      _raw = math.max(0.0, _raw - dy);
      _extent.value = _rubberBand(_raw);
      _sheetDragged = true;
    }
  }

  /// Über der großen Raste wird das Blatt wie in iOS gedehnt: je weiter, desto
  /// zäher (Apples Gummiband-Formel), höchstens [_stretch].
  double _rubberBand(double raw) {
    final over = raw - _large;
    if (over <= 0) return raw;
    return _large + (1 - 1 / (over * 0.55 / _stretch + 1)) * _stretch;
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
                style: TextStyle(fontFamily: sheetFont),
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

/// iOS-Scrollen im Blatt: Gummiband an beiden Enden, aber gesperrt, solange
/// das Blatt nicht ganz oben ist oder gerade bewegt wird.
class _SheetScrollPhysics extends BouncingScrollPhysics {
  const _SheetScrollPhysics({required this.isLocked, super.parent})
    : super(decelerationRate: ScrollDecelerationRate.fast);

  final bool Function() isLocked;

  @override
  _SheetScrollPhysics applyTo(ScrollPhysics? ancestor) =>
      _SheetScrollPhysics(isLocked: isLocked, parent: buildParent(ancestor));

  /// Der Finger dehnt den Inhalt nie über den oberen Rand: dort zieht er das
  /// Blatt herunter. Läuft ein Wisch aber oben auf, federt der Inhalt wie in
  /// iOS kurz über den Rand und zurück.
  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if (isLocked()) return 0;
    if (offset > 0 && position.pixels <= position.minScrollExtent) return 0;
    return super.applyPhysicsToUserOffset(position, offset);
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) => isLocked() ? null : super.createBallisticSimulation(position, velocity);
}

/// Bild in der Größe, in der es angezeigt wird (spart Dekodierzeit/Speicher).
ImageProvider _sheetImage(
  BuildContext context,
  String path, {
  double fraction = 1,
}) {
  final width = MediaQuery.sizeOf(context).width * fraction;
  final pixels = (width * MediaQuery.devicePixelRatioOf(context)).round();
  return ResizeImage(
    AssetImage(path),
    width: pixels,
    policy: ResizeImagePolicy.fit,
  );
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
                  color: context.sheetInk.withValues(alpha: 0.3),
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
                    color: context.sheetInk.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 17,
                    color: context.sheetInkSoft,
                  ),
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
          child: Image(image: _sheetImage(context, image), fit: BoxFit.cover),
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
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              height: 1.1,
              letterSpacing: 0.2,
              fontFamily: sheetTitleFont,
              fontVariations: const [FontVariation('wdth', 125)],
              color: context.sheetInk,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 15,
              height: 1.2,
              color: context.sheetInkSoft,
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
            (
              symbol: symbolSpec(
                'birthday.cake.fill',
                FontAwesomeIcons.cakeCandles,
              ),
              label: "Alter",
              value: specimen?.age != null
                  ? "${specimen!.age} Jahre"
                  : tree.ageStage,
            ),
            (
              symbol: symbolSpec('arrow.up.and.down', FontAwesomeIcons.upDown),
              label: "Höhe",
              value: "${_meters(specimen?.height.toDouble() ?? tree.height)} m",
            ),
            (
              symbol: symbolSpec(
                'arrow.left.and.right',
                FontAwesomeIcons.leftRight,
              ),
              label: "Krone",
              value: "${_meters(tree.crownDiameter)} m Durchmesser",
            ),
            (
              symbol: symbolSpec('ruler', FontAwesomeIcons.rulerHorizontal),
              label: "Stammumfang",
              value: "${_meters(tree.trunkCircumferenceCm / 100)} m",
            ),
            (
              symbol: tree.isNeedle
                  ? symbolSpec('asterisk', FontAwesomeIcons.asterisk)
                  : symbolSpec('leaf.fill', FontAwesomeIcons.leaf),
              label: "Blätter",
              value: leaves ?? "",
            ),
            if (specimen != null)
              (
                symbol: symbolSpec(
                  'globe.europe.africa.fill',
                  FontAwesomeIcons.earthEurope,
                ),
                label: "Herkunft",
                value: specimen.origin,
              ),
          ],
        ),
        if (facts.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(7, 14, 7, 12),
            child: Text(
              "Wissenswertes",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: context.sheetInk,
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
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: context.sheetInk,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 25,
            thickness: 0.5,
            color: context.sheetInk.withValues(alpha: 0.18),
          ),
          Text(
            fact.content,
            style: TextStyle(
              fontSize: 17,
              height: 1.25,
              color: context.sheetInk,
            ),
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
            style: TextStyle(
              fontSize: 16,
              height: 1.4,
              color: context.sheetInk,
            ),
          ),
        ),
      ],
    );
  }
}
