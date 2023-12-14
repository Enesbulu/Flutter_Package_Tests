// import 'dart:convert';
// import 'package:http/http.dart' as http; //Kod içerisinde kullanılan http instance tanımlaması burada gösterildiği gibi tnaımlanıyor.
// import 'package:flutter/material.dart';

// class HttpHomePage extends StatelessWidget {
//   HttpHomePage({super.key});

//   Future<List<dynamic>> fetchPosts() async {
//     const String baseUrl = "https://jsonplaceholder.typicode.com/posts";
//     var result = await http.get("https://jsonplaceholder.typicode.com/posts" as Uri);
//     // var result = await http.get(baseUrl);
//     // const String baseUrl = 'https://api.isarapp.com/api';

//     const String customPoi = "$baseUrl/v1/custompois";

//     return json.decode(baseUrl.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Http Kullanımı"),
//       ),
//       body: FutureBuilder(
//         future: fetchPosts(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               padding: const EdgeInsets.all(8.0),
//               itemCount: snapshot.data.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: Column(
//                     children: [
//                       Text("Title:  ${snapshot.data[index]['title']}"),
//                       Text("Body: ${snapshot.data[index]['body']}"),
//                     ],
//                   ),
//                 );
//               },
//             );
//           } else {
//             // return const Center(child: CircularProgressIndicator());
//             return const Text("Yükleniyor...");
//           }
//         },
//       ),
//     );
//   }
// }


// /*

// static final String baseUrl = 'https://api.isarapp.com/api';

// static final String customPoi = "$baseUrl/v1/custompois";

// Future<void> getCustomPoiList(String parameters) async {
// try {
// _getToken();
// isLoading.value = true;
//   items = RxList<CustomPoiDto>();
//   final response = await http.get(
//       UrlHelper.customPoi + "?pageSize=1000&" + parameters,
//       headers: {'Authorization': 'Bearer ' + _authToken});

//   final extractedData = json.decode(response.body) as List<dynamic>;

//   extractedData.forEach((element) {
//     items.add(CustomPoiDto.fromJson(element));
//   });

//   isLoading.value = false;
// } catch (e) {
//   throw e;
// }

// ‌class CustomPoiDto {
//   String id;
//   String name;
//   String description;
//   CustomPoiTypeDto customPoiType;
//   List<DetailStructureDto> details;
//   List<String> documentPaths;
//   AddressModel addressDetail;

//   CustomPoiDto({
//     this.id,
//     this.name,
//     this.description,
//     this.customPoiType,
//     this.details,
//     this.documentPaths,
//     this.addressDetail,
//   });

//   factory CustomPoiDto.fromJson(Map<String, dynamic> json) =>
//       _$CustomPoiDtoFromJson(json);
//   Map<String, dynamic> toJson() => _$CustomPoiDtoToJson(this);
// */
