import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobil_test_projesi1/isarapp_api_test/model_folder/custom_poi_models/custompoi_model.dart';
import 'package:mobil_test_projesi1/maps_with_api/isar_app_token.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MapsApiMarker());
}

GoogleMapController? mapController;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MapsApiMarker extends StatefulWidget {
  MapsApiMarker({Key? key}) : super(key: key);
  @override
  _MapsApiMarkerState createState() => _MapsApiMarkerState();
}

class _MapsApiMarkerState extends State<MapsApiMarker> {
  Future<Set<Marker>> temp = AddressDetailMarker().createCustomMarker();
  Set<Marker> temp2 = <Marker>{};
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    convertMarker();
  }

  void convertMarker() async {
    temp2 = await AddressDetailMarker().createCustomMarker();
    setState(() {});
  }

  String? selectedMarker; // seçilen markerın id'sini tutan değişken
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: <Widget>[
          FutureBuilder<Set<Marker>>(
            future: temp,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.isNotEmpty) {
                return GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(10, 10),
                    zoom: 5,
                  ),
                  markers: snapshot.data!.map<Marker>((Marker marker) {
                    return marker.copyWith(
                      zIndexParam: marker.markerId.value == selectedMarker ? 10.0 : 1.0,
                      infoWindowParam: marker.markerId.value == selectedMarker
                          ? InfoWindow(
                              title: marker.infoWindow.title,
                              snippet: marker.infoWindow.snippet,
                              onTap: () {
                                setState(
                                  () {
                                    // mapController!.animateCamera(CameraUpdate.newLatLng(marker.position));
                                    mapController!.animateCamera(
                                      CameraUpdate.newLatLngZoom(
                                        marker.position,
                                        18.0,
                                      ),
                                    );

                                    // CameraPosition(target: marker.position, zoom: 2.0);
                                  },
                                );
                              },
                            )
                          : marker.infoWindow,
                    );
                  }).toSet(),
                  onTap: (position) {
                    setState(
                      () {
                        selectedMarker = null;
                      },
                    );
                  },
                  onMapCreated: (controller) {
                    setState(() {
                      mapController = controller;
                    });
                  },
                );
              } else {
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
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: temp2.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMarker = temp2.elementAt(index).markerId.value;
                      });
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                          temp2.elementAt(index).infoWindow.title!,
                          // style: const TextStyle(colo r: Colors.white),
                        ),
                        onTap: () async {
                          Set<Marker> temp3 = await temp;
                          Marker temp2Marker = temp3.elementAt(index);
                          mapController!.animateCamera(
                            // CameraUpdate.newLatLng(temp3.elementAt(index).position),
                            CameraUpdate.newLatLngZoom(temp2Marker.position, 12.0),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
              position: element.latlong,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
              infoWindow: InfoWindow(title: element.markerId == "" ? "NoName" : element.markerId),
              alpha: 1.0,
              zIndex: 15),
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

        mapController?.animateCamera(CameraUpdate.newLatLng(addressDetailsMarker.latlong)); //?
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

extension MapLatLong on AddressDetailMarker {
  LatLng get latlong => LatLng(latitude, longitude);
}
