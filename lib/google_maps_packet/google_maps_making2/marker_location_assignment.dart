import 'package:mobil_test_projesi1/google_maps_packet/google_maps_making2/marker_model.dart';
import 'package:mobil_test_projesi1/isarapp_api_test/model_folder/custom_poi_models/custompoi_model.dart';
import 'package:mobil_test_projesi1/isarapp_api_test/rest_api_services/request_services.dart';

class LocationMarkerState {
  Future<MarkerModel?> CustomPoiModelState() async {
    List<CustomPoisModel>? requestListValue = await RequestServices().request_Get_Custompois_Returned();
    if (requestListValue == null) return null;
    AddressDetail? representativeLocation = requestListValue[0].addressDetail;
    late MarkerModel representativeMarker = MarkerModel(
        latitude: representativeLocation!.latitude!,
        longitude: representativeLocation.longitude!,
        title: representativeLocation.note!,
        snippet: "Test");
    return representativeMarker;
  }
}
