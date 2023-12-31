import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobil_test_projesi1/Dil_Islemleri/home_view.dart';
// import 'package:mobil_test_projesi1/home_view.dart';
import 'package:mobil_test_projesi1/Dil_Islemleri/init/product_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(ProductLocalization(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const SecondPage(),
    );
  }
}
