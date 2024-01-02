import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobil_test_projesi1/google_maps_packet/google_maps_making2/marker_location_assignment.dart';
import 'package:mobil_test_projesi1/google_maps_packet/google_maps_making2/marker_model.dart';

class HaritaSayfasi extends StatefulWidget {
  const HaritaSayfasi({super.key});

  @override
  State<HaritaSayfasi> createState() => _HaritaSayfasiState();
}

late double _originLatitude; //Enlem
late double _originLongitude; //Boylam

class _HaritaSayfasiState extends State<HaritaSayfasi> {
  late GoogleMapController mapController; //GoogleMapController instance oluşturulması.
  late final TextEditingController _controller = TextEditingController();
  late Future<MarkerModel?> _markerStateFuture;
  late MarkerModel _markerState;

// --- ?? ----
  Future updateMaker() async {
    _markerStateFuture = LocationMarkerState().CustomPoiModelState();

    if (_markerStateFuture != null) {
      _markerState = (await _markerStateFuture)!;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateMaker();
  }

  static const CameraPosition initalCameraPosition = CameraPosition(
    target: LatLng(40.721249, 30.721750),
    zoom: 500.0,
  );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMap(
        initialCameraPosition: initalCameraPosition,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomControlsEnabled: true,
      ),
    );
  }
}
