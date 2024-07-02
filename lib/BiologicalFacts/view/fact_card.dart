import 'package:flutter/material.dart';
import 'package:lindenhofpark/BiologicalFacts/model/biolocial_fact.dart';

class FactCard extends StatelessWidget {
  const FactCard({super.key, required this.fact});

  final BiolocialFact fact;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            images(context),
            SizedBox(
              height: 16,
            ),
            Text(
              fact.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              fact.content,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget images(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = (screenWidth * 0.5) - 43;
    return Row(
      children: [
        Spacer(),
        image(fact.images[0], imageWidth),
        const SizedBox(
          width: 15,
        ),
        image(fact.images[1], imageWidth),
        Spacer()
      ],
    );
  }

  Widget image(String image, double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child:
          Image.asset(image, width: width, height: 100, fit: BoxFit.fitWidth),
    );
  }
}
