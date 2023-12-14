import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageBody extends StatelessWidget {
  PageBody({
    super.key,
  });
  late SharedPreferences prefs;
  late String? loginTime;
  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    // loginTime = DateTime.parse(prefs.getString('loginTime'));
    loginTime = prefs.getString('loginTime');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              // Text(
              //   'Merhaba ${prefs.getString('name')}',
              //   style: const TextStyle(fontSize: 24),
              // ),
              // Text(
              //   'Son giriş yaptığın tarihiniz : ${prefs.getString('name')}', //$loginTime',
              //   style: const TextStyle(fontSize: 18),
              // ),
              Text(loginTime!),
            ],
          )
        ],
      ),
    );
  }
}
