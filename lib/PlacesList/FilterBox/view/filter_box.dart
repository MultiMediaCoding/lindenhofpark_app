import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/PlacesList/FilterBox/view/border_box.dart';
import 'package:lindenhofpark/PlacesList/FilterBox/view/category_picker.dart';
import 'package:lindenhofpark/PlacesList/view_model/places_list_view_model.dart';
import 'package:provider/provider.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: BorderBox(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 70,
                child: TextField(
                  onChanged: (searchText) =>
                      Provider.of<PlacesListViewModel>(context, listen: false)
                          .findMapObjects(searchText),
                  decoration: const InputDecoration(
                      icon: Icon(CupertinoIcons.search),
                      hintText: "Objekt suchen..."),
                )),
            const CategoryPicker(),
          ],
        ),
      )),
    );
  }
}
