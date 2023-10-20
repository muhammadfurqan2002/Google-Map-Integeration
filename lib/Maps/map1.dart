import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map_1 extends StatefulWidget {
  const Map_1({super.key});

  @override
  State<Map_1> createState() => _Map_1State();
}

class _Map_1State extends State<Map_1> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _currentPosition = const CameraPosition(
    target: LatLng(32.1877, 74.1945),
    zoom: 14,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _currentPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
