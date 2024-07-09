import 'package:flutter/material.dart';
import 'package:lindenhofpark/BiologicalFacts/model/biolocial_fact.dart';
import 'package:lindenhofpark/BiologicalFacts/view/biological_facts_view.dart';
import 'package:lindenhofpark/Common/view/vector_icon.dart';
import 'package:lindenhofpark/resources/resources.dart';

class BiologicalDetailsButton extends StatelessWidget {
  const BiologicalDetailsButton({super.key, required this.facts});

  final List<BiolocialFact> facts;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BiologicalFactsView(facts: facts),
      )),
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.primary),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VectorIcon(
                icon: FontAwesomeIcon.infoSolid,
                size: 16,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Biologische Details",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
