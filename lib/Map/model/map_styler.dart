import 'package:lindenhofpark/Map/service/stadiaMapsApiKey.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

class MapStyler {
  Future<Style> readStyle() => StyleReader(
        uri:
            'https://tiles-eu.stadiamaps.com/styles/osm_bright.json?api_key=${stadiaMapsApiKey}',
      ).read();
}
