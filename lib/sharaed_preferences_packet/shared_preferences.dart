import 'package:flutter/material.dart';
import 'package:mobil_test_projesi1/sharaed_preferences_packet/shared_preferences_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Material App', home: SharedPreferencesPage());
  }
}

class SharedPreferencesPage extends StatefulWidget {
  const SharedPreferencesPage({super.key});

  @override
  State<SharedPreferencesPage> createState() => _SharedPreferencesPageState();
}

class _SharedPreferencesPageState extends State<SharedPreferencesPage> {
  TextEditingController nameController = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences Paket'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text("Giriş"),
              onPressed: () {
                String name = nameController.text;
                prefs.setString('name', name);
                prefs.setString('loginTime', DateTime.now().toString());
                print(" -------- Kullanıcı adi : ${prefs.getString('name')}");
                print("---Kullanıcının Giriş tarihi : ${prefs.getString('loginTime')}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  late SharedPreferences prefs;
  SecondPage({
    super.key,
  });
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late TextEditingController nameController;
  late SharedPreferences prefs;
  late String? sonGiris;

  // @override
  // void initState() {
  //   super.initState();
  //   SharedPreferences.getInstance().then((value) {
  //     prefs = value;
  //   });
  //   nameController = TextEditingController(text: "prefs.getString('name')");
  //   sonGiris = prefs.getString('loginTime');
  //   // sonGiris = widget.prefs.getString('sonGiris')!;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Anasayfa")), body: PageBody()
        /*Center(
        child: Column(
          children: [
            TextField(
                controller: nameController,
                decoration:
                    const InputDecoration(labelText: "Adınız Soyadınız")),
            Text(sonGiris!),
          ],
        ),
      ),*/
        );
  }
}
