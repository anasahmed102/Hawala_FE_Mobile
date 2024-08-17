import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/context_extension.dart';


class PermissionAlert {
  static Future<void> permissionNotAllowedAlert(
      {required String error, String? title, Function()? onTap}) async {
    BuildContext context = getItClient<AppConfigurationService>().context;
    title ??= "Warning";
    await AwesomeDialog(
            useRootNavigator: true,
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.bottomSlide,
            title: title,
            desc: error,
            titleTextStyle: context.titleStyle,
            descTextStyle: context.subTitleStyle,
            btnCancelText: onTap == null ? null : "Ignore",
            btnCancelOnPress: onTap == null ? null : () {},
            btnOkText: "Allow",
            btnOkOnPress: onTap)
        .show();
  }

  static Future<bool> askPermissionAlert(
      {required String desc, String? title}) async {
    //Function()? onTap
    BuildContext context = getItClient<AppConfigurationService>().context;
    bool isAllowed = false;
    title ??= "Warning";
    await AwesomeDialog(
        useRootNavigator: true,
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.bottomSlide,
        title: title,
        desc: desc,
        titleTextStyle: context.titleStyle,
        descTextStyle: context.subTitleStyle,
        btnCancelText:
            "Ignore", //onTap == null ? null : Trans.ignore.trans()
        btnOkText: "Allow",
        btnCancelOnPress: () {
          isAllowed = false;
        },
        btnOkOnPress: () {
          isAllowed = true;
        }).show();

    return isAllowed;
  }
}
