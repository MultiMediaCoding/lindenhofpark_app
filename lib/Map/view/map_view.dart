import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lindenhofpark/Common/view/map_button.dart';
import 'package:lindenhofpark/Licenses/view/licenses_view.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/view_model/map_view_model.dart';
import 'package:lindenhofpark/Map/view_model/selection.dart';
import 'package:lindenhofpark/Map/view_model/url_view_model.dart';
import 'package:lindenhofpark/PlaceDetails/view/place_sheet.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

final UrlViewModel urlViewModel = UrlViewModel();

/// Die 3D-Karte mit Liquid-Glass-Bedienelementen und dem Detailblatt.
/// Ein Antippen eines Baums oder historischen Ortes wählt ihn aus
/// ([selectedMapObject]) und öffnet das Blatt über der Karte.
class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final MapViewModel _viewModel = MapViewModel(
    onTreeTapped: (id) {
      HapticFeedback.lightImpact();
      selectedMapObject.value = _viewModel.mapObjectForTree(id);
    },
    onPlaceTapped: (title) {
      HapticFeedback.lightImpact();
      selectedMapObject.value = _viewModel.mapObjectForPlace(title);
    },
    onDeselected: () => selectedMapObject.value = null,
    onOutsidePark: _showOutsidePark,
  );

  /// Das angezeigte Objekt bleibt, bis das Blatt ausgefahren ist.
  MapObject? _displayed;

  @override
  void initState() {
    super.initState();
    selectedMapObject.addListener(_onSelectionChanged);
  }

  @override
  void dispose() {
    selectedMapObject.removeListener(_onSelectionChanged);
    _viewModel.dispose();
    super.dispose();
  }

  /// Auswahl aus der Suchliste oder dem Blatt: Karte folgt.
  void _onSelectionChanged() {
    final selected = selectedMapObject.value;
    if (selected != null) {
      setState(() => _displayed = selected);
    } else if (_displayed != null) {
      setState(() {}); // Blatt fährt aus und meldet sich dann ab
    }
    if (selected == null) {
      _viewModel.clearSelection();
    } else if (selected.treeId != null) {
      _viewModel.selectTree(selected.treeId!);
    } else {
      _viewModel.selectPlace(selected.title);
    }
  }

  void _showOutsidePark() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Du bist gerade nicht im Lindenhofpark.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: PopScope(
        // Android-Zurück schließt zuerst das Detailblatt, statt die App zu verlassen.
        canPop: selectedMapObject.value == null,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) selectedMapObject.value = null;
        },
        child: Stack(
          children: [
            WebViewWidget(controller: _viewModel.controller),
            const _MapControls(),
            if (_displayed != null)
              PlaceSheet(
                mapObject: _displayed!,
                visible: selectedMapObject.value != null,
                onDismissed: () {
                  if (!mounted) return;
                  selectedMapObject.value = null;
                  setState(() => _displayed = null);
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _MapControls extends StatelessWidget {
  const _MapControls();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MapViewModel>();
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              // Nur der Kompass hört auf `heading`; die übrigen Knöpfe bleiben
              // unberührt.
              Selector<MapViewModel, double>(
                selector: (_, m) => m.heading,
                builder: (context, heading, child) => Transform.rotate(
                  angle: heading * 3.141592653589793 / 180,
                  child: child,
                ),
                child: MapButton(
                  sfSymbol: 'location.north.fill',
                  fallbackIcon: Icons.navigation,
                  label: 'Nach Norden ausrichten',
                  color: const Color(0xFFE5533D),
                  onPressed: viewModel.resetNorth,
                ),
              ),
              MapButton(
                sfSymbol: 'location',
                fallbackIcon: Icons.my_location,
                label: 'Mein Standort',
                onPressed: viewModel.locate,
              ),
              Selector<MapViewModel, bool>(
                selector: (_, m) => m.is3D,
                builder: (context, is3D, _) => MapButton(
                  sfSymbol: is3D ? 'view.2d' : 'view.3d',
                  fallbackIcon: Icons.view_in_ar,
                  fallbackText: is3D ? '2D' : '3D',
                  label: is3D ? 'Zur 2D-Ansicht' : 'Zur 3D-Ansicht',
                  onPressed: viewModel.toggleTilt,
                ),
              ),
              Selector<MapViewModel, bool>(
                selector: (_, m) => m.isNight,
                builder: (context, isNight, _) => MapButton(
                  sfSymbol: isNight ? 'sun.max.fill' : 'moon.fill',
                  fallbackIcon: isNight ? Icons.light_mode : Icons.dark_mode,
                  label: isNight ? 'Tagansicht' : 'Nachtansicht',
                  onPressed: viewModel.toggleNight,
                ),
              ),
              MapButton(
                sfSymbol: 'info',
                fallbackIcon: Icons.info_outline,
                label: 'Quellen und Lizenzen',
                onPressed: () => _showCredits(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCredits(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (sheetContext) => CupertinoActionSheet(
        title: const Text("Quellen"),
        message: const Text(
          "Bäume: Baumkataster GTL Lindau, Stand 2023\n"
          "Wege und Gebäude: © OpenStreetMap-Mitwirkende\n"
          "Gelände: Bayerische Vermessungsverwaltung, geodaten.bayern.de",
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(sheetContext).pop();
              urlViewModel.launchOpenStreetMapCopyrightSite();
            },
            child: const Text("OpenStreetMap-Copyright"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(sheetContext).pop();
              Navigator.of(context).push(
                CupertinoPageRoute<void>(builder: (_) => const LicensesView()),
              );
            },
            child: const Text("Lizenzen"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(sheetContext).pop(),
          child: const Text("Schließen"),
        ),
      ),
    );
  }
}
