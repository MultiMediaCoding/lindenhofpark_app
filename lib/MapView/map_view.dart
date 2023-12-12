import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lindenhofpark/MapView/map_manager.dart';
import 'package:lindenhofpark/MapView/map_object.dart';
import 'package:lindenhofpark/MapView/map_objects.dart';
import 'package:lindenhofpark/MapView/url_manager.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

final UrlManager urlManager = UrlManager();
final mapManager = MapManager();

class _MapViewState extends State<MapView> {
  @override
  void initState() {
    super.initState();
    mapManager.determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapManager.controller,
      options: MapOptions(
          initialCenter: mapManager.lindenhofparkPosition, initialZoom: 17),
      children: [
        TileLayer(
          urlTemplate: mapManager.mapUrl,
          maxNativeZoom: 20,
          retinaMode: true,
        ),
        StreamBuilder(
            stream: mapManager.positionStream,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.data?.latitude != null &&
                  snapshot.data?.longitude != null) {
                return AnimatedLocationMarkerLayer(
                  position: LocationMarkerPosition(
                      latitude: snapshot.data!.latitude,
                      longitude: snapshot.data!.longitude,
                      accuracy: 2),
                );
              }
              return const SizedBox();
            }),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () async =>
                  await urlManager.launchOpenStreetMapCopyrightSite(),
            ),
          ],
        ),
        MarkerClusterLayerWidget(
          options: MarkerClusterLayerOptions(
            maxClusterRadius: 40,
            size: const Size(40, 40),
            markers: mapManager.markers,
            builder: (context, markers) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue),
                child: Center(
                  child: Text(
                    markers.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class MapPin extends StatelessWidget {
  const MapPin({super.key, required this.mapObject});

  final MapObject mapObject;

  @override
  Widget build(BuildContext context) {
    final icon = SvgPicture.asset(mapObject.category.iconPath,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn));
    return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: mapObject.category.pinColor,
            border: Border.all(color: Colors.white, width: 3)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: icon,
        ));
  }
}
