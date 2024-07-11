import 'package:flutter/material.dart';
import 'package:lindenhofpark/BiologicalFacts/model/biolocial_fact.dart';
import 'package:lindenhofpark/BiologicalFacts/view/indicator_carousel_slider.dart';
import 'package:lindenhofpark/PlaceDetails/common/view/back_button.dart';

class BiologicalFactsView extends StatelessWidget {
  const BiologicalFactsView({super.key, required this.facts});

  final List<BiologicalFact> facts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavigationBackButton(
              color: Color.fromRGBO(59, 105, 57, 1),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Wissenswertes",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Biologische Fakten",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            IndicatorCarouselSlider(facts: facts),
          ],
        ),
      ),
    );
  }
}
