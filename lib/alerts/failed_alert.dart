import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/context_extension.dart';
import 'package:hawala/shared/logger.dart';


Future<void> failedAlert(
    {required String error, String? title, Function()? onOkClicked}) async {
  title ??= "Warning";
  BuildContext context = getItClient<AppConfigurationService>().context;
  await AwesomeDialog(
          useRootNavigator: true,
          context: context,
          titleTextStyle: context.titleStyle,
          descTextStyle: context.subTitleStyle,
          buttonsTextStyle: TextStyle(
              fontSize: context.titleStyle.fontSize, color: Colors.white),
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: title,
          desc: error,
          btnCancelText: "Cancel",
          btnCancelOnPress: onOkClicked == null ? null : () {},
          btnOkText: "Ok",
          dismissOnBackKeyPress: true,
          btnOkOnPress: onOkClicked ??
              () {
                logger("failed alert clicked");
              })
      .show();
}
