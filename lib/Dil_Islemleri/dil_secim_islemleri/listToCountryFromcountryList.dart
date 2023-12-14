import 'package:mobil_test_projesi1/TestConsole/console_test.dart';

///Bu kod, ülkeler listesine ve ilgili kodlara dayalı olarak ülke kodlarının bir listesini oluşturur. Listedeki her öğe arasında geçiş yapar ve ülke adını ve kodunu ilgili listelere ekler. Son olarak ülke kodlarının listesini döndürür.
List<String> listToCountryFromcountryList() {
  //Liste içerisinde bulunan ülke paketlerinden her bir ülkenin ismini almak için oluşturulan liste.
  late List<String> countryListLongSyntax = [];

  //Liste içerisinde bulunan ülke paketlerinden her bir ülkenin kodunu almak için oluşturulan liste.
  late List<String> countryList = [];

  for (var i = 0; i < countryMap.length; i++) {
    /// Burada ülkelerin İsimlerini listeye atama işlemi yapılmakta. Map içeirisnde bulunan 'title' a bağlı olarak arama yapar. Liste içerisi örnek olarak ['Türkçe,'English','Deutsch','العربية']
    countryListLongSyntax.add(countryMap[i]['title']);

    /// Burada ülkelere ait kısa kodlamaları listeye atama işlemi yapılmakta. Liste içerisi örnek olarak ['tr','en','de','ar']
    countryList.add(countryMap[i].values.elementAt(countryMap[i].length - 1));
  }
  return countryList;
}
