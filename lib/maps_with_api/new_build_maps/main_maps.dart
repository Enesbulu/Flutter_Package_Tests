import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobil_test_projesi1/isarapp_api_test/model_folder/custom_poi_models/custompoi_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobil_test_projesi1/maps_with_api/isar_app_token.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  return runApp(MapsApiMarker());
}

///Http Sertifika sorunlarını ezmek için kullanılan class
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

///Anaekran Yapısı
class MapsApiMarker extends StatelessWidget {
  MapsApiMarker({super.key});
  Future<Set<Marker>> temp = AddressDetailMarker().createCustomMarker();
  Set<Marker> temp2 = <Marker>{};

  @override
  void initState() {
    convertMarker();
  }

  void convertMarker() async {
    temp2 = await AddressDetailMarker().createCustomMarker();
    var temp3 = temp2.length;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: <Widget>[
          FutureBuilder(
            future: temp,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(10, 10),
                    zoom: 5,
                  ),
                  markers: snapshot.data,
                );
              } else {
                print("-------HasData = NULL oldu!!");
                return const Center(heightFactor: 20, widthFactor: 20, child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 5,
            height: 100,
            child: ListView.builder(
              itemCount: 2, //temp2.length,
              itemBuilder: (context, index) {
                return Text(
                  "data",
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

//Maps yapısı -katman

  // Widget get buildGoogleMap => FutureBuilder(
  //       future: AddressDetailMarker().createCustomMarker(),
  //       builder: (BuildContext context, AsyncSnapshot snapshot) {
  //         if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
  //           return GoogleMap(
  //             mapType: MapType.normal,
  //             initialCameraPosition: const CameraPosition(
  //               target: LatLng(10, 10),
  //               zoom: 5,
  //             ),
  //             markers: snapshot.data,
  //           );
  //         } else {
  //           print("-------HasData = NULL oldu!!");
  //           return const Center(heightFactor: 20, widthFactor: 20, child: CircularProgressIndicator());
  //         }
  //       },
  //     );

  // Widget get bottomListView => Positioned(bottom: 20, left: 20, right: 5, height: 100, child: Observer(builder: (context) => const Text("test562"))
  //     // child: Container(
  //     //   color: Colors.red,
  //     //   // child: ObserverList(),
  //     //   child: ListView.builder(
  //     //     itemBuilder: (context, index) {
  //     //       return const Card(
  //     //         child: Column(
  //     //           children: [
  //     //             Row(
  //     //               children: [Text("Test1")],
  //     //             ),
  //     //             Row(
  //     //               children: [Text("Test2")],
  //     //             ),
  //     //             Row(
  //     //               children: [Text("Test3")],
  //     //             ),
  //     //             Row(
  //     //               children: [Text("Test4")],
  //     //             ),
  //     //             Row(
  //     //               children: [Text("Test5")],
  //     //             )
  //     //           ],
  //     //         ),
  //     //       );
  //     //     },
  //     //   ),
  //     // ),
  //     );
}
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: 50, //geçici olarak card sayısı
//         itemBuilder: (context, index) => Card(
//               child: Text(),
//             ));
//   }
// }

class AddressDetailMarker extends IMarkerModel {
  Future<Set<Marker>> createCustomMarker() async {
    var customPoiMarkerValues = await RequestService().getCustomPois();
    Set<Marker>? markersList = {};
    if (customPoiMarkerValues != null) {
      int i = 0;
      for (AddressDetailMarker element in customPoiMarkerValues) {
        i++;
        markersList.add(
          Marker(
            markerId: MarkerId(element.markerId ?? i.toString()),
            position: LatLng(element.latitude, element.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
            infoWindow: InfoWindow(title: element.markerId == "" ? "NoName" : element.markerId),
          ),
        );
      }
    }
    if (markersList.isEmpty || markersList == null) print("---!! markers null dönüyor dikkat!!!!");
    return markersList;
  }
}

class RequestService {
  static const String _token = TokenInfo.token;
  static const Map<String, String> _header = <String, String>{'Authorization': 'Bearer $_token', 'Content-Type': 'application/json'};
  Future<List<AddressDetailMarker>?> getCustomPois() async {
    final Uri _urlValue = Uri.parse(TokenInfo.baseUrlWithEndPoint);
    final _customPois = await http.get(_urlValue, headers: _header);
    List<AddressDetailMarker> listAddressdetailMarkers = [];

    if (_customPois.statusCode == 200) {
      var dataResponseCustomPoi = json.decode(_customPois.body);

      List<CustomPoisModel> customPoisModel =
          await dataResponseCustomPoi.map<CustomPoisModel>((item) => CustomPoisModel.fromJson(item)).cast<CustomPoisModel>().toList();
      for (var i = 0; i < customPoisModel.length; i++) {
        AddressDetailMarker addressDetailsMarker = AddressDetailMarker();
        addressDetailsMarker.latitude = customPoisModel[i].addressDetail!.latitude!;
        addressDetailsMarker.longitude = customPoisModel[i].addressDetail!.longitude!;
        addressDetailsMarker.markerId = customPoisModel[i].addressDetail?.note ?? i.toString();
        listAddressdetailMarkers.add(addressDetailsMarker);
      }
    }
    if (listAddressdetailMarkers.isNotEmpty) return listAddressdetailMarkers;
  }
}

abstract class IMarkerModel {
  late String markerId;
  late double latitude;
  late double longitude;
}
