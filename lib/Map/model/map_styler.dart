import 'package:lindenhofpark/Map/service/map_api_key.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

class MapStyler {
  Future<Style> readStyle() => StyleReader(
        uri:
            'https://tiles.stadiamaps.com/styles/osm_bright.json?api_key=$stadiaMapsApiKey',
        // ignore: undefined_identifier
        apiKey: stadiaMapsApiKey,
      ).read();
}
