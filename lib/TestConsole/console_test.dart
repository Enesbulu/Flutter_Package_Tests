import 'package:flutter/material.dart';

void main() {
  print('deneme');
  for (var i = 0; i < countryMap.length; i++) {
    print(countryMap[i].keys.contains('locale'));
  }
}

///Ülkelerin dil, bayrak ve dil kodlarının bulunduğu Liste
final List<Map<String, dynamic>> countryMap = [
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
