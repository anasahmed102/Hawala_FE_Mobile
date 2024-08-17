import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/context_extension.dart';

Future<void> successAlert({required String message}) async {
  BuildContext context = getItClient<AppConfigurationService>().context;
  AwesomeDialog(
          useRootNavigator: true,
          context: context,
          titleTextStyle: context.titleStyle,
          descTextStyle: context.subTitleStyle,
          buttonsTextStyle: TextStyle(fontSize: context.titleStyle.fontSize),
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          title: "Success",
          desc: message,
          btnOkText: "Ok",
          btnOkOnPress: () {})
      .show();
}
