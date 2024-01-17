import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lindenhofpark/PlacesList/FilterBox/model/map_objects_dropdown_labels.dart';

final TextEditingController iconController = TextEditingController();
MapObjectDropdownCategoryLabel? selectedIcon;

class CategoryPicker extends StatefulWidget {
  const CategoryPicker({super.key});

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<MapObjectDropdownCategoryLabel>(
      width: 250,
      controller: iconController,
      enableFilter: true,
      requestFocusOnTap: true,
      leadingIcon: const Icon(Icons.category),
      label: const Text('Kategorie'),
      inputDecorationTheme: const InputDecorationTheme(
        filled: false,
        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
      ),
      onSelected: (MapObjectDropdownCategoryLabel? icon) {
        setState(() {
          selectedIcon = icon;
        });
      },
      dropdownMenuEntries: MapObjectDropdownCategoryLabel.values
          .map<DropdownMenuEntry<MapObjectDropdownCategoryLabel>>(
        (MapObjectDropdownCategoryLabel icon) {
          return DropdownMenuEntry<MapObjectDropdownCategoryLabel>(
            value: icon,
            label: icon.label,
            leadingIcon: SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                  "assets/images/map_category_icons/${icon.iconName}.svg",
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
            ),
          );
        },
      ).toList(),
    );
  }
}
