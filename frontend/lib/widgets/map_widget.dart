import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/utilities/utils.dart';
import 'package:find_toilet/utilities/tile_servers.dart';
import 'package:find_toilet/utilities/viewport_painter.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final controller = MapController(
    location: const LatLng(35.145, 126.844),
    zoom: 16,
  );
  final bool _darkMode = false;

  List<LatLng> markers = [];

  void getLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      print(permission);
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      controller.center = LatLng(position.latitude, position.longitude);
      GlobalProvider().setLatLng(position.latitude, position.longitude);

      if (markers == []) {
        markers.add(LatLng(position.latitude, position.longitude));
      } else {
        markers.clear();
        markers.add(LatLng(position.latitude, position.longitude));
      }
      // controller.zoom = 16;
      setState(() {});
    } catch (error) {
      SystemNavigator.pop();
    }
  }

  void zoomIn() {
    var zoom = controller.zoom;
    if (zoom < 19) {
      controller.zoom = zoom + 1;
    }
    setState(() {});
  }

  void zoomOut() {
    var zoom = controller.zoom;
    if (zoom > 7) {
      controller.zoom = zoom - 1;
    }
    setState(() {});
  }

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

  Widget _buildMarkerWidget(Offset pos, Color color, double size,
      [IconData icon = Icons.radio_button_checked]) {
    return Positioned(
      left: pos.dx - 24,
      top: pos.dy - 48,
      width: size,
      height: size,
      child: GestureDetector(
        child: Icon(
          icon,
          color: color,
          size: size,
        ),
        onTap: () {
          if (controller.zoom < 16) {
            controller.zoom = 16;
          }
          getLocation();
        },
      ),
    );
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
          late final Iterable<Widget> markerWidgets;
          if (markers != []) {
            final markerPositions = markers.map(transformer.toOffset).toList();
            markerWidgets = markerPositions.map(
              (pos) => _buildMarkerWidget(pos, Colors.red, 48),
            );
          } else {
            final markerPositions = [const LatLng(35.203, 126.809)]
                .map(transformer.toOffset)
                .toList();
            markerWidgets = markerPositions.map(
              (pos) => _buildMarkerWidget(pos, const Color(0x00000000), 48),
            );
          }
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
                  ...markerWidgets,
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(
                Alignment.bottomRight.x, Alignment.bottomRight.y - 0.4),
            child: GestureDetector(
              onTap: () => zoomIn(),
              child: Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(6))),
                  child: const Center(
                    child: Icon(Icons.add),
                  )),
            ),
          ),
          Align(
            alignment: Alignment(
                Alignment.bottomRight.x, Alignment.bottomRight.y - 0.3),
            child: GestureDetector(
              onTap: () => zoomOut(),
              child: Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(6))),
                  child: const Center(
                    child: Icon(Icons.remove),
                  )),
            ),
          ),
          Align(
            alignment: Alignment(
                Alignment.bottomRight.x, Alignment.bottomRight.y - 0.15),
            child: FloatingActionButton(
              // onPressed: _gotoDefault,
              onPressed: () {
                getLocation();
              },
              backgroundColor: whiteColor,
              mini: true,
              tooltip: 'My Location',
              child: const Icon(
                Icons.my_location_rounded,
                color: mainColor,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          BottomAppBar(height: MediaQuery.of(context).size.height * 0.08),
    );
  }
}
