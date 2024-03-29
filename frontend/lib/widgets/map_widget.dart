// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/icon_image.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/utilities/utils.dart';
import 'package:find_toilet/utilities/tile_servers.dart';
import 'package:find_toilet/utilities/viewport_painter.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  final bool showReview, needNear;
  final ReturnVoid? refreshPage;
  const MapScreen({
    super.key,
    this.showReview = false,
    required this.refreshPage,
    required this.needNear,
  });
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late MapController controller;
  final bool _darkMode = false;
  bool refreshState = false;
  int? length;

  List<LatLng> markers = [];
  List<LatLng> toiletMarkers = [];

  @override
  void initState() {
    super.initState();
    controller = MapController(
      location: LatLng(readLat(context)!, readLng(context)!),
      zoom: 15,
    );
  }

  void getOnlyToilet() async {
    double conLat = getToilet(context)!.lat;
    double conLng = getToilet(context)!.lng;
    toiletMarkers.clear();
    toiletMarkers.add(LatLng(conLat, conLng));
    setState(() {});
  }

  void getLocation([bool mode = true]) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (widget.showReview && mode == true) {
        double conLat = getToilet(context)!.lat;
        double conLng = getToilet(context)!.lng;
        controller.center = LatLng(conLat, conLng);
      } else {
        controller.center = LatLng(position.latitude, position.longitude);
      }

      setLatLng(context, position.latitude, position.longitude);

      if (markers.isEmpty) {
        markers.add(LatLng(position.latitude, position.longitude));
      } else {
        markers.clear();
        markers.add(LatLng(position.latitude, position.longitude));
      }

      toiletMarkers.clear();
      length = mainToiletList(context).length;
      for (int i = 0; i < length!; i++) {
        toiletMarkers.add(
          LatLng(
            mainToiletList(context)[i].lat,
            mainToiletList(context)[i].lng,
          ),
        );
        // }
      }
      setState(() {});
    } catch (error) {
      SystemNavigator.pop();
    }
  }

  void clickMarker(int markerIndex) {
    final toiletData = mainToiletList(context)[markerIndex];
    if (!widget.showReview || getToiletId(context) != toiletData.toiletId) {
      setMarker(context, markerIndex);
      setItemHeight(context, markerIndex);
      setToilet(context, toiletData);
      routerPush(
        context,
        page: Main(
          showReview: true,
          refreshPage: widget.refreshPage,
          needNear: widget.needNear,
        ),
      )();
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
    if (zoom > 8) {
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

  Widget _buildMarkerWidget(Offset pos, Color color, double size, int? index,
      [bool isMarker = true, bool isSelected = false]) {
    return Positioned(
      left: pos.dx - 24,
      top: pos.dy - 48,
      width: size,
      height: size,
      child: GestureDetector(
        child: Image.asset(isMarker
            ? isSelected
                ? selected
                : toilet
            : user),
        onTap: () {
          if (index != null) {
            clickMarker(index);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!getLoading(context)) {
      if (!refreshState) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            refreshState = true;
            widget.needNear ? getLocation() : getOnlyToilet();
          },
        );
      } else if (length != mainToiletList(context).length) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            getLocation();
          },
        );
      }
    }
    return Scaffold(
      body: GestureDetector(
        onTap: () => changeShow(context),
        child: MapLayout(
          controller: controller,
          builder: (context, transformer) {
            final lat = readLat(context);
            final lng = readLng(context);
            late final Iterable<Widget> markerWidgets;
            if (markers.isNotEmpty) {
              final markerPositions =
                  markers.map(transformer.toOffset).toList();
              markerWidgets = markerPositions.map(
                (pos) => _buildMarkerWidget(pos, Colors.red, 48, null, false),
              );
            } else {
              final markerPositions = [LatLng(lat ?? 35.203, lng ?? 126.809)]
                  .map(transformer.toOffset)
                  .toList();
              markerWidgets = markerPositions.map(
                (pos) => _buildMarkerWidget(
                    pos, const Color(0x00000000), 48, null, false),
              );
            }
            final List<Widget> toiletMarkerWidgets = [];
            final toileMarkerPositions =
                toiletMarkers.map(transformer.toOffset).toList();
            final selectedMarker =
                context.read<MainSearchProvider>().selectedMarker;
            for (int i = 0; i < toileMarkerPositions.length; i += 1) {
              toiletMarkerWidgets.add(_buildMarkerWidget(
                toileMarkerPositions[i],
                mainColor,
                i == selectedMarker ? 50 : 36,
                i,
                true,
                i == selectedMarker,
              ));
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
                    ...toiletMarkerWidgets,
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          watchMagnify(context) == '표시함'
              ? Align(
                  alignment: Alignment(
                      Alignment.bottomRight.x, Alignment.bottomRight.y - 0.75),
                  child: GestureDetector(
                    onTap: () => zoomIn(),
                    child: Container(
                        width: 42,
                        height: 42,
                        decoration: const BoxDecoration(
                            boxShadow: [defaultShadow],
                            color: whiteColor,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(6))),
                        child: const Center(
                          child: Icon(Icons.add),
                        )),
                  ),
                )
              : const SizedBox(),
          watchMagnify(context) == '표시함'
              ? Align(
                  alignment: Alignment(
                      Alignment.bottomRight.x, Alignment.bottomRight.y - 0.65),
                  child: GestureDetector(
                    onTap: () => zoomOut(),
                    child: Container(
                        width: 42,
                        height: 42,
                        decoration: const BoxDecoration(
                            boxShadow: [defaultShadow],
                            color: whiteColor,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(6))),
                        child: const Center(
                          child: Icon(Icons.remove),
                        )),
                  ),
                )
              : const SizedBox(),
          widget.needNear
              ? Align(
                  alignment: Alignment(
                      Alignment.bottomRight.x, Alignment.bottomRight.y - 0.45),
                  child: FloatingActionButton(
                    onPressed: () => getLocation(false),
                    backgroundColor: whiteColor,
                    mini: true,
                    tooltip: 'My Location',
                    child: const Icon(
                      Icons.my_location_rounded,
                      color: mainColor,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
