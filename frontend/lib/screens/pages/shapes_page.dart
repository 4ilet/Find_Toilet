import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_toilet/screens/utils/utils.dart';
import 'package:find_toilet/screens/utils/tile_servers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

class ShapesPage extends StatefulWidget {
  const ShapesPage({Key? key}) : super(key: key);

  @override
  ShapesPageState createState() => ShapesPageState();
}

class ShapesPageState extends State<ShapesPage> {
  final controller = MapController(
    location: const LatLng(0, 0),
    zoom: 3,
  );

  static const polyCoords = [
    LatLng(40, -60),
    LatLng(20, -20),
    LatLng(0, -10),
    LatLng(10, 0),
    LatLng(0, 10),
    LatLng(20, 20),
    LatLng(0, 60),
  ];

  double _polylineOffset = 5;

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
    final polylines = <Polyline>[
      Polyline(
        data: polyCoords,
        paint: Paint()
          ..strokeWidth = 4
          ..color = Colors.red,
      ),
      Polyline(
        data: polyCoords,
        offset: _polylineOffset,
        paint: Paint()
          ..strokeWidth = 4
          ..color = Colors.blue,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shapes'),
      ),
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
                        imageUrl: google(z, x, y),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  PolylineLayer(
                    transformer: transformer,
                    polylines: polylines,
                  ),
                  PositionedDirectional(
                    top: 24,
                    start: 24,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Slider(
                        value: _polylineOffset,
                        min: -32,
                        max: 32,
                        label: '$_polylineOffset px',
                        divisions: 64,
                        onChanged: (v) {
                          setState(() {
                            _polylineOffset = v;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
