import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_toilet/utilities/utils.dart';
import 'package:find_toilet/utilities/tile_servers.dart';
import 'package:find_toilet/utilities/viewport_painter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final controller = MapController(
    location: const LatLng(35.203, 126.809),
    zoom: 16,
  );
  final bool _darkMode = false;

  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // print(position.latitude.abs());
    // print(position.longitude.abs());
    controller.center = LatLng(position.latitude, position.longitude);
    controller.zoom = 15;
    setState(() {});
  }

  // void _gotoDefault() {
  //   controller.center = const LatLng(35.203, 126.809);
  //   controller.zoom = 16;
  //   setState(() {});
  // }

  void _onDoubleTap(MapTransformer transformer, Offset position) {
    const delta = 0.5;
    final zoom = clamp(controller.zoom + delta, 2, 18);

    transformer.setZoomInPlace(zoom, position);
    setState(() {});
  }

  Offset? _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details, MapTransformer transformer) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;

      setState(() {});
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
      if (controller.zoom < 1) {
        controller.zoom = 1;
      }
      setState(() {});
    } else {
      final now = details.focalPoint;
      var diff = now - _dragStart!;
      _dragStart = now;
      final h = transformer.constraints.maxHeight;

      final vp = transformer.getViewport();
      if (diff.dy < 0 && vp.bottom - diff.dy < h) {
        diff = Offset(diff.dx, 0);
      }

      if (diff.dy > 0 && vp.top - diff.dy > 0) {
        diff = Offset(diff.dx, 0);
      }

      transformer.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Raster Map'),
      //   actions: [
      //     IconButton(
      //       tooltip: 'Toggle Dark Mode',
      //       onPressed: () {
      //         setState(() {
      //           _darkMode = !_darkMode;
      //         });
      //       },
      //       icon: const Icon(Icons.wb_sunny),
      //     ),
      //   ],
      // ),
      body: MapLayout(
        controller: controller,
        builder: (context, transformer) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onDoubleTapDown: (details) => _onDoubleTap(
              transformer,
              details.localPosition,
            ),
            onScaleStart: _onScaleStart,
            onScaleUpdate: (details) => _onScaleUpdate(details, transformer),
            child: Listener(
              behavior: HitTestBehavior.opaque,
              onPointerSignal: (event) {
                if (event is PointerScrollEvent) {
                  final delta = event.scrollDelta.dy / -1000.0;
                  final zoom = clamp(controller.zoom + delta, 2, 18);

                  transformer.setZoomInPlace(zoom, event.localPosition);
                  setState(() {});
                }
              },
              child: Stack(
                children: [
                  TileLayer(
                    builder: (context, x, y, z) {
                      final tilesInZoom = pow(2.0, z).floor();

                      while (x < 0) {
                        x += tilesInZoom;
                      }
                      while (y < 0) {
                        y += tilesInZoom;
                      }

                      x %= tilesInZoom;
                      y %= tilesInZoom;

                      return CachedNetworkImage(
                        imageUrl:
                            _darkMode ? googleDark(z, x, y) : google(z, x, y),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  CustomPaint(
                    painter: ViewportPainter(
                      transformer.getViewport(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: _gotoDefault,
        onPressed: () {
          getLocation();
        },
        tooltip: 'My Location',
        child: const Icon(Icons.my_location),
        // child: const Icon(Icons.add_box),
      ),
    );
  }
}
