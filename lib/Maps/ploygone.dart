import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';






class RedZone extends StatefulWidget {
  const RedZone({Key? key}) : super(key: key);

  @override
  State<RedZone> createState() => _RedZoneState();
}

class _RedZoneState extends State<RedZone> {

  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _initialPosition=CameraPosition(target: LatLng(32.173702501123785, 74.19230401770201),zoom: 14);


  Set<Polygon> polygon=HashSet<Polygon>();
  List<LatLng> _lng=[
    LatLng(32.173702501123785, 74.19230401770201),
    LatLng(32.17360272384331, 74.17789956620898),
    LatLng(32.1635, 74.1911),
    LatLng(32.173702501123785, 74.19230401770201),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();

  }

  void load(){
    polygon.add(
      Polygon(polygonId: PolygonId('1'),
          points: _lng,
        fillColor: Colors.white54,
        strokeWidth: 4,
        strokeColor: Colors.yellowAccent,
        geodesic: true,
      )
    );
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:_initialPosition,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        polygons: polygon,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}
