import 'package:flutter/material.dart';

enum Locales {
  tr(Locale('tr', 'TR')),
  en(Locale('en', 'US')),
  de(Locale('de', 'DE'));

  final Locale locale;
  const Locales(this.locale);
}
