import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobil_test_projesi1/Dil_Islemleri/dil_secim_islemleri/listToLanguageFromLocalesEnum.dart';
import 'package:mobil_test_projesi1/Dil_Islemleri/enums/locales.dart';
import 'package:mobil_test_projesi1/Dil_Islemleri/init/language/locale_keys.g.dart';
import 'package:mobil_test_projesi1/Dil_Islemleri/init/product_localization.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar:
      //     MyAppBar(), //YourAppBar(title: const Text("TestAppBar")), //AppBar(
      //   title: const Text('Material App Bar'),
      // ),
      body: SecondPage(),

      // body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      //   Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       const Text(LocaleKeys.home_title).tr(),
      //       const Text(LocaleKeys.general_dialog_version_title).tr(),
      //       ElevatedButton(
      //         onPressed: () {
      //           ProductLocalization.updateLanguage(
      //             context: context,
      //             value: Locales.tr,
      //           );
      //         },
      //         child: const Text("Tr"),
      //       ),
      //       ElevatedButton(
      //         onPressed: () {
      //           ProductLocalization.updateLanguage(
      //             context: context,
      //             value: Locales.en,
      //           );
      //         },
      //         child: const Text("En"),
      //       ),
      //       ElevatedButton(
      //         onPressed: () {
      //           ProductLocalization.updateLanguage(
      //             context: context,
      //             value: Locales.de,
      //           );
      //         },
      //         child: const Text("De"),
      //       ),
      //       ElevatedButton(
      //         onPressed: () {},
      //         child: Text(window.locale.toString()),
      //       ),
      //     ],
      //   ),
      // ]),
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
    {
      'title': 'العربية',
      'icon': Image.asset(
        'icons/flags/png/sa.png',
        package: 'country_icons',
        width: 45,
        height: 45,
      ),
      'locale': 'ar'
    },
  ];

  DilSecimi(BuildContext context);

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
              ProductLocalization.updateLanguage(
                  context: context, value: SelectLanguage(diller[index])
                  //SelectLangague(diller.elementAt(index))

                  // value: Locales.values = [diller[index]['title']],
                  );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SecondPage()),
              );
              print('Dil seçildi: ${diller[index]['title']}');
            },
          );
        },
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
// Seçili sayfanın indeksini tutan bir değişken
  int _selectedIndex = 0;

  // Sayfaların içeriklerini tutan bir liste
  final List<Widget> _pages = [
    Center(
      child: Column(
        children: [
          const Text(LocaleKeys.general_button_save).tr(),
          const Text(LocaleKeys.general_dialog_version_title).tr()
        ],
      ),
    ),
    Center(
      child: const Text(LocaleKeys.general_button_save).tr(),
    ),
    Center(
      child: const Text(LocaleKeys.general_button_save).tr(),
    ),
  ];

  // Widget'ın görünümünü oluşturan metot
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YourAppBar(title: ("TestAppBar")),
      // appBar: AppBar(
      //   title: const Text('Flutter Footer Example'),
      // ),
      body: _pages[_selectedIndex], // Seçili sayfanın içeriğini göster
      // Footer oluşturmak için BottomNavigationBar widget'ını kullan
      bottomNavigationBar: BottomNavigationBar(
        items: [
          // Navigasyon çubuğunda gösterilecek olan simge ve metinleri belirle
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: (LocaleKeys.home_title).tr(),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex, // Seçili sayfanın indeksini belirle
        onTap:
            _onItemTapped, // Kullanıcı bir sayfaya dokunduğunda ne yapılacağını belirle
        type: BottomNavigationBarType
            .fixed, // Navigasyon çubuğunun tipini belirle
        backgroundColor:
            Colors.blue, // Navigasyon çubuğunun arka plan rengini belirle
        selectedItemColor: Colors.white, // Seçili öğenin rengini belirle
        unselectedItemColor:
            Colors.black, // Seçilmemiş öğelerin rengini belirle
      ),
    );
  }

  // Kullanıcı bir sayfaya dokunduğunda indeksi güncelleyen bir fonksiyon
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

///Bu işlev, bağımsız değişken olarak bir Map<String,dynamic> alır. localesList boyunca yinelenir ve geçerli yerel ayarın geçici haritanın son dizinindeki değeri içerip içermediğini kontrol eder. Bir eşleşme bulunursa, Locales listesinden karşılık gelen Yerel Ayarı döndürür. Aksi takdirde dil seçim işlemi sırasında bir hata oluştuğunu belirten bir istisna atar.
Locales SelectLanguage(Map<String, dynamic> temp) {
  // List<String> countryList = listToCountryFromcountryList();
  // List<String> langList = listOfLanguageFromCountryList();
  List<String> localesList = listToLanguageFromLocalesEnum();
  for (var i = 0; i < localesList.length; i++) {
    if (localesList[i].contains(temp.values.elementAt(temp.length - 1))) {
      return Locales.values[i];
    }
  }
  return throw Exception("Dil seçiminde bir hata oluştur");
}

/*Widget AppBarTest() {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("TestBar"),
    );
  }
}*/

/*Widget AppBarTest() {
  return AppBar(
    title: const Text("TestBar"),
    centerTitle: true,
    // backgroundColor: AppTheme.mainThemeColor(),
    // brightness: Brightness.dark,
  );
}*/

class MyAppBar extends AppBar {
  MyAppBar({super.key, required super.title});

  Widget build(BuildContext context, String title) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.black,
      title: Text(title),
    );
  }
}

class YourAppBar extends AppBar {
  YourAppBar({super.key, required String title});
  // : super(title: title, actions: <Widget>[
  //     IconButton(onPressed: () {}, icon: const Icon(Icons.access_alarm)),
  //   ]);

  Widget build(String title) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text(title),
    );
  }
}
