import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return MaterialApp(
      title: 'Lindenhofpark App',
      theme: ThemeData(
          fontFamily: 'Inter',
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true),
      themeMode: ThemeMode.light,
      scrollBehavior: const _AppleScrollBehavior(),
      home: HomeView(),
    );
  }
}

/// iOS-Scrollgefühl auf allen Plattformen: Gummiband, schnelle Abbremsung,
/// kein Android-Glühen am Rand.
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
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Set<PointerDeviceKind> get dragDevices => {
        ...super.dragDevices,
        PointerDeviceKind.mouse,
      };
}
