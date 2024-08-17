import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/service/profile_notifier_service.dart';
import 'package:hawala/shared/context_extension.dart';

Future<void> loginStatusAlert(
    {String? title, required String desc, bool isAuth = false}) async {
  BuildContext context = getItClient<AppConfigurationService>().context;
  AwesomeDialog(
          useRootNavigator: true,
          titleTextStyle: context.titleStyle,
          descTextStyle: context.subTitleStyle,
          buttonsTextStyle: TextStyle(
              fontSize: context.titleStyle.fontSize, color: Colors.white),
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          btnOkColor: context.primaryColor,
          title: title ?? "Failed",
          desc: desc,
          btnOkText: "Ok",
          btnOkOnPress: () {})
      .show()
      .whenComplete(() {
    if (isAuth == true) {
      getItClient<ProfileNotifier>().signOut(true);
    }
  });
}
