import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lindenhofpark/resources/resources.dart';

void main() {
  test('historical_place_image assets test', () {
    expect(File(HistoricalPlaceImage.badestelleLindenhofpark).existsSync(),
        isTrue);
    expect(File(HistoricalPlaceImage.buchenwaeldleLindenhofpark).existsSync(),
        isTrue);
    expect(
        File(HistoricalPlaceImage.friedensraeumeGarten).existsSync(), isTrue);
    expect(File(HistoricalPlaceImage.friedensraeumeLindenhofpark).existsSync(),
        isTrue);
    expect(
        File(HistoricalPlaceImage.friedensraeumeSommer).existsSync(), isTrue);
    expect(File(HistoricalPlaceImage.friedenssaeule).existsSync(), isTrue);
    expect(File(HistoricalPlaceImage.gaertnerhausLindenhofpark).existsSync(),
        isTrue);
    expect(File(HistoricalPlaceImage.grabFriedrichGruber).existsSync(), isTrue);
    expect(File(HistoricalPlaceImage.lindenalleelindenhofpark).existsSync(),
        isTrue);
    expect(File(HistoricalPlaceImage.nutzundziergarten).existsSync(), isTrue);
    expect(File(HistoricalPlaceImage.ruineDegelstein).existsSync(), isTrue);
    expect(File(HistoricalPlaceImage.schweizerhausLindenhofpark).existsSync(),
        isTrue);
    expect(File(HistoricalPlaceImage.seeschloessleLindenhofpark).existsSync(),
        isTrue);
  });
}
