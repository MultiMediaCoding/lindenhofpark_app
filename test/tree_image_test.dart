import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lindenhofpark/resources/resources.dart';

void main() {
  test('tree_image assets test', () {
    expect(File(TreeImage.ganzerBaumRiesenlebensbaum).existsSync(), isTrue);
    expect(File(TreeImage.ganzerBaumRotbuche).existsSync(), isTrue);
    expect(File(TreeImage.ganzerBaumSchwarzkiefer).existsSync(), isTrue);
    expect(File(TreeImage.ganzerBaumUrweltmamutbaum).existsSync(), isTrue);
    expect(File(TreeImage.ganzerBaumWeihrauchzeder).existsSync(), isTrue);
    expect(File(TreeImage.ganzerBaumWinterlinde).existsSync(), isTrue);
  });
}
