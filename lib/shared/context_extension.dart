import 'package:flutter/material.dart';
import 'package:hawala/shared/responsive.dart';

extension ContextExtension on BuildContext {
  Color get primaryColor => const Color(0xFF5fbb97);
  Color get darkThemeColors => const Color(0xFF1c1b1f);
  Color get homeCardColor => const Color.fromARGB(255, 255, 255, 255);
  //Theme.of(this).primaryColor
  Color get iconColor => Colors.black; //Theme.of(this).iconTheme.color!
  Color get canvacColor => Theme.of(this).canvasColor;
  Color get cardColor =>
      Theme.of(this).cardTheme.color ?? Theme.of(this).canvasColor;
  Color get borderColor =>
      Theme.of(this).inputDecorationTheme.enabledBorder?.borderSide.color ??
      Colors.black87; //AppColor.goldColor
  Color get unSelectedColor => Theme.of(this).unselectedWidgetColor;
  // ignore: deprecated_member_use
  Color get selectedColor => Theme.of(this).cardColor;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color? get buttonColor =>
      Theme.of(this).elevatedButtonTheme.style?.backgroundColor?.resolve({});
  Color? get buttonTextColor =>
      Theme.of(this).elevatedButtonTheme.style?.textStyle?.resolve({})?.color;

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get longestSide => MediaQuery.of(this).size.longestSide;
  double get shortestSide => MediaQuery.of(this).size.shortestSide;
  Color get iconBtnColor => primaryColor;
  TextStyle get titleStyle {
    return (Theme.of(this).textTheme.bodyLarge ??
            const TextStyle(color: Colors.black))
        .copyWith(fontSize: 18.sp);
  }

  back() {
    if (Navigator.of(this).canPop()) {
      Navigator.maybePop(this);
    }
  }

  TextStyle get headLine1 =>
      (Theme.of(this).textTheme.displayLarge ?? const TextStyle())
          .copyWith(fontSize: 20.sp);
  TextStyle get subTitleStyle =>
      (Theme.of(this).textTheme.bodyMedium ?? const TextStyle())
          .copyWith(fontSize: 16.sp);
  to(Widget widget) {
    Navigator.push(this, MaterialPageRoute(builder: (_) => widget));
  }

  bool get isLandScane =>
      MediaQuery.of(this).orientation == Orientation.landscape;
  Size get size => MediaQuery.of(this).size;
}
