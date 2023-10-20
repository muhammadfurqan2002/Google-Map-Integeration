import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class LANLTG_To_Address extends StatefulWidget {
  const LANLTG_To_Address({Key? key}) : super(key: key);

  @override
  State<LANLTG_To_Address> createState() => _LANLTG_To_AddressState();
}

class _LANLTG_To_AddressState extends State<LANLTG_To_Address> {

  Completer<GoogleMapController> _controller=Completer();

  static final CameraPosition _initalPosition=CameraPosition(target: LatLng(31.5204,74.3587),zoom: 14);

  List<Marker> _list=[];
  final List<Marker> _markers=<Marker>[
    Marker(markerId: MarkerId('1'),
    position: LatLng(31.5204,74.3587),
    )
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            GestureDetector(
              onTap: ()async{


                List<Placemark> placemarks = await placemarkFromCoordinates(31.5204,74.3587);

                    var location=placemarks.reversed.last.country.toString()+"  "+placemarks.reversed.last.locality.toString();
                    print(location);
                },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                    height: 50,
                  color: Colors.orange,
                  child: const Center(child: Text('Get Address',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),),
                ),
              ),
            ),
            SizedBox(height:20,),
            GestureDetector(
              onTap: ()async{


                List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");

                    var longLati=locations.reversed.last.latitude.toString()+","+locations.reversed.last.longitude.toString();
                    print(longLati);
                },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                    height: 50,
                  color: Colors.orange,
                  child: const Center(child: Text('Get LatLng',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),),
                ),
              ),
            )
          ],
      ),
    );
  }
}


// return SafeArea(child: Scaffold(
// body:GoogleMap(initialCameraPosition: _initalPosition,
// onMapCreated: (GoogleMapController controller){
// _controller.complete(controller);
// },
// )
// ));