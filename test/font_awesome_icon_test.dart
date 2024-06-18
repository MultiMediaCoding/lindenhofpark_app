import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lindenhofpark/resources/resources.dart';

void main() {
  test('font_awesome_icon assets test', () {
    expect(File(FontAwesomeIcon.angleLeftSolid).existsSync(), isTrue);
    expect(File(FontAwesomeIcon.boxSolid).existsSync(), isTrue);
    expect(File(FontAwesomeIcon.circleInfoSolid).existsSync(), isTrue);
    expect(File(FontAwesomeIcon.circleXmarkSolid).existsSync(), isTrue);
    expect(File(FontAwesomeIcon.ellipsisSolid).existsSync(), isTrue);
    expect(File(FontAwesomeIcon.gripSolid).existsSync(), isTrue);
    expect(File(FontAwesomeIcon.infoSolid).existsSync(), isTrue);
    expect(File(FontAwesomeIcon.landmarkSolid).existsSync(), isTrue);
    expect(File(FontAwesomeIcon.link).existsSync(), isTrue);
    expect(File(FontAwesomeIcon.magnifyingGlassSolid).existsSync(), isTrue);
    expect(File(FontAwesomeIcon.personSwimmingSolid).existsSync(), isTrue);
    expect(File(FontAwesomeIcon.restroomSolid).existsSync(), isTrue);
    expect(File(FontAwesomeIcon.treeSolid).existsSync(), isTrue);
    expect(File(FontAwesomeIcon.utensilsSolid).existsSync(), isTrue);
  });
}
