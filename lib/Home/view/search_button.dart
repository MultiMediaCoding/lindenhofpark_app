import 'package:flutter/cupertino.dart';
import 'package:lindenhofpark/Common/view/toolbar_button_label.dart';
import 'package:lindenhofpark/Common/view/vector_icon.dart';
import 'package:lindenhofpark/PlacesList/view/places_list_view.dart';
import 'package:lindenhofpark/resources/resources.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ToolbarButton(
      alignment: Alignment.topLeft,
      semanticLabel: 'Suchen',
      icon: VectorIcon(icon: FontAwesomeIcon.magnifyingGlassSolid, size: 15),
      onPressed: () => _showSheet(context),
    );
  }

  void _showSheet(BuildContext context) {
    showCupertinoSheet<void>(
      context: context,
      showDragHandle: true,
      scrollableBuilder: (context, scrollController) =>
          PlacesListView(scrollController: scrollController),
    );
  }
}
