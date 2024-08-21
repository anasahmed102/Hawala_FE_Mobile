import 'package:awesome_dialog/awesome_dialog.dart';


import 'package:flutter/material.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/context_extension.dart';


Future<bool> getUserConfirm(
    {String? content, bool onNullReturn = false, required String desc,required VoidCallback onPressed}) async {
  bool source = onNullReturn;
  BuildContext context = getItClient<AppConfigurationService>().context;
  await AwesomeDialog(
      useRootNavigator: true,
      context: context,
      title: "Warning",
      titleTextStyle: context.titleStyle,
      descTextStyle: context.subTitleStyle,
      buttonsTextStyle:
          TextStyle(fontSize: context.titleStyle.fontSize, color: Colors.white),
      desc: "${content ?? desc} ?",
      dialogType: DialogType.question,
      animType: AnimType.leftSlide,
      bodyHeaderDistance: 30,
      btnOkText: "Yes",
      btnCancelText: "Cancel",
      btnCancelOnPress: () {},
      btnOkOnPress: onPressed,
      autoDismiss: false,
      dismissOnBackKeyPress: true,
      onDismissCallback: (dismissType) {
        Navigator.of(context).pop();
        if (dismissType == DismissType.btnOk) {
          source = true;
        } else {
          source = false;
        }
      }).show();
  return source;
}
