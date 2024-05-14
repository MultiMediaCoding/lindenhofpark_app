import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lindenhofpark/PlacesList/FilterBox/model/map_objects_dropdown_labels.dart';
import 'package:lindenhofpark/PlacesList/view_model/places_list_view_model.dart';
import 'package:provider/provider.dart';

final TextEditingController iconController = TextEditingController();

class CategoryPicker extends StatefulWidget {
  const CategoryPicker({super.key});

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

final _foregroundColor = Colors.black.withOpacity(0.55);

class _CategoryPickerState extends State<CategoryPicker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 140,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: false,
          itemCount: (MapObjectDropdownCategoryLabel.values.length / 2)
              .ceil(), // Anzahl der Zeilen berechnen
          itemBuilder: (BuildContext context, int index) {
            // Erstellen einer Zeile mit maximal zwei Elementen
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildItem(MapObjectDropdownCategoryLabel.values[index * 2]),
                if (index * 2 + 1 <
                    MapObjectDropdownCategoryLabel.values.length)
                  _buildItem(MapObjectDropdownCategoryLabel.values[index * 2 +
                      1]), // Füge das zweite Element hinzu, wenn vorhanden
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildItem(MapObjectDropdownCategoryLabel category) {
    return Consumer<PlacesListViewModel>(builder: (context, viewModel, child) {
      final isSelected = viewModel.selectedCategoryName == category.title;
      final boxColor =
          isSelected ? _foregroundColor : Colors.white.withOpacity(0.6);
      final textColor = isSelected ? Colors.white : _foregroundColor;
      return GestureDetector(
        onTap: () => {
          Provider.of<PlacesListViewModel>(context, listen: false)
              .setCategory(category)
        },
        child: Container(
          margin: EdgeInsets.all(4.0),
          padding: EdgeInsets.only(top: 8, right: 12.0, bottom: 8, left: 12.0),
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Container(
                width: 18,
                height: 18,
                child: SvgPicture.asset(
                    "assets/images/map_category_icons/${category.iconName}.svg",
                    colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn)),
              ),
              const SizedBox(width: 12),
              Text(
                category.title,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
    });
  }
}
