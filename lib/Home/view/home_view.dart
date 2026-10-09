import 'package:lindenhofpark/Home/view/search_button.dart';
import 'package:lindenhofpark/Map/view/map_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapView(),
          SearchButton(),
        ],
      ),
    );
  }
}
