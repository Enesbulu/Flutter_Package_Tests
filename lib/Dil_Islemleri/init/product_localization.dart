import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobil_test_projesi1/Dil_Islemleri/enums/locales.dart';

final class ProductLocalization extends EasyLocalization {
  ProductLocalization({
    required super.child,
    super.key,
  }) : super(
          supportedLocales: _supportedLocales,
          path: _translationPath,
          useOnlyLangCode: true,
        );

  ///Elimizde bulunna ve desteklenen dillerin listesini tuttuğumuz yer
  static final List<Locale> _supportedLocales = [
    Locales.tr.locale,
    Locales.en.locale,
    Locales.de.locale,
  ];

  static const String _translationPath =
      "asset/translations"; // Path to your translation files

  ///Dil değişikliğini sağladığımız yer
  static Future<void> updateLanguage({
    required BuildContext context,
    required Locales value,
  }) =>
      context.setLocale(value.locale);
}
