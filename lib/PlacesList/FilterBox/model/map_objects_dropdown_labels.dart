// DropdownMenuEntry labels and values for the dropdown menu.
enum MapObjectDropdownCategoryLabel {
  all('Alle', "all.fill"),
  tree('Baum', "tree-solid"),
  historicalPlace(
    'Historischer Ort',
    "landmark-solid",
  ),

  cutlery('Essen', "utensils-solid"),
  info("Infotafeln", "info"),
  swimmingResort("Badeplatz", "person-swimming-solid");

  const MapObjectDropdownCategoryLabel(this.title, this.iconName);

  final String title;
  final String iconName;
}
