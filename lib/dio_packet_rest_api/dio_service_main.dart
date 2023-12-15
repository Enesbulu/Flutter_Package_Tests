import 'package:flutter/material.dart';
import 'package:mobil_test_projesi1/dio_packet_rest_api/dio_api_service/service_learn_get_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'HTTP Demo', home: ServiceLearn());
  }
}
