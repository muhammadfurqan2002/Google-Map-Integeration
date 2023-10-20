import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class Map3 extends StatefulWidget {
  const Map3({Key? key}) : super(key: key);

  @override
  State<Map3> createState() => _Map3State();
}

class _Map3State extends State<Map3> {
  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _initialPosition=const CameraPosition(target: LatLng(31.5204,74.3587)
  ,
    zoom: 14,
  );
  List<Marker> _list=[];
  final List<Marker> _marker=const [
    Marker(markerId: MarkerId('1'),
      position: LatLng(31.5204,74.3587),
      infoWindow: InfoWindow(title: 'This is First place')
    ),Marker(markerId: MarkerId('2'),
      position: LatLng(32.1877,74.1945),
      infoWindow: InfoWindow(title: 'This is Second place')
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
      body: GoogleMap(initialCameraPosition: _initialPosition
      ,
        mapType: MapType.normal,
        markers: Set<Marker>.of(_list),
        onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        onPressed: ()async{
          GoogleMapController controler=await _controller.future;
          controler.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(32.1877,74.1945),zoom: 14))
          );
        },
      ),
    )
    );

  }
}
