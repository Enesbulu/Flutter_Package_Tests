import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'GoogleMaps App',
      debugShowCheckedModeBanner: false,
      home: MyMaps(),
    );
  }
}

class MyMaps extends StatefulWidget {
  const MyMaps({super.key});

  @override
  _MyMapsState createState() => _MyMapsState();
}

double _originLatitude = 38.392300;
double _originLongitude = 27.047840;

class _MyMapsState extends State<MyMaps> {
  // Initializes Google Maps Controller -- Google Haritalar Denetleyicisini başlat
  late GoogleMapController _controller;

  // Sets initial camera position to MyMaps location -- Başlangıç ​​kamera konumunu Haritalarım konumuna ayarla
  static final CameraPosition _initalCameraPosition = CameraPosition(
    target: LatLng(_originLatitude, _originLongitude),
    zoom: 15,
  );

  // Current Map Type (Normal/Satellite) -- Mevcut Harita Türü (Normal/Uydu)
  MapType _currentMapType = MapType.normal;

  // Handles polyline operations -- Çoklu çizgi işlemlerini yönetin
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  // Set Destination Coordinates  -- Hedef Koordinatlarını Ayarla
  double _destLatitude = 52.008240;
  double _destLongitude = 28.978359;

  @override
  void initState() {
    super.initState();
    _getPolyline();
  }

// Get Polyline Function -- Harita Tipi Fonksiyonunu Değiştir
  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  // Get Polyline Function -- Çoklu Çizgi Fonksiyonunu Al
  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    // Get Route Between Coordinates -- Koordinatlar Arasındaki Rotayı Al
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "API Anahtarınız",
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
    );

    // Check if result is not empty
    if (result.points.isNotEmpty) {
      // Loop through coordinates // Extract Polyline from Result --- Koordinatlar arasında döngü yap --// Sonuçtan Çoklu Doğruyu Çıkar
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }

  // Set Polyline to Map -- Çoklu Çizgiyi Haritaya Ayarla
  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.pink,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _onMapTypeButtonPressed;
      //     goToLoc() {
      //       _controller.animateCamera(CameraUpdate.newLatLng(const LatLng(38.392300, 27.047840)));
      //     }
      //   },
      //   // child: Icon(Icons.map),
      // ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        mapType: _currentMapType,
        initialCameraPosition: _initalCameraPosition,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        polylines: Set<Polyline>.of(polylines.values),
        markers: _cretaeMarker(),
      ),
    );
  }

  Set<Marker> _cretaeMarker() {
    return <Marker>{
      Marker(
          infoWindow: const InfoWindow(title: "Kordon Alsancak"),
          markerId: const MarkerId("asdasd"),
          position: _initalCameraPosition.target,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)),
      Marker(
          infoWindow: const InfoWindow(title: "Ev"),
          markerId: const MarkerId("asdasdd"),
          position: const LatLng(38.392300, 27.047840),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)),
      Marker(
          infoWindow: const InfoWindow(title: "Konak Pier"),
          markerId: const MarkerId("asdsasdd"),
          position: const LatLng(38.422733197746986, 27.129490953156576),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)),
    }.toSet();
  }
}
