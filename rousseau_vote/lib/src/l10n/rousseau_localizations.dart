import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;

class _RousseauLocalizationsDelegate extends LocalizationsDelegate<RousseauLocalizations> {
  
  final Locale newLocale;
  const _RousseauLocalizationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return ["it"].contains(locale.languageCode);
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
  
  Locale locale;
  
  static Map<dynamic, dynamic> _localisedValues;

  static RousseauLocalizations of(BuildContext context) {
    return Localizations.of<RousseauLocalizations>(
        context, RousseauLocalizations);
  }

  static String getText(BuildContext context, String messageKey) {
    return RousseauLocalizations.of(context).text(messageKey);
  }

  static Future<RousseauLocalizations> load(Locale locale) async {
    RousseauLocalizations rousseauLocalizations = RousseauLocalizations(locale);
    String jsonContent = await rootBundle.loadString("l10n/${locale.languageCode}.json");
    _localisedValues = json.decode(jsonContent);
    return rousseauLocalizations;
  }

  static const LocalizationsDelegate<RousseauLocalizations> delegate = _RousseauLocalizationsDelegate();

  RousseauLocalizations(Locale locale) {
    this.locale = locale;
    _localisedValues = {};
  }

  get currentLanguage => locale.languageCode;

  String text(String key) {
    return _localisedValues[key] ?? "'$key' not found";
  }

}