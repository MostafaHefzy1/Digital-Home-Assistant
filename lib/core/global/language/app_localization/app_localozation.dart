import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale? locale;

  AppLocalization(this.locale);


  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }
  late  Map<String, String> _loadedLocalizedValues;

  Future loadLang() async {
    String langFile =
    await rootBundle.loadString('lib/core/global/language/lang/${locale?.languageCode}.json');
    Map<String, dynamic> loadedValues = jsonDecode(langFile);
    _loadedLocalizedValues =
        loadedValues.map((key, value) => MapEntry(key, value.toString()));
  }

  String? getTranslated(String key) {
    return _loadedLocalizedValues[key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate = _AppLocalDelegate();
}

class _AppLocalDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization appLocale = AppLocalization(locale);
    await appLocale.loadLang();
    return appLocale;
  }

  @override
  bool shouldReload(_AppLocalDelegate old) => false;
}
extension TranslateX on String{
  String? tr(BuildContext context){
    return AppLocalization.of(context)!.getTranslated(this);
  }
}
