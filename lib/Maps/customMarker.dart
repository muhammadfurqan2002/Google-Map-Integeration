
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class CustomLocations extends StatefulWidget {
  const CustomLocations({Key? key}) : super(key: key);

  @override
  State<CustomLocations> createState() => _CustomLocationsState();
}

class _CustomLocationsState extends State<CustomLocations> {

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _initialPosition=CameraPosition(target: LatLng(32.1877,74.1945),zoom:14);

  List<Marker> _marker=[];

  List<String> images=[
    "images/china.png","images/india.png","images/pk.png","images/iran.png","images/afg.png",
  ];

  Uint8List? markerImage;
  List<LatLng> ln=<LatLng>[
    LatLng(35.8617, 104.1954),LatLng(20.5937,78.9629),LatLng(30.3753,69.3451),LatLng(32.4279,53.6880),LatLng(33.9391, 67.7100)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onLoad();
  }

  void onLoad()async{
    for(int i=0;i<images.length;i++){
      final Uint8List markerImage=await getBytesFromAssets(images[i], 100);
      _marker.add(
        Marker(markerId: MarkerId(i.toString(),),
            position: ln[i],
          icon: BitmapDescriptor.fromBytes(markerImage),
          infoWindow: InfoWindow(title:'This is Marker Number'+i.toString()),
        )
      );
    }
    setState(() {

    });
  }

  Future<Uint8List> getBytesFromAssets(String path,int width )async{
   ByteData data =await rootBundle.load(path);
   ui.Codec codec=await ui.instantiateImageCodec(data.buffer.asUint8List(),targetHeight: width);
    ui.FrameInfo fi=await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }






  @override
  Widget build(BuildContext context) {
    return  SafeArea(

      child: Scaffold(
        backgroundColor: Colors.white,
        body:GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: Set<Marker>.of(_marker),
          initialCameraPosition: _initialPosition,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        )
      ),
    );
  }





}
