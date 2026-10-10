import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lindenhofpark/Common/view/night_mode.dart';
import 'package:lindenhofpark/Common/view/symbol_icon.dart';
import 'package:lindenhofpark/Home/view/home_view.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree_catalog.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await loadTreeCatalog();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme(Brightness brightness) => ThemeData(
      fontFamily: 'Inter',
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
        brightness: brightness,
      ),
      useMaterial3: true,
    );
    // Die Tag-/Nachtansicht der Karte bestimmt das Erscheinungsbild der ganzen App.
    return ValueListenableBuilder<bool>(
      valueListenable: nightMode,
      builder: (context, night, _) => MaterialApp(
        title: 'Lindenhofpark App',
        theme: theme(Brightness.light),
        darkTheme: theme(Brightness.dark),
        themeMode: night ? ThemeMode.dark : ThemeMode.light,
        scrollBehavior: hasSfSymbols ? const _AppleScrollBehavior() : null,
        home: HomeView(),
      ),
    );
  }
}

/// iOS-Scrollgefühl auf Apple-Geräten: Gummiband, schnelle Abbremsung. Android
/// behält das Material-Scrollverhalten.
class _AppleScrollBehavior extends MaterialScrollBehavior {
  const _AppleScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(
        decelerationRate: ScrollDecelerationRate.fast,
        parent: AlwaysScrollableScrollPhysics(),
      );

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) => child;

  @override
  Set<PointerDeviceKind> get dragDevices => {
    ...super.dragDevices,
    PointerDeviceKind.mouse,
  };
}
