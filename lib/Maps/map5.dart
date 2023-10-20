import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class UserLoaction extends StatefulWidget {
  const UserLoaction({Key? key}) : super(key: key);

  @override
  State<UserLoaction> createState() => _UserLoactionState();
}

class _UserLoactionState extends State<UserLoaction> {
  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _initial=CameraPosition(target: LatLng(31.5204,74.3587),zoom: 14);

  List<Marker> _list=[];
  List<Marker> _marker=<Marker>[
    Marker(markerId: MarkerId('1'),
      position: LatLng(31.5204,74.3587),
      infoWindow: InfoWindow(title: 'This is My childhood city'),
    )
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _list.addAll(_marker);
  }

  @override
  Widget build(BuildContext context) {

    Future<Position>getLocation()async{
        await Geolocator.requestPermission().then((value){

        }).onError((error, stackTrace){
          print("Error"+error.toString());
        });

        return await Geolocator.getCurrentPosition();
    }
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initial,
        markers: Set<Marker>.of(_list),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(

        child: Icon(Icons.location_city),
        onPressed: ()async{
              final GoogleMapController controller=await _controller.future;
              getLocation().then((value)async{
                print("My Current Location");
                print(value.latitude);
                print(value.longitude);
                _marker.add(
                  Marker(markerId: MarkerId('2'),
                  position: LatLng(value.latitude,value.longitude),
                    infoWindow: InfoWindow(title: ('My HomeTown'))
                  ),

                );

    List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude ,value.longitude);


    final add = placemarks.first;
    var address = add.locality.toString() +" "+add.administrativeArea.toString()+" "+add.subAdministrativeArea.toString()+" "+add.country.toString();
        print(address);
    setState(() {

    });


              });


        },
      ),
    );
  }
}
