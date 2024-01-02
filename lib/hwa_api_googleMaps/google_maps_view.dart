import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsView extends StatefulWidget {
  const GoogleMapsView({super.key});

  @override
  State<GoogleMapsView> createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  late GoogleMapController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatActionButton(),
      body: MapsBody(),
    );
  }

  ///GoogleMaps Body tasarımı
  GoogleMap MapsBody() {
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: _kLake,
      onMapCreated: (map) {
        controller = map;
      },
      markers: _createMarker(),
    );
  }

  ///Markeri ekleme işlemi  ilgili konuma yönlendirme buton işlemi
  FloatingActionButton FloatActionButton() {
    return FloatingActionButton(onPressed: () {
      controller.animateCamera(CameraUpdate.newLatLng(const LatLng(40.721249, 30.721750)));
    });
  }
}

///Örnek bir konum verisi
const CameraPosition _kLake = CameraPosition(
  // bearing: 192.354896546,
  // tilt: 59.657354354,
  target: LatLng(41.015137, 28.979530),
  zoom: 14.109099972,
);

///Marker tanımlaması
Set<Marker> _createMarker() {
  return <Marker>{
    Marker(
      markerId: const MarkerId("asad"),
      position: _kLake.target,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      zIndex: 100, //markerın diğerlerinden önde gözükmeis için boyut atama
      infoWindow: const InfoWindow(title: "Fatih/İstanbul"),
    ),
    Marker(
      markerId: const MarkerId("sads"),
      position: const LatLng(40.721249, 30.721750),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      zIndex: 100, //markerın diğerlerinden önde gözükmeis için boyut atama
      infoWindow: const InfoWindow(title: "Fatih/İstanbul"),
    ),
    Marker(
      markerId: const MarkerId("sdfr"),
      position: const LatLng(40.9845, 30.721750),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      zIndex: 100, //markerın diğerlerinden önde gözükmeis için boyut atama
      infoWindow: const InfoWindow(title: "Fatih/İstanbul"),
    ),
  };
}

///
extension GoogleMapsMarker on GoogleMapsView {}
