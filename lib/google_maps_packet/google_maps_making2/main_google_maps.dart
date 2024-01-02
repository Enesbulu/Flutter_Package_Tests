import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobil_test_projesi1/google_maps_packet/google_maps_making2/harita_tasarimi.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Isar Maps App', debugShowCheckedModeBanner: false, home: HaritaSayfasi());
  }
}

///Bu kod bloğu, createHttpClient yöntemini geçersiz kılarak HttpOverrides sınıfını genişletir. Özel bir badCertificateCallback işleviyle özelleştirilmiş bir HttpClient örneği döndürür. Bu geri çağırma işlevi, SSL sertifikası doğrulama hatalarını yok sayar ve kendinden imzalı sertifikalara izin verir.
class MyHttpOverrides extends HttpOverrides {
  // HttpClient oluşturma işlemini geçersiz kıl
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // Kendinden imzalı sertifikalara izin ver
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
