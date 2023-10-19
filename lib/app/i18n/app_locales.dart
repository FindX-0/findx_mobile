import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

abstract class AppLocales {
  static const Locale localeKa = Locale('ka', 'GE');

  static const Locale fallbackLocale = localeKa;

  static const List<Locale> supportedLocales = [localeKa];

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];
}
