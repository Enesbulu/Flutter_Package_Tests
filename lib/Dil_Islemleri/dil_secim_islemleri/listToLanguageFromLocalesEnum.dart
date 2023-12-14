import 'package:mobil_test_projesi1/TestConsole/test_enum.dart';

///Bu kod, Locales numaralandırmasındaki dil adlarını karşılık gelen dil kodlarına dönüştürerek dil kodlarının bir listesini oluşturur. Dil kodları, her numaralandırma değerinin toString() çıktısının noktada ('.') bölünmesi ve ikinci kısmın alınmasıyla elde edilir. Example => Output: tr, en, de
List<String> listToLanguageFromLocalesEnum() {
  late List<String> dillerList = [];
  for (var i = 0; i < Locales.values.length; i++) {
    dillerList.add((Locales.values[i].toString().split('.')[1]));
  }
  return dillerList;
}
