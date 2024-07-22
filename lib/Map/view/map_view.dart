import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_compass/flutter_map_compass.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:lindenhofpark/Common/view/vector_icon.dart';
import 'package:lindenhofpark/Licenses/view/licenses_view.dart';
import 'package:lindenhofpark/Map/view_model/map_view_model.dart';
import 'package:lindenhofpark/Map/model/map_object.dart';
import 'package:lindenhofpark/Map/view_model/url_view_model.dart';
import 'package:lindenhofpark/PlaceDetails/view/place_details_view.dart';
import 'package:lindenhofpark/resources/resources.dart';
import 'package:provider/provider.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

final UrlViewModel urlViewModel = UrlViewModel();
const styleUrl =
    "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png";

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MapViewModel(),
        child: Consumer<MapViewModel>(builder: (context, viewModel, child) {
          return FlutterMap(
            mapController: viewModel.controller,
            options: MapOptions(
              cameraConstraint: CameraConstraint.contain(
                  bounds: LatLngBounds(viewModel.lindenhofparkBegin,
                      viewModel.lindenhofparkEnd)),
              initialZoom: 18,
              maxZoom: 22,
              minZoom: 10,
              initialCenter: viewModel.lindenhofparkCenterPosition,
              interactionOptions: const InteractionOptions(
                enableMultiFingerGestureRace: true,
                flags: InteractiveFlag.doubleTapDragZoom |
                    InteractiveFlag.doubleTapZoom |
                    InteractiveFlag.drag |
                    InteractiveFlag.flingAnimation |
                    InteractiveFlag.pinchZoom |
                    InteractiveFlag.rotate |
                    InteractiveFlag.scrollWheelZoom,
              ),
            ),
            children: [
              _map(),
              _locationMarker(),
              _contributorsInfo(),
              _markersCluster(),
              _compass()
            ],
          );
        }));
  }

  Widget _map() {
    return Consumer<MapViewModel>(builder: (context, viewModel, child) {
      if (viewModel.style != null &&
          viewModel.style?.theme != null &&
          viewModel.style?.sprites != null &&
          viewModel.style?.providers != null)
        return VectorTileLayer(
            tileProviders: viewModel.style!.providers,
            theme: viewModel.style!.theme,
            sprites: viewModel.style!.sprites,
            maximumZoom: 22,
            tileOffset: TileOffset.DEFAULT,
            layerMode: VectorTileLayerMode.vector);

      return const SizedBox();
    });
  }

  Widget _locationMarker() {
    return Consumer<MapViewModel>(builder: (context, viewModel, child) {
      return StreamBuilder(
          stream: viewModel.positionStream,
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
          });
    });
  }

  Widget _contributorsInfo() {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, bottom: 20.0),
      child: RichAttributionWidget(
        popupBorderRadius: BorderRadius.circular(10),
        openButton: (context, open) => IconButton(
            onPressed: () => open(),
            icon: VectorIcon(
              icon: FontAwesomeIcon.circleInfoSolid,
              size: 20,
            )),
        closeButton: (context, close) => IconButton(
          onPressed: () => close(),
          icon: VectorIcon(
            icon: FontAwesomeIcon.circleXmarkSolid,
            size: 20,
          ),
        ),
        attributions: [
          TextSourceAttribution(
            'OpenStreetMap contributors',
            onTap: () async =>
                await urlViewModel.launchOpenStreetMapCopyrightSite(),
          ),
          TextSourceAttribution('Lizenzen',
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LicensesView(),
                    ),
                  )),
        ],
      ),
    );
  }

  // Neccesarry for the clustering numbers to be shown
  Widget _markersCluster() {
    return Consumer<MapViewModel>(builder: (context, viewModel, child) {
      return MarkerClusterLayerWidget(
        options: MarkerClusterLayerOptions(
          maxClusterRadius: 40,
          size: const Size(40, 40),
          markers: viewModel.markers,
          rotate: true,
          builder: (context, markers) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 58, 127, 60)),
              child: Center(
                child: Text(
                  markers.length.toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _compass() {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: const MapCompass(
                  icon: Icon(Icons.arrow_upward),
                  hideIfRotatedNorth: false,
                ))),
      ),
    );
  }
}

class MapPin extends StatelessWidget {
  const MapPin({super.key, required this.mapObject});

  final MapObject mapObject;

  @override
  Widget build(BuildContext context) {
    final icon = VectorIcon(
      icon: mapObject.category.icon,
      size: 40,
      color: Colors.white,
    );

    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlaceDetailsView(mapObject: mapObject),
      )),
      child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: mapObject.category.pinColor,
              border: Border.all(color: Colors.white, width: 3)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: icon,
          )),
    );
  }
}
