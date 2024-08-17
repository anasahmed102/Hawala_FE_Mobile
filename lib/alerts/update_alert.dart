import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:hawala/service/alert_service.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/service/luncher_service.dart';
import 'package:hawala/shared/context_extension.dart';
import 'package:hawala/shared/logger.dart';

Future<void> updateAlert(
    {required String url, required bool force, required String desc}) async {
  BuildContext context = getItClient<AppConfigurationService>().context;
  AwesomeDialog(
      useRootNavigator: true,
      autoDismiss: false,
      onDismissCallback: (type) {
        logger("type $type");
      },
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      context: context,
      titleTextStyle: context.titleStyle,
      descTextStyle: context.subTitleStyle,
      buttonsTextStyle: TextStyle(fontSize: context.titleStyle.fontSize),
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: "Warning",
      desc: "${"New update is avilable"}\n $desc",
      btnOkText: "Ok",
      btnOkOnPress: () async {
        AlertService.pop();
        await getItClient<LauncherService>().openUrl(url);
        if (force) {
          exit(0);
        }
      }).show();
}
