import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobil_test_projesi1/maps_with_api/isar_app_token.dart';
import 'package:mobil_test_projesi1/maps_with_api/models/custom_pois_model.dart';
import 'package:http/http.dart' as http;

void main() {
  HttpOverrides.global = MyHttpOverrides();
  RequestService().getCustomPois();
  return runApp(MyWidget());
}

class MapsWithApi extends StatefulWidget {
  const MapsWithApi({super.key});

  @override
  State<MapsWithApi> createState() => _MapsWithApiState();
}

class _MapsWithApiState extends State<MapsWithApi> {
  Set<Marker>? temp; // temp'i Set<Marker> olarak tanımlayın
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    temp = null;
    createCustomMarker();
  }

  Future<void> createCustomMarker() async {
    AddressDetailMarker addressMarker = AddressDetailMarker();
    temp = (await addressMarker.createCustomMarker()) as Set<Marker>?;
    setState(() {}); // Yeniden çizim yapmak için setState kullanın.
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: const CameraPosition(
            target: LatLng(41.015137, 28.979530),
            zoom: 15,
          ),
          markers: temp ?? <Marker>{}.toSet(), // temp null değilse markers'a ekleyin
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Set<Marker>>(
      future: AddressDetailMarker().createCustomMarker(), // Future nesnesini belirtin
      builder: (BuildContext context, AsyncSnapshot<Set<Marker>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Future henüz tamamlanmadıysa
          return const CircularProgressIndicator(); // Yüklenme göstergesi gösterin
        } else if (snapshot.hasError) {
          // Future hata ile tamamlandıysa
          return Text('Hata: ${snapshot.error}');
        } else {
          // Future başarıyla tamamlandıysa
          return const MapsWithApi();
        }
      },
    );
  }
}

class AddressDetailMarker extends IMarkerModel {
  Future<Set<Marker>> createCustomMarker() async {
    List<AddressDetailMarker>? customPoiMarkerValues = await RequestService().getCustomPois();
    if (customPoiMarkerValues != null) {
      AddressDetailMarker tempMarker = AddressDetailMarker();
      int i = 0;
      for (var element in customPoiMarkerValues) {
        tempMarker.latitude = element.latitude;
        i++;
        Set<Marker> createMarker() {
          return <Marker>{
            Marker(
                markerId: MarkerId(element.markerId ?? i.toString()),
                position: LatLng(element.latitude, element.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                infoWindow: InfoWindow(title: "Marker $i")),
          };
        }
      }
    }
    return {};
  }
}

class RequestService extends State<GoogleMap> {
  late CustomPoisModel custompoiModel;

  static const Map<String, String> _header = <String, String>{'Authorization': 'Bearer ${TokenInfo.token}', 'Content-Type': 'application/json'};

  Future<List<AddressDetailMarker>?> getCustomPois() async {
    final Uri _urlValue = Uri.parse(TokenInfo.baseUrlWithEndPoint);
    final _customPois = await http.get(_urlValue, headers: _header);
    AddressDetailMarker addressDetailsMarker = AddressDetailMarker();
    List<AddressDetailMarker> listAddressdetailMarkers = [];

    if (_customPois.statusCode == 200) {
      var dataResponseCustomPoi = json.decode(_customPois.body);

      List<CustomPoisModel> customPoisModel = await dataResponseCustomPoi.map<CustomPoisModel>((item) => CustomPoisModel.fromJson(item)).toList();
      print(customPoisModel);

      for (var i = 0; i < customPoisModel.length; i++) {
        addressDetailsMarker.latitude = customPoisModel[i].addressDetail!.latitude!;
        addressDetailsMarker.longitude = customPoisModel[i].addressDetail!.longitude!;
        listAddressdetailMarkers.add(addressDetailsMarker);
      }
      for (var element in listAddressdetailMarkers) {
        print("---Latitute: ${element.latitude}  Longitude: ${element.longitude}   ---değerleri! ${element.createCustomMarker()}");
      }
      //TODO --marker tipine cast edilmeli
      if (listAddressdetailMarkers.isEmpty || listAddressdetailMarkers != null) return listAddressdetailMarkers;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

abstract class IMarkerModel {
  late String markerId;
  late double latitude;
  late double longitude;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
