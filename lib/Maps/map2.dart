import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class Map2 extends StatefulWidget {
  const Map2({Key? key}) : super(key: key);

  @override
  State<Map2> createState() => _Map2State();
}

class _Map2State extends State<Map2> {

  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition p= const CameraPosition(target: LatLng(31.5204,74.3587),
      zoom: 14
  );
  List<Marker> _list=[];
  final List<Marker> _marker=const [
    Marker(
        markerId:MarkerId("1"),
        position: LatLng(31.5204,74.3587),

        infoWindow: InfoWindow(title: 'This is lahore')
    ),
     Marker(
        markerId:MarkerId("2"),
        position: LatLng(32.1877,74.1945),
        infoWindow: InfoWindow(title: 'This is Gujranwala')
    ),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _list.addAll(_marker);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: GoogleMap(
        initialCameraPosition: p,
        markers: Set<Marker>.of(_list),
        // myLocationEnabled: true,
        onMapCreated:(GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    ));
  }
}
