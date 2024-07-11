import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lindenhofpark/resources/resources.dart';

void main() {
  test('biological_fact_image assets test', () {
    expect(File(BiologicalFactImage.blattAstRotbuche).existsSync(), isTrue);
    expect(File(BiologicalFactImage.blattRotbuche).existsSync(), isTrue);
    expect(
        File(BiologicalFactImage.borkeAussehenRotbuche).existsSync(), isTrue);
    expect(File(BiologicalFactImage.borkeRotbuchemehr).existsSync(), isTrue);
    expect(File(BiologicalFactImage.fledermauskastenRotbuche).existsSync(),
        isTrue);
    expect(File(BiologicalFactImage.fruchtRotbucheBoden).existsSync(), isTrue);
    expect(File(BiologicalFactImage.fruchtVonRotbuche).existsSync(), isTrue);
    expect(File(BiologicalFactImage.ganzerBaumRotbuche).existsSync(), isTrue);
  });
}
