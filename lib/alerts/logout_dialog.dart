import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:hawala/alerts/loading_alert.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/service/profile_notifier_service.dart';
import 'package:hawala/shared/context_extension.dart';


Future<void> logoutDialog() async {
  BuildContext context = getItClient<AppConfigurationService>().context;
  AwesomeDialog(
      useRootNavigator: true,
      titleTextStyle: context.titleStyle,
      descTextStyle: context.subTitleStyle,
      buttonsTextStyle: TextStyle(fontSize: context.titleStyle.fontSize),
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      desc: "Are You Sure you want to logout ?",
      btnCancelText: "No",
      btnCancelOnPress: () {},
      btnOkText: "Yes",
      btnOkOnPress: () {
        showLoadingProgressAlert();
        getItClient<ProfileNotifier>().signOut(true);
      }).show();
}
