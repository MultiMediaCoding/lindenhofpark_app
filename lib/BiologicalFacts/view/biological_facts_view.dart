import 'package:flutter/material.dart';
import 'package:lindenhofpark/BiologicalFacts/model/biological_facts.dart';
import 'package:lindenhofpark/BiologicalFacts/view/fact_card.dart';
import 'package:lindenhofpark/BiologicalFacts/view/indicator_carousel_slider.dart';

class BiologicalFactsView extends StatelessWidget {
  const BiologicalFactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Wissenswertes",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              "Biologische Fakten",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 25,
            ),
            IndicatorCarouselSlider(facts: biologicalFacts),
          ],
        ),
      ),
    );
  }
}
