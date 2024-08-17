
import 'package:flutter/material.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/context_extension.dart';
import 'package:hawala/theme/app_colors.dart';

// ignore: library_prefixes

/// Menage and using all supported themes in business light app
class ThemeApp {
  static Color darkcolor = const Color(0xff1c1b1f);
  static Color textField1 = const Color(0xFFF7F8F8);
  static Color iconColor1 = const Color(0xFF7B6F72);
  static Color lineColor1 = const Color(0xFF1D1617);
  static Color facebookIconColor = const Color(0xFF1877F2);
  static Color pieChartColor1 = const Color(0xFFce91e9);
  static Color cardColor1 = const Color(0xFF92A3FD);
  static Color cardColor2 = const Color(0xFFeaf0ff);
  static Color sliderColor1 = const Color(0xFFbaadfa);
  static Color sliderColor2 = const Color(0xFFb4c0fe);
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);

  /// Using light theme to the app
  static ThemeData lightTheme(BuildContext context) {
    // Color color = DataHelper.getCurrentColor();
    Color color = context.primaryColor;

    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return ThemeData(
        useMaterial3: false,
        brightness: Brightness.light,
        primarySwatch: MaterialColor(color.value, shades),
        primaryColor: color,
        primaryColorLight: color,
        primaryColorDark: color,
        scrollbarTheme: ScrollbarThemeData(
          // thumbVisibility: false,
          thickness: MaterialStateProperty.all(12),
          interactive: true,
          thumbColor: MaterialStateProperty.all(
              AppColor().primaryColorLight().withOpacity(0.3)),
          radius: const Radius.circular(10),
          minThumbLength: 100,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor().cardColorLight(),
        )
        // scaffoldBackgroundColor: AppColor().backgroundColorLight(),
        // backgroundColor: AppColor().cardColorLight(),
        // bottomAppBarColor: AppColor().cardColorLight(),
        // cardColor: AppColor().cardColorLight(),
        // dialogBackgroundColor: AppColor().cardColorLight(),
        // hintColor: AppColor().textBodyColorLight(),
        );
  }

  /// Using dark theme to the app
  static ThemeData darkTheme() {
    // Color color = DataHelper.getCurrentColor();
    Color color = getItClient<AppConfigurationService>().getCurrentColor();

    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return ThemeData(
        useMaterial3: false,
        brightness: Brightness.dark,
        primarySwatch: MaterialColor(color.value, shades),
        primaryColor: color,
        primaryColorLight: color,
        primaryColorDark: color,
        scrollbarTheme: ScrollbarThemeData(
          // thumbVisibility: false,
          interactive: true,
          thickness: MaterialStateProperty.all(12),
          thumbColor: MaterialStateProperty.all(
              AppColor().primaryColorDark().withOpacity(0.3)),
          radius: const Radius.circular(12),
          minThumbLength: 100,
        ),
        appBarTheme: AppBarTheme(backgroundColor: AppColor().cardColorDark())
        // backgroundColor: AppColor().cardColorDark(),
        // scaffoldBackgroundColor: AppColor().backgroundColorDark(),
        // bottomAppBarColor: AppColor().cardColorDark(),
        // cardColor: AppColor().cardColorDark(),
        // dialogBackgroundColor: AppColor().cardColorDark(),
        // indicatorColor: AppColor().primaryColorDark(),
        // hintColor: AppColor().textBodyColorDark(),
        );
  }
}
