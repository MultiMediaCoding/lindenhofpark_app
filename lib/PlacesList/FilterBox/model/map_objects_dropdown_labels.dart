// DropdownMenuEntry labels and values for the dropdown menu.
enum MapObjectDropdownCategoryLabel {
  all('Alle', "all.fill"),
  tree('Baum', "tree.fill"),
  historicalPlace(
    'Historischer Ort',
    "building.columns.fill",
  ),
  culturalPlace('Kultureller Ort', "theatermasks.fill"),
  bench('Bank', "chair.lounge"),
  toilet("Toilette", "toilet"),
  cutlery('Besteck', "fork.knife"),
  info("Infotafeln", "info"),
  swimmingResort("Badeplatz", "figure.open.water.swim");

  const MapObjectDropdownCategoryLabel(this.title, this.iconName);

  final String title;
  final String iconName;
}
