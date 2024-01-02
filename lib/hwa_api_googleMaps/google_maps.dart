import 'package:flutter/material.dart';
import 'package:mobil_test_projesi1/hwa_api_googleMaps/google_maps_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, title: 'Material App', home: GoogleMapsView());
  }
}
