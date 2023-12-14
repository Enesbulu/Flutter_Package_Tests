import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageThird extends StatelessWidget {
  const PageThird({super.key, required this.prefs});
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    DateTime loginTime = DateTime.parse(prefs.getString('loginTime')!);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Merhaba ${prefs.getString('name')}',
            style: const TextStyle(fontSize: 24),
          ),
          Text(
            'Son giriş yaptığın tarihiniz : $loginTime',
            style: const TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}
