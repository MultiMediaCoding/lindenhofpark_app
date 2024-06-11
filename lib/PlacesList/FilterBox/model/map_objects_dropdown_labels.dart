// DropdownMenuEntry labels and values for the dropdown menu.
import 'package:lindenhofpark/resources/resources.dart';

enum MapObjectDropdownCategoryLabel {
  all('Alle', FontAwesomeIcon.gripSolid),
  tree('Baum', FontAwesomeIcon.treeSolid),
  historicalPlace(
    'Historischer Ort',
    FontAwesomeIcon.landmarkSolid,
  ),
  cutlery('Essen', FontAwesomeIcon.utensilsSolid),
  info("Infotafeln", FontAwesomeIcon.infoSolid),
  swimmingResort("Badeplatz", FontAwesomeIcon.personSwimmingSolid);

  const MapObjectDropdownCategoryLabel(this.title, this.iconName);

  final String title;
  final String iconName;
}
