import 'package:lindenhofpark/PlaceDetails/model/trees/leaf_type.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/leave_types.dart';
import 'package:lindenhofpark/PlaceDetails/model/trees/trees.dart';

class Tree {
  final String title;
  final String imageName;
  String imagePath = "";
  final String latinName;
  final int age;
  final String origin;
  final String blossoms;
  final LeafType leafType;
  String leafTypeName = "";

  Tree(this.title, this.imageName, this.latinName, this.age, this.origin,
      this.blossoms, this.leafType) {
    imagePath = "assets/images/trees/$imageName";
    leafTypeName = leaveTypes[leafType] ?? "";
  }
}

extension TreeObjectListExtension on List<Tree> {
  Tree getTreeByTitle(String title) {
    return firstWhere((tree) => tree.title == title, orElse: () => trees.first);
  }
}
