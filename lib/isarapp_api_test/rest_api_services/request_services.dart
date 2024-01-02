import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobil_test_projesi1/isarapp_api_test/model_folder/custom_poi_models/custompoi_model.dart';
import 'package:mobil_test_projesi1/isarapp_api_test/model_folder/users_models/profil_get_model.dart';

void main() {
  // 'Override HttpClient creation' hataları için yazılmış metod, client servisinden önce yazılır ve çalışmalıdır.
  HttpOverrides.global = MyHttpOverrides();
  // RequestServices().request_Get_Profile(); //profil ile ilgili bilgileri get ile çeker
  RequestServices().request_Get_Custompois();
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

class RequestServices {
  static const String _baseUrl = "https://api.isarapp.com/api";
  late CustomPoisModel custompoiModel;
  static const String _token =
      "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0MWRiMjQ5Yy05NDJmLTRmNmQtYWY3ZC04MDUwOTU3NDc3ZWQiLCJmb3VuZGF0aW9uIjoiYzk3OGY5YTctN2U1YS00ZDBlLWFjODQtMTI1ZTgzMjY1YWMyIiwibGFuZyI6InRyIiwibmJmIjoxNzAyOTgzMTM1LCJleHAiOjE3MDUwNTY3MzUsImlhdCI6MTcwMjk4MzEzNX0.Q4BhAPnbza1NfFJxGIIqmpcIpHZoYTgwkvYlIHOlcEpVsCj_3Ee2Mn2dBuY8U-84kznMuLaM0ntvKe0FmzubIw";

  static const Map<String, String> _header = <String, String>{'Authorization': 'Bearer $_token', 'Content-Type': 'application/json'};

  ///User_profil ile ilgili bilgileri çeker ve listeler
  void request_Get_Profile() async {
    ProfileGetModel profileGetModel;
    const String _getUserProfilEndpoint = "/v1/users/profile";
    final Uri _urlVariable = Uri.parse(_baseUrl + _getUserProfilEndpoint);
    // final Uri _urlVariable = Uri.parse('https://api.isarapp.com/api/v1/users/profile');
    // final _urlVariable = Uri.https(_baseUrl, _getUserProfil_endpoint, {'q': '{http}'});
    // var response = await http.get(_urlVariable,);

    final response = await http.get(
      _urlVariable,
      // Headers parametresine bir 'Authorization' alanı ekleyin ve değerini 'Bearer {token}' olarak ayarlayın.
      headers: _header,
    );
    if (response.statusCode == HttpStatus.ok) {
      print('---!!! Status codu 200-OK döndü. Sonuç: '); // Print the response body for demo purposes
      Map<String, dynamic> _datas = json.decode(response.body);
      print("---Data: -- $_datas");
      profileGetModel = ProfileGetModel.fromJson(_datas);

      print("-------------");
      print("--- Örnek içerik valuelar ");
      print(profileGetModel.username);
      print(profileGetModel.lastName);
      print(profileGetModel.image);
      print(profileGetModel.addressDetail);
      print(profileGetModel.description != '' ? profileGetModel.description : "---");
      print("---------");
      print("--- Örnek içerik keyler ");

      final keys = _datas.keys;
      for (var key in keys) {
        if (keys.isEmpty) {
          print("Empty geldi!");
        }
        print(key);
      }

      print("--- Örnek içerik key ve value birlikte alınması. ");

      ///Bütün map yapısını gezer. Gezerken key ve valu değerlerini ayrı ayrı alır. Key değerleini ekrana basarken value değerlerinin boş olma durumunu kontrol eder.
      for (var entry in _datas.entries) {
        final keys2 = entry.key;
        final values = entry.value;
        print("Key: $keys2   Value: ${values == '' ? '--Değer boş' : '--Değer değil'}");
      }
    }
  }

  void request_Get_Custompois() async {
    const String _getCustompoiEndpoint = "/v1/custompois";
    final Uri _urlValue = Uri.parse(_baseUrl + _getCustompoiEndpoint);
    final _responseCustompois = await http.get(
      _urlValue,
      headers: _header,
    );

    if (_responseCustompois.statusCode == HttpStatus.ok) {
      print("-----Geri dönüş durumu 200");
      var customPoiData = json.decode(_responseCustompois.body);
      print(customPoiData);

      List<CustomPoisModel> custompoiModels = customPoiData.map<CustomPoisModel>((item) => CustomPoisModel.fromJson(item)).toList();

      print("---CustomPoiGetModel: ");
      for (var custompoiModel in custompoiModels) {
        print(
            'İd: ${custompoiModel.id}  '
                'Name: ${custompoiModel.name} '
                'description: ${custompoiModel.description} '
                'documentPaths: ${custompoiModel.documentPaths}  '
                'parentId: ${custompoiModel.parentId} '
                'isDeleted: ${custompoiModel.isDeleted}');
        print("--------");
        print('''
Addres Levels:  ${custompoiModel.addressDetail!.addressLevels!}      
note:  ${custompoiModel.addressDetail?.note}    
address lang:  ${custompoiModel.addressDetail!.longitude}   
address long:  ${custompoiModel.addressDetail!.latitude} ''');
      }
      print("--------");
      print("Keys:");
    }
  }

  Future<List<CustomPoisModel>?> request_Get_Custompois_Returned() async {
    const String _getCustompoiEndpoint = "/v1/custompois";
    final Uri _urlValue = Uri.parse(_baseUrl + _getCustompoiEndpoint);
    final _responseCustompois = await http.get(
      _urlValue,
      headers: _header,
    );

    if (_responseCustompois.statusCode == HttpStatus.ok) {
      print("-----Geri dönüş durumu 200");
      var customPoiData = json.decode(_responseCustompois.body);

      List<CustomPoisModel> custompoiModels = customPoiData.map<CustomPoisModel>((item) => CustomPoisModel.fromJson(item)).toList();

      if (!custompoiModels.isEmpty) {
        return custompoiModels;
      }
    }
    return null;
  }

  // List<CustomPoisModel>? request_Get_Custompois_Returned2() async {
  //   const String _getCustompoiEndpoint = "/v1/custompois";
  //   final Uri _urlValue = Uri.parse(_baseUrl + _getCustompoiEndpoint);
  //   final _responseCustompois = await http.get(
  //     _urlValue,
  //     headers: _header,
  //   );

  //   if (_responseCustompois.statusCode == HttpStatus.ok) {
  //     print("-----Geri dönüş durumu 200");
  //     var customPoiData = json.decode(_responseCustompois.body);

  //     List<CustomPoisModel> custompoiModels = customPoiData.map<CustomPoisModel>((item) => CustomPoisModel.fromJson(item)).toList();

  //     if (!custompoiModels.isEmpty) {
  //       return custompoiModels;
  //     }
  //   }
  //   return null;
  // }
}
