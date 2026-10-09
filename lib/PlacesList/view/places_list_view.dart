import 'package:flutter/material.dart';
import 'package:lindenhofpark/PlacesList/FilterBox/view/category_picker.dart';
import 'package:lindenhofpark/PlacesList/FilterBox/view/search_field.dart';
import 'package:lindenhofpark/PlacesList/view/places_list_item.dart';
import 'package:lindenhofpark/PlacesList/view_model/places_list_view_model.dart';
import 'package:provider/provider.dart';

/// Search and filter list shown in a sheet.
///
/// [scrollController] comes from `showCupertinoSheet`, so the list scroll and
/// the swipe-down-to-dismiss gesture are coordinated by the framework.
class PlacesListView extends StatelessWidget {
  const PlacesListView({super.key, required this.scrollController});

  final ScrollController scrollController;

  static const backgroundColor = Color.fromRGBO(221, 223, 216, 1);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlacesListViewModel(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: CustomScrollView(
          controller: scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              sliver: SliverList.list(
                children: const [
                  SearchField(),
                  SizedBox(height: 12),
                  CategoryPicker(),
                  SizedBox(height: 8),
                ],
              ),
            ),
            Consumer<PlacesListViewModel>(
              builder: (context, viewModel, child) {
                final objects = viewModel.filteredMapObjects;
                return SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    0,
                    16,
                    MediaQuery.paddingOf(context).bottom + 16,
                  ),
                  sliver: SliverList.separated(
                    itemCount: objects.length,
                    itemBuilder: (context, index) =>
                        PlacesListItem(mapObject: objects[index]),
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
