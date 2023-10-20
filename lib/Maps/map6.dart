import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;





class SearchPlaces extends StatefulWidget {
  const SearchPlaces({Key? key}) : super(key: key);

  @override
  State<SearchPlaces> createState() => _SearchPlacesState();
}

class _SearchPlacesState extends State<SearchPlaces> {

    List<dynamic> _list=[];

  final TextEditingController _controller=TextEditingController();

  var uuid=Uuid();
    String sessionToken="122344";
  @override
  void initState(){
    super.initState();
    _controller.addListener(() {
      onchange();
    });
  }

  void onchange(){

    setState(() {
      sessionToken=Uuid().v4();
    });
    getSuggestion(_controller.text.toString());
  }
  void getSuggestion(String input)async{

    String apiKey="AIzaSyAD6b9pIHqqegOTtadQNtPCe5x2esIMFr4";
    String baseUrl="https://maps.googleapis.com/maps/api/place/autocomplete/json";
      String request='$baseUrl?input=$input&key=$apiKey&sessiontoken=$sessionToken';
      var response=await http.get(Uri.parse(request));
      var data=response.body.toString();
      print(data);
      if(response.statusCode==200){
        setState(() {
          _list=jsonDecode(response.body.toString())['predictions'];
        });
      }else{
        throw Exception('Error Occur While Fetching Data');
      }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:const Center(child: Text('Search Places API')),
          backgroundColor: Colors.amberAccent,
        ),
        backgroundColor: Color(0xfff456676),
        body: Column(
          children: [

            Padding(

              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search here...',
                  fillColor: Colors.white54,
                  filled: true,
                ),
              ),
            ),
            // Expanded(child: Column(
            //   children: [
            //           ListView.builder(
            //             // itemCount:_list.size(),
            //               itemBuilder: (context,index){
            //                 // return ListTile(title: ,);
            //
            //           })
            //   ],
            // ))
          ],
        ),
      ),
    );
  }
}
