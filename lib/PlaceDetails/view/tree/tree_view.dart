import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 270,
              child: Stack(children: [
                // Image with gradient
                SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 250,
                          child: ClipRect(
                            child: Image.asset(
                              "assets/images/trees/sample_tree.jpeg",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                end: const Alignment(0.0, -1),
                                begin: const Alignment(0.0, 0.4),
                                colors: <Color>[
                                  const Color(0x8A000000),
                                  Colors.black12.withOpacity(0.0)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                // Map Object Badge
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: MapPin(mapObject: mapObject),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
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
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(tree.latinName,
                            style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                    InfoBox(
                        icon: CupertinoIcons.calendar,
                        title: "Alter",
                        subtitle: "${tree.age} Jahre alt"),
                    InfoBox(
                        icon: CupertinoIcons.placemark,
                        title: "Herkunft",
                        subtitle: tree.origin),
                    InfoBox(
                        icon: CupertinoIcons.sun_max,
                        title: "Blüten/Früchte",
                        subtitle: tree.origin),
                    InfoBox(
                        icon: CupertinoIcons.leaf_arrow_circlepath,
                        title: "Blätter",
                        subtitle: tree.leafTypeName),
                  ]),
            ),
          ],
        ),
      ],
    );
  }
}
