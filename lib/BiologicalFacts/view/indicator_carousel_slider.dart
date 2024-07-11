import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/BiologicalFacts/model/biolocial_fact.dart';
import 'package:lindenhofpark/BiologicalFacts/view/fact_card.dart';

class IndicatorCarouselSlider extends StatefulWidget {
  final List<BiologicalFact> facts;

  const IndicatorCarouselSlider({super.key, required this.facts});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<IndicatorCarouselSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final imageSliders = getImageSliders();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height * 0.65;
    return Column(children: [
      CarouselSlider(
        items: imageSliders,
        carouselController: _controller,
        options: CarouselOptions(
            autoPlay: false,
            enlargeCenterPage: true,
            aspectRatio: width / height,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      const SizedBox(
        height: 4,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageSliders.asMap().entries.map((entry) {
          return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _current == entry.key ? 24.0 : 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: (_current == entry.key
                      ? Colors.grey
                      : Colors.grey.shade400),
                ),
              ));
        }).toList(),
      ),
    ]);
  }

  List<Widget> getImageSliders() {
    final sliders = widget.facts
        .map((fact) => FactCard(
              fact: fact,
            ))
        .toList();
    return sliders;
  }
}
