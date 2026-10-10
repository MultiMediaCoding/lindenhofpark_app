# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Flutter app (German UI) for the Lindenhofpark: an interactive map of trees and historical places, with detail sheets, a searchable/filterable list, and a licenses screen. Requires Dart ^3.13 / Flutter >=3.47. Targets iOS primarily (also has android/web/desktop scaffolding).

## Commands

- `flutter pub get` — install dependencies
- `flutter run` — run the app
- `flutter analyze` — lint (`flutter_lints`; platform folders and `build/` are excluded)
- `flutter test` — run all tests; single file: `flutter test test/map_objects_test.dart`
- `spider build` — regenerate `lib/resources/*.dart` asset constants (config in `spider.yaml`)

## Architecture

Feature-folder layout under `lib/` (`Home`, `Map`, `PlacesList`, `PlaceDetails`, `BiologicalFacts`, `Licenses`, `Common`), each split into `model` / `view` / `view_model` (plus `service`). State uses `provider` with `ChangeNotifier` view models (e.g. `MapViewModel`). Entry: `main.dart` → `HomeView` (a `Stack` of `MapView` + `SearchButton`).

### Data is hard-coded, linked by title

There is no backend or database. Content lives in Dart constants:
- `Map/model/map_objects.dart` — `mapObjects`: every marker (title, category, `LatLng`).
- `PlaceDetails/model/trees/trees.dart` and `historical_places/historical_places.dart` — the detail content (text, images, `BiologicalFact`s).

A map object is joined to its detail record **by exact title string** (`trees.getTreeByTitle`, `historicalPlaces.getHistoricalPlaceByTitle`), and `PlaceViewModel.getViewOfMapObject` picks `TreeView` or `HistoricalPlaceView` by category. When adding a place, add entries to both lists with identical titles; `test/map_objects_test.dart` enforces this for historical places.

### Assets

Image/icon paths are generated constants (`TreeImage`, `BiologicalFactImage`, `HistoricalPlaceImage`, `FontAwesomeIcon` in `lib/resources/`, exported via `resources.dart`) — never hand-write asset paths and don't hand-edit generated files. After adding/removing files in `assets/...` (dirs listed in `pubspec.yaml`), run `spider build`. The generated tests (`test/*_image_test.dart`, `font_awesome_icon_test.dart`) verify the files exist.

### Map

`flutter_map` with vector tiles (`vector_map_tiles`) styled from Stadia Maps (`Map/model/map_styler.dart`, key in `Map/service/stadia_maps_api_key.dart`), plus marker clustering, location marker (`geolocator`), and compass. Park bounds/center constants are in `MapViewModel`.

### UI conventions

Recent work follows iOS HIG: native Cupertino sheet for the places list, `DraggableScrollableSheet` for details (`PlaceDetails/common/view/sheet/`), glassmorphism helpers in `Common/view/`. Theme uses bundled `Inter` font and Material 3 with a green seed.
