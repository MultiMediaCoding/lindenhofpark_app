import 'package:flutter/material.dart';
import 'package:lindenhofpark/Home/view/HomeView.dart';

void main() {
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
      home: HomeView(),
    );
  }
}
