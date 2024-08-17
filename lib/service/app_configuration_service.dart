
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hawala/alerts/loading_alert.dart';
import 'package:hawala/model/user_model.dart';
import 'package:hawala/service/secur_storage_service.dart';
import 'package:hawala/shared/logger.dart';
import 'package:injectable/injectable.dart';

@Named.from(AppConfigurationService)
@LazySingleton()
class AppConfigurationService with ChangeNotifier {
  AppConfigurationService(this.storage);
  // static final ThemeLangNotifier _singleton = ThemeLangNotifier._();
  // static ThemeLangNotifier get instance => _singleton;
  // ThemeLangNotifier._();

  final SecureStorageService storage;

  bool isTesting = false;
  bool workOnlyOnline = false;
  bool stopWorking = false;
  bool runOnlySecuredDevice = false;

  String appName = 'Temp';
  String language = "en";
  String theme = "light";
  String list = "list";
  String primaryColor = "red";
  UserAppModel? userInfo;
  // AccountInfo? accountInfo;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BuildContext get context => navigatorKey.currentContext!;

  void pop({var value}) {
    logger("Navigator.canPop(context)) ${Navigator.canPop(context)}");
    if (Navigator.canPop(context)) {
      Navigator.pop(context, value);
    }
  }

  bool get canPop => Navigator.canPop(context);
  showLoading() {
    showLoadingProgressAlert();
  }

  Future<void> init() async {
    language = await storage.getLang() ?? 'en';
    theme = await storage.getTheme() ?? 'light';
    list = await storage.getList() ?? 'list';
    primaryColor = await storage.getPrimaryColor() ?? 'red';
    userInfo = await storage.getUserData();
    // accountInfo = await storage.getAccountInfo();

    // viewOrder = prefs.viewOrder;
    // isDark = prefs.isDarkMode;
    // themeMode = isDark == true ? ThemeMode.dark : ThemeMode.light;
  }

  /// Check is Dark Theme
  bool isDark() => theme == 'dark';

  /// Theme mode for app
  ThemeMode themeMode() => isDark() ? ThemeMode.dark : ThemeMode.light;

  /// General theme for app
  // ThemeData appTheme() =>
  //     isDark() ? ThemeApp.darkTheme() : ThemeApp.lightTheme();

  /// Check is List type
  bool isList() => list == 'list';

  /// Check is Arabic
  bool isArabic() => language == 'ar';

  /// Check is Arabic
  bool isKurdish() => language == 'ku';

  /// Check is Turkish
  bool isTurkish() => language == 'tr';

  /// Check is English
  bool isEnglish() => language == 'en';

  /// Date Format Local
  dateFormatLocal() {
    if (isArabic()) {
      return 'ar';
    } else if (isKurdish()) {
      return 'ku';
    } else if (isTurkish()) {
      return 'tr';
    } else {
      return 'en';
    }
  }

  /// check right or left text
  bool isRightLanguage() {
    return isArabic() || isKurdish();
  }

  /// Rotating angel according to country code
  int rotateBackButton() {
    if (isEnglish() || isTurkish()) {
      return 0;
    }
    return 2;
  }

  // String getCurrentFont() {
  //   if (isArabic()) {
  //     return FontFamily.tunisia;
  //   } else if (isKurdish()) {
  //     return FontFamily.uniSIRWAN;
  //   } else if (isEnglish()) {
  //     return FontFamily.tajawal;
  //   } else if (isTurkish()) {
  //     return FontFamily.utendo;
  //   } else {
  //     return FontFamily.tajawal;
  //   }
  // }

  /// Get current color
  Color getCurrentColor() {
    if (primaryColor == appColors[0]) {
      return isDark() ? Colors.amber.shade400 : Colors.amber;
    } else if (primaryColor == appColors[1]) {
      return isDark() ? Colors.blue.shade300 : Colors.blue;
    } else if (primaryColor == appColors[2]) {
      return isDark() ? Colors.brown.shade400 : Colors.brown;
    } else if (primaryColor == appColors[3]) {
      return isDark() ? Colors.cyan.shade200 : Colors.cyan;
    } else if (primaryColor == appColors[4]) {
      return isDark() ? Colors.deepOrange.shade300 : Colors.deepOrange;
    } else if (primaryColor == appColors[5]) {
      return isDark() ? Colors.deepPurple.shade300 : Colors.deepPurple;
    } else if (primaryColor == appColors[6]) {
      return isDark() ? Colors.green.shade300 : Colors.green;
    } else if (primaryColor == appColors[7]) {
      return isDark() ? Colors.indigo.shade400 : Colors.indigo;
    } else if (primaryColor == appColors[8]) {
      return isDark() ? Colors.lime.shade400 : Colors.lime;
    } else if (primaryColor == appColors[9]) {
      return isDark() ? Colors.orange.shade300 : Colors.orange;
    } else if (primaryColor == appColors[10]) {
      return isDark() ? Colors.pink.shade300 : Colors.pink;
    } else if (primaryColor == appColors[11]) {
      return isDark() ? Colors.purple.shade300 : Colors.purple;
    } else if (primaryColor == appColors[12]) {
      return isDark() ? Colors.red.shade300 : Colors.red;
    } else if (primaryColor == appColors[13]) {
      return isDark() ? Colors.yellow.shade400 : Colors.yellow;
    } else {
      return isDark() ? Colors.green.shade300 : Colors.green;
    }
  }

  // List<SettingsColor> colors = [
  //   SettingsColor(color: Colors.amber, name: 'amber'),
  //   SettingsColor(color: Colors.blue, name: 'blue'),
  //   SettingsColor(color: Colors.brown, name: 'brown'),
  //   SettingsColor(color: Colors.cyan, name: 'cyan'),
  //   SettingsColor(color: Colors.deepOrange, name: 'deepOrange'),
  //   SettingsColor(color: Colors.deepPurple, name: 'deepPurple'),
  //   SettingsColor(color: Colors.green, name: 'green'),
  //   SettingsColor(color: Colors.indigo, name: 'indigo'),
  //   SettingsColor(color: Colors.lime, name: 'lime'),
  //   SettingsColor(color: Colors.orange, name: 'orange'),
  //   SettingsColor(color: Colors.pink, name: 'pink'),
  //   SettingsColor(color: Colors.purple, name: 'purple'),
  //   SettingsColor(color: Colors.red, name: 'red'),
  //   SettingsColor(color: Colors.yellow, name: 'yellow'),
  // ];

  /// List of Colors
  List<String> appColors = [
    'amber',
    'blue',
    'brown',
    'cyan',
    'deepOrange',
    'deepPurple',
    'green',
    'indigo',
    'lime',
    'orange',
    'pink',
    'purple',
    'red',
    'yellow'
  ];

  String accessToken() {
    try {
      return userInfo?.token ?? '';
    } catch (e) {
      return 'string';
    }
  }

  changeLang(String newLang) {
    language = newLang;
    storage.setLang(newLang);
    notifyListeners();
  }

  changeTheme(String newTheme) async {
    theme = newTheme;
    storage.setTheme(newTheme);
    notifyListeners();
  }

  changeList(String newList) async {
    list = newList;
    storage.setList(newList);
    notifyListeners();
  }

  changePrimaryColor(String newPrimaryColor) async {
    primaryColor = newPrimaryColor;
    storage.setPrimaryColor(newPrimaryColor);
    notifyListeners();
  }

  // toggleIsOrder(bool value) {
  //   viewOrder = value;
  //   prefs.setViewOrder(viewOrder);

  //   notifyListeners();
  // }

  // toggleIsLIst(bool value) {
  //   isList = value;
  //   notifyListeners();
  // }

  // ThemeMode themeMode = ThemeMode.dark;
}
