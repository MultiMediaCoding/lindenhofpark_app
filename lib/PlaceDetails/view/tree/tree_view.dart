import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/view/map_view.dart';
import 'package:lindenhofpark/PlaceDetails/view/info_box.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/tree.dart';

class TreeView extends StatelessWidget {
  const TreeView({super.key, required this.mapObject, required this.tree});

  final MapObject mapObject;
  final Tree tree;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            "assets/images/trees/sample_tree.jpeg",
            fit: BoxFit.fitHeight,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(20),
            height: 400,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.start,
                    spacing: 20,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tree.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(tree.latinName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            InfoBox(
                                description: "Alter",
                                content: "${tree.age}",
                                subtitle: "jahre"),
                            Spacer(),
                            InfoBox(
                              description: "Höhe",
                              content: tree.height.toString(),
                              subtitle: "meter",
                            ),
                            Spacer(),
                            InfoBox(
                                description: "Blätter",
                                content: tree.leafTypeName),
                            Spacer(),
                          ],
                        ),
                      ),
                      InfoBox(description: "Herkunft", content: tree.origin),
                      Spacer()
                    ]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
