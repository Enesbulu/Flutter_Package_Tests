# locale_keys.g.dart dosyası gibi bir dil dosyasını otomatik oluşturtmak için konsola girilen komut.
# lib/Dil_Islemleri/init/language => dosuyanın oluşturulacağı yolu belirtir.
# locale_keys.g.dart => Oluşturulaccak dosyanın adını belirtir.
# asset/translations => ilgili dosyanın kaynağı/yolunu belirtir.


!/bin/bin

flutter pub run easy_localization:generate  -O lib/Dil_Islemleri/init/language -f keys -o locale_keys.g.dart --source-dir asset/translations