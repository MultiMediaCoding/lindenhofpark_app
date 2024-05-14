import 'package:lindenhofpark/PlaceDetails/model/trees/leaf_type.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/leave_types.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/trees.dart';
import 'package:time_machine/time_machine.dart';

class Tree {
  final String title;
  final String imageName;
  String imagePath = "";
  final String latinName;
  final int height;
  final DateTime? plantedAt;
  int? age = 0;
  final String origin;
  final LeafType leafType;
  String leafTypeName = "";

  Tree(this.title, this.imageName, this.latinName, this.height, this.plantedAt,
      this.origin, this.leafType) {
    imagePath = "assets/images/trees/$imageName";

    age = _ageOfTree();
    leafTypeName = leaveTypes[leafType] ?? "";
  }

  int? _ageOfTree() {
    if (plantedAt != null) {
      final now = LocalDate.today();
      final treePlantedAt = LocalDate.dateTime(plantedAt!);
      final differenceBetweenDates = now.periodSince(treePlantedAt);
      return differenceBetweenDates.years;
    }
    return null;
  }
}

extension TreeObjectListExtension on List<Tree> {
  Tree getTreeByTitle(String title) {
    return firstWhere((tree) => tree.title == title, orElse: () => trees.first);
  }
}
