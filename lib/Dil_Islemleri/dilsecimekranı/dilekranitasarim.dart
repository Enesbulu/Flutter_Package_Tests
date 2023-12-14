import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dil Seçimi'),
        ),
        body: DilSecimi(),
      ),
    );
  }
}

class DilSecimi extends StatelessWidget {
  final List<Map<String, dynamic>> diller = [
    {
      'title': 'Türkçe',
      'icon': Image.asset(
        'icons/flags/png/tr.png',
        package: 'country_icons',
        width: 45,
        height: 45,
      ),
      'locale': 'tr'
    },
    {
      'title': 'English',
      'icon': Image.asset(
        'icons/flags/png/gb.png',
        package: 'country_icons',
        width: 45,
        height: 45,
      ),
      'locale': 'en'
    },
    {
      'title': 'Deutsch',
      'icon': Image.asset(
        'icons/flags/png/de.png',
        package: 'country_icons',
        width: 45,
        height: 45,
      ),
      'locale': 'de'
    },
    // {'title': 'English', 'icon': Icons.flag, 'locale': 'en'},
    // {'title': 'Deutsch', 'icon': Icons.flag, 'locale': 'de'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: ListView.builder(
        itemCount: diller.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: diller[index]['icon'],
            title: Text(diller[index]['title'],
                style: const TextStyle(fontSize: 20)),
            onTap: () {
              // Dil seçimi mantığı buraya eklenecek
              print('Dil seçildi: ${diller[index]['locale']}');
            },
          );
        },
      ),
    );
  }
}




/*import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(DenemeApp());
}

class DenemeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: DenemeHome(),
    );
  }
}

class DenemeHome extends StatefulWidget {
  const DenemeHome({super.key});

  @override
  _DenemeHomeState createState() => _DenemeHomeState();
}

class _DenemeHomeState extends State<DenemeHome> {
  String ulke = 'tr';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deneme Bayrak'),
      ),
      body: GridView.count(
        // primary: false,
        // padding: const EdgeInsets.all(30.0),
        crossAxisSpacing: 50.0,
        crossAxisCount: 3,
        children: <Widget>[
          Image.asset('icons/flags/png/de.png', package: 'country_icons'),
          Image.asset('icons/flags/png/gb.png', package: 'country_icons'),
          Image.asset('icons/flags/png/fr.png', package: 'country_icons'),
          Image.asset('icons/flags/png/es.png', package: 'country_icons'),
          Image.asset('icons/flags/png/it.png', package: 'country_icons'),
          Image.asset('icons/flags/png/$ulke.png', package: 'country_icons'),
          Image.asset('icons/flags/png/$ulke.png', package: 'country_icons'),
          Image.asset('icons/flags/png/2.5x/de.png', package: 'country_icons'),
          Image.asset('icons/flags/png/2.5x/gb.png', package: 'country_icons'),
          Image.asset('icons/flags/png/2.5x/fr.png', package: 'country_icons'),
          Image.asset('icons/flags/png/2.5x/es.png', package: 'country_icons'),
          Image.asset('icons/flags/png/2.5x/it.png', package: 'country_icons'),
          Image.asset('icons/flags/png/2.5x/eu.png', package: 'country_icons'),
          SvgPicture.asset('icons/flags/svg/de.svg', package: 'country_icons'),
          SvgPicture.asset('icons/flags/svg/gb.svg', package: 'country_icons'),
          SvgPicture.asset('icons/flags/svg/fr.svg', package: 'country_icons'),
          SvgPicture.asset('icons/flags/svg/es.svg', package: 'country_icons'),
          SvgPicture.asset('icons/flags/svg/it.svg', package: 'country_icons'),
          SvgPicture.asset('icons/flags/svg/eu.svg', package: 'country_icons'),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/