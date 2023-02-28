import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_toilet/screens/utils/celestial.dart';
import 'package:find_toilet/screens/utils/tile_servers.dart';
import 'package:find_toilet/screens/utils/utils.dart';
import 'package:find_toilet/screens/utils/twilight.dart';
import 'package:find_toilet/screens/utils/twilight_painter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

class TwilightPage extends StatefulWidget {
  const TwilightPage({Key? key}) : super(key: key);

  @override
  TwilightPageState createState() => TwilightPageState();
}

class TwilightPageState extends State<TwilightPage> {
  final controller = MapController(
    location: const LatLng(0, 0),
    zoom: 2,
  );

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (t) {
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
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
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      transformer.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toUtc();
    final civil = Twilight.civil(now);
    final sun = getSunLocation(now);
    final moon = getMoonLocation(now);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Twilight'),
      ),
      body: MapLayout(
        controller: controller,
        builder: (context, transformer) {
          final sunPosition = transformer.toOffset(sun);
          final moonPosition = transformer.toOffset(moon);
          final polyline = transformer.toOffsetMany(civil.polyline).toList();
          final viewport = transformer.getViewport();

          if (civil.delta < 0) {
            polyline.insert(0, viewport.topLeft);
            polyline.add(viewport.topRight);
          } else {
            polyline.insert(0, viewport.bottomLeft);
            polyline.add(viewport.bottomRight);
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
                        imageUrl: google(z, x, y),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  CustomPaint(painter: TwilightPainter(polyline)),
                  Positioned(
                    left: sunPosition.dx - 24,
                    top: sunPosition.dy - 24,
                    width: 48,
                    height: 48,
                    child: const Tooltip(
                      message: 'Sun',
                      child: Icon(
                        Icons.sunny,
                        color: Colors.amber,
                        size: 48,
                      ),
                    ),
                  ),
                  Positioned(
                    left: moonPosition.dx - 32,
                    top: moonPosition.dy - 32,
                    width: 64,
                    height: 64,
                    child: Tooltip(
                      message: 'Moon',
                      child: Icon(
                        Icons.circle,
                        color: Colors.blueGrey.withOpacity(0.8),
                        size: 64,
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
