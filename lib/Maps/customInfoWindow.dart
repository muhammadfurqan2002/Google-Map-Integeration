import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';





class CustomWindow extends StatefulWidget {
  const CustomWindow({Key? key}) : super(key: key);

  @override
  State<CustomWindow> createState() => _CustomWindowState();
}

class _CustomWindowState extends State<CustomWindow> {

    CustomInfoWindowController _controller=CustomInfoWindowController();

    List<Marker> _marker=[];

  List<String> images=[
    "images/china.png","images/india.png","images/pk.png","images/iran.png","images/afg.png",
  ];

  List<LatLng> ln=<LatLng>[
    LatLng(35.8617, 104.1954),LatLng(20.5937,78.9629),LatLng(30.3753,69.3451),LatLng(32.4279,53.6880),LatLng(33.9391, 67.7100)
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData(){
    for(int i=0;i<ln.length;i++){
     _marker.add(Marker(markerId: MarkerId(i.toString()),
      position: ln[i],
       icon: BitmapDescriptor.defaultMarker,
       onTap: (){
          _controller.addInfoWindow!(
            Container(
              width: 300,
              height:200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                         image: AssetImage(images[i])
                        )
                      ),
                    ),
                    ListTile(
                      title: Text('Country'),
                      subtitle: Text('Every One Loves Their Country'),
                    )
                  ],
                ),
            ),
            ln[i]
          );

       }
     ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Stack(
          children: [
            GoogleMap(
              markers: Set<Marker>.of(_marker),
              initialCameraPosition: CameraPosition(target: LatLng(20.5937,78.9629),zoom: 14)
            ,
            onTap: (position){
                _controller.hideInfoWindow!();
              },
              onCameraMove: (position){
                  _controller.onCameraMove!();
              },
              onMapCreated: (GoogleMapController controller){
                  _controller.googleMapController=controller;
              },
            ),
            CustomInfoWindow(
              controller: _controller,
              height: 200,
              width: 300,
              offset: 35,
            )

          ],
        ),
      ),
    );
  }
}
