import 'package:flutter/material.dart';
import 'package:lindenhofpark/Common/view/vector_icon.dart';
import 'package:lindenhofpark/PlacesList/FilterBox/model/map_objects_dropdown_labels.dart';
import 'package:lindenhofpark/PlacesList/view_model/places_list_view_model.dart';
import 'package:provider/provider.dart';

class CategoryPicker extends StatefulWidget {
  const CategoryPicker({super.key});

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

final _foregroundColor = Colors.black.withValues(alpha: 0.55);

class _CategoryPickerState extends State<CategoryPicker> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final category in MapObjectDropdownCategoryLabel.values)
          _buildItem(category),
      ],
    );
  }

  Widget _buildItem(MapObjectDropdownCategoryLabel category) {
    return Consumer<PlacesListViewModel>(
      builder: (context, viewModel, child) {
        final isSelected = viewModel.selectedCategoryName == category.title;
        final boxColor = isSelected
            ? _foregroundColor
            : Colors.white.withValues(alpha: 0.6);
        final textColor = isSelected ? Colors.white : _foregroundColor;
        return GestureDetector(
          onTap: () => Provider.of<PlacesListViewModel>(
            context,
            listen: false,
          ).setCategory(category),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 14),
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                VectorIcon(icon: category.iconName, size: 18, color: textColor),
                const SizedBox(width: 8),
                Text(
                  category.title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
