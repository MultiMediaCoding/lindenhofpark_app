import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/Common/view/toolbar_button_label.dart';
import 'package:lindenhofpark/Common/view/vector_icon.dart';
import 'package:lindenhofpark/PlacesList/view/places_list_view.dart';
import 'package:lindenhofpark/resources/resources.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SearchButton extends StatefulWidget {
  const SearchButton({super.key});

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    return ToolbarButton(
        alignment: Alignment.topLeft,
        icon: VectorIcon(
          icon: FontAwesomeIcon.magnifyingGlassSolid,
          size: 15,
        ),
        onPressed: () => showSheet);
  }

  void showSheet() {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => PlacesListView(),
    );
  }
}
