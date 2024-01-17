import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/PlacesList/FilterBox/view/border_box.dart';
import 'package:lindenhofpark/PlacesList/FilterBox/view/category_picker.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const BorderBox(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 70,
                child: TextField(
                  decoration: InputDecoration(
                      icon: Icon(CupertinoIcons.search),
                      hintText: "Objekt suchen..."),
                )),
            CategoryPicker(),
          ],
        ),
      )),
    );
  }
}
