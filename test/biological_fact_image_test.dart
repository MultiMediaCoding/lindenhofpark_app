import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lindenhofpark/resources/resources.dart';

void main() {
  test('biological_fact_image assets test', () {
    expect(File(BiologicalFactImage.blaetterWinterlinde).existsSync(), isTrue);
    expect(File(BiologicalFactImage.blatt2Winterlinde).existsSync(), isTrue);
    expect(File(BiologicalFactImage.blattAstRotbuche).existsSync(), isTrue);
    expect(File(BiologicalFactImage.blattFruchtReisenlebensbaum2).existsSync(),
        isTrue);
    expect(File(BiologicalFactImage.blattFruchtRiesenlebensbaum).existsSync(),
        isTrue);
    expect(File(BiologicalFactImage.blattFruchtWeihrauchzeder).existsSync(),
        isTrue);
    expect(File(BiologicalFactImage.blattRotbuche).existsSync(), isTrue);
    expect(File(BiologicalFactImage.blattWeihrauchzeder).existsSync(), isTrue);
    expect(File(BiologicalFactImage.blattWinterlinde).existsSync(), isTrue);
    expect(File(BiologicalFactImage.bluetenWinterlinde).existsSync(), isTrue);
    expect(File(BiologicalFactImage.borkeAstRiesenlebensbaum).existsSync(),
        isTrue);
    expect(
        File(BiologicalFactImage.borkeAstWeihrauchzeder).existsSync(), isTrue);
    expect(
        File(BiologicalFactImage.borkeAussehenRotbuche).existsSync(), isTrue);
    expect(File(BiologicalFactImage.borkeRotbuchemehr).existsSync(), isTrue);
    expect(File(BiologicalFactImage.borkeWinterlinde).existsSync(), isTrue);
    expect(File(BiologicalFactImage.fledermauskastenRotbuche).existsSync(),
        isTrue);
    expect(File(BiologicalFactImage.fruchtRotbucheBoden).existsSync(), isTrue);
    expect(File(BiologicalFactImage.fruchtVonRotbuche).existsSync(), isTrue);
    expect(File(BiologicalFactImage.vogelhausWinterlinde).existsSync(), isTrue);
  });
}
