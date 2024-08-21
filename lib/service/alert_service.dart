
import 'package:flutter/material.dart' show BuildContext, VoidCallback;
import 'package:hawala/alerts/failed_alert.dart';
import 'package:hawala/alerts/get_user_confirm.dart';
import 'package:hawala/alerts/login_status.dart';
import 'package:hawala/alerts/logout_dialog.dart';
import 'package:hawala/alerts/open_file_alert.dart';
import 'package:hawala/alerts/permsseion_alert.dart';
import 'package:hawala/alerts/success_alert.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:injectable/injectable.dart';



@Named.from(AlertService)
@LazySingleton()
class AlertService {
  /// Failed , Success , User Confirm
  static Future<void> failed(
          {required String error, String? title, Function()? onOkClicked}) =>
      failedAlert(error: error, onOkClicked: onOkClicked, title: title);

  static Future<bool> userConfirm(
          {required VoidCallback onPressed, String? content, bool onNullReturn = false}) =>
      getUserConfirm(
        onPressed: onPressed,
          content: content, onNullReturn: onNullReturn, desc: "alert_service");

  static Future<void> success({required String message}) =>
      successAlert(message: message);

  /// Loading , Pop
  static Future<void> showLoading(
          {BuildContext? contextParam, bool? isProgress}) =>
      getItClient<AppConfigurationService>().showLoading();

  static void pop({var value}) =>
      getItClient<AppConfigurationService>().pop(value: value);

  /// Login , Logout
  static Future<void> login(
          {String? title, required String desc, bool isAuth = false}) =>
      loginStatusAlert(desc: desc, isAuth: isAuth, title: title);

  static Future<void> logout() => logoutDialog();

  /// Open File
  static Future<void> openFile({required String path}) =>
      openFileAlert(path: path);

  /// Permission
  static Future<void> permissionNotAllowed(
          {required String error, String? title, Function()? onTap}) =>
      PermissionAlert.permissionNotAllowedAlert(
          error: error, onTap: onTap, title: title);

  static Future<bool> askPermissionDialog(
          {required String desc, String? title}) =>
      PermissionAlert.askPermissionAlert(desc: desc, title: title);
}
