import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class PolyGoneLine extends StatefulWidget {
  const PolyGoneLine({Key? key}) : super(key: key);

  @override
  State<PolyGoneLine> createState() => _PolyGoneLineState();
}

class _PolyGoneLineState extends State<PolyGoneLine> {

  Completer<GoogleMapController> _controller=Completer();

  static final CameraPosition _initialPosition=CameraPosition(target: LatLng(32.1635, 74.1911),zoom: 14);


  Set<Polyline> polyline=Set<Polyline>();
  List<Marker> _marker=[];
  final List<LatLng> _list=const[
      LatLng(32.1635, 74.1911),
      LatLng(31.5204,74.3587),
    LatLng(32.1877,74.1945),
  ];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }
  
  void load(){
    for(int i=0;i<_list.length;i++){
      _marker.add(
        Marker(markerId: MarkerId(i.toString()),
          position: _list[i],
          infoWindow: InfoWindow(
            title:'this is index $i',
          )
        )
      );
      polyline.add(
        Polyline(polylineId: PolylineId('1'),
          points: _list,
          color: Colors.orange,
          geodesic: true,
          jointType: JointType.mitered
        )
      );
    }
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(initialCameraPosition: _initialPosition,

              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: Set<Marker>.of(_marker),
              polylines: polyline,
              onMapCreated:(GoogleMapController controller){
            _controller.complete(controller);
              },
          )

    );
  }
}
