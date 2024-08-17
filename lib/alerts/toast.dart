import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hawala/shared/responsive.dart';

bool _isOpen = false;
showToast(String title, {Color? backgroundColor}) async {
  if (_isOpen == true) {
    await Fluttertoast.cancel();
    _isOpen = false;
  }
  _isOpen = true;

  await Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      // backgroundColor: backgroundColor ?? AppColor.mainColorDark,
      textColor: Colors.white,
      fontSize: 16.sp);
}
