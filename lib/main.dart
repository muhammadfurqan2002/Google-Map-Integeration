import 'package:flutter/material.dart';
import 'package:googlesmap/Maps/map1.dart';
import 'package:googlesmap/Maps/map2.dart';
import 'package:googlesmap/Maps/map3.dart';
import 'package:googlesmap/Maps/map4.dart';
import 'package:googlesmap/Maps/map5.dart';
import 'package:googlesmap/Maps/map6.dart';
import 'package:googlesmap/Maps/customMarker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CustomLocations()
    );
  }
}
