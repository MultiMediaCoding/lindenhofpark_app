import 'package:flutter/material.dart';
import 'package:lindenhofpark/Common/view/vector_icon.dart';
import 'package:lindenhofpark/PlacesList/view_model/places_list_view_model.dart';
import 'package:lindenhofpark/resources/resources.dart';
import 'package:provider/provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
            height: 50,
            child: TextField(
              onChanged: (searchText) =>
                  Provider.of<PlacesListViewModel>(context, listen: false)
                      .findMapObjects(searchText),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: VectorIcon(
                      icon: FontAwesomeIcon.magnifyingGlassSolid, size: 18),
                  hintText: "Suchen"),
            )),
      ],
    );
  }
}
