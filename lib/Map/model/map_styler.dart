import 'package:lindenhofpark/Map/service/map_api_key.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

class MapStyler {
  Future<Style> readStyle() => StyleReader(
        uri:
            'https://api.maptiler.com/maps/basic-v2/style.json?key=${mapTilerApiKey}',
        // ignore: undefined_identifier
        apiKey: mapTilerApiKey,
      ).read();
}
