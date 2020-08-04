import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sprintf/sprintf.dart';

class _RousseauLocalizationsDelegate extends LocalizationsDelegate<RousseauLocalizations> {

  const _RousseauLocalizationsDelegate({this.newLocale});

  static const List<String> _SUPPORTED_LANGUAGES = <String>['it'];

  final Locale newLocale;

  @override
  bool isSupported(Locale locale) {
    return _SUPPORTED_LANGUAGES.contains(locale.languageCode);
  }

  @override
  Future<RousseauLocalizations> load(Locale locale) {
    return RousseauLocalizations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<RousseauLocalizations> old) {
    return true;
  }

}

class RousseauLocalizations {

  RousseauLocalizations(this.locale) {
    _localisedValues = <dynamic, dynamic>{};
  }
  
  Locale locale;
  
  static Map<dynamic, dynamic> _localisedValues;

  static RousseauLocalizations of(BuildContext context) {
    return Localizations.of<RousseauLocalizations>(
        context, RousseauLocalizations);
  }

  static String getText(BuildContext context, String messageKey) {
    return RousseauLocalizations.of(context).text(messageKey);
  }

  static String getTextPluralized(BuildContext context, String singularKey, String pluralKey, int number) {
    return number == 1 ?
        getText(context, singularKey)
        : getTextFormatted(context, pluralKey, <int>[number]);
  }

  static String getTextFormatted(BuildContext context, String messageKey, List<dynamic> args) {
    final String rawString = RousseauLocalizations.of(context).text(messageKey);
    return sprintf(rawString, args);
  }

  static Future<RousseauLocalizations> load(Locale locale) async {
    final RousseauLocalizations rousseauLocalizations = RousseauLocalizations(locale);
    final String jsonContent = await rootBundle.loadString('l10n/${locale.languageCode}.json');
    _localisedValues = json.decode(jsonContent);
    return rousseauLocalizations;
  }

  static const LocalizationsDelegate<RousseauLocalizations> delegate = _RousseauLocalizationsDelegate();


  String get currentLanguage => locale.languageCode;

  String text(String key) {
    return _localisedValues[key];
  }

}