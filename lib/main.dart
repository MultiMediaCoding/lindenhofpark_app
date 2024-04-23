import 'package:flutter/material.dart';
import 'package:lindenhofpark/ColorTheme/color_schemes.g.dart';
import 'package:lindenhofpark/Home/view/HomeView.dart';
import 'package:lindenhofpark/Map/model/map_objects.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/trees.dart';
import 'package:lindenhofpark/PlaceDetails/view/tree/tree_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lindenhofpark',
      theme: ThemeData(
        fontFamily: 'Inter',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Inter',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: TreeView(
          mapObject: mapObjects.first,
          tree: trees[3],
        ),
      ),
    );
  }
}
