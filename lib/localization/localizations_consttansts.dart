
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hawala/localization/app_local.dart';
import 'package:hawala/localization/kurdish_cupertino_local.dart';
import 'package:hawala/localization/kurdish_local.dart';


Locale getLocale(String? lang) {
  if (lang == "en") {
    return const Locale('en', 'US');
  } else if (lang == "ar") {
    return const Locale('ar');
  } else if (lang == "tr") {
    return const Locale('tr');
  } else if (lang == "ku") {
    return const Locale('ku');
  } else {
    return const Locale('en');
  }
}

const List<Locale> supportedLocales = [
  Locale('en', "US"),
  Locale('ar'),
  Locale('ku'),
  Locale('tr'),
];

const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
  AppLocalizations.delegate,
  CkbWidgetLocalizations.delegate,
  CkbMaterialLocalizations.delegate,
  KurdishCupertinoLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  DefaultCupertinoLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];
