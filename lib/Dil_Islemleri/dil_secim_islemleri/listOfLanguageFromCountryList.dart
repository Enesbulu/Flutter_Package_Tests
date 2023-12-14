import 'package:mobil_test_projesi1/TestConsole/console_test.dart';

///Bu kod parçacığı 'countryMap' listesinden dil seçmek ve bunları List<String> olarak döndürmek için kullanılır. 'countryMap' listesi boyunca döngü yapar ve her haritanın son değerini 'languageList'e ekler. Son olarak 'languageList'i döndürür. Son değer olarak da dillerin kısa kodu olan map içerisindeki {...,'locale': 'tr'} den 'tr' gelir
List<String> listOfLanguageFromCountryList() {
  late List<String> languageList = [];

//LanguageList'i diller haritasının son değerleriyle doldurun
  for (var i = 0; i < countryMap.length; i++) {
    languageList.add(countryMap[i].values.elementAt(countryMap[i].length - 1));
  }
  return languageList;
}
