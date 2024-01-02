import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

abstract class GoogleMapsViewModel extends State<GoogleMap> {
  late GoogleMapController controller;
}
