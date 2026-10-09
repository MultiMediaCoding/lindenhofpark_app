import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/PlacesList/view_model/places_list_view_model.dart';
import 'package:provider/provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      placeholder: "Suchen",
      backgroundColor: Colors.white,
      borderRadius: BorderRadius.circular(100),
      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
      onChanged: (searchText) => Provider.of<PlacesListViewModel>(
        context,
        listen: false,
      ).findMapObjects(searchText),
    );
  }
}
