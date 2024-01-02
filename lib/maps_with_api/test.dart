// import 'dart:io';

// void main() {
//   HttpOverrides.global = MyHttpOverrides();
//   RequestService().getCustomPois();
//   return runApp(MyWidget());
// }

// abstract class IMarkerModel {
//   late String markerId;
//   late double latitude;
//   late double longitude;
// }

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//   }
// }
