// ignore: import_of_legacy_library_into_null_safe
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:hawala/alerts/toast.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/service/permission/permission_service.dart';
import 'package:hawala/service/share_service.dart';
import 'package:hawala/shared/context_extension.dart';
import 'package:hawala/shared/logger.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';

Future<void> openFileAlert({required String path}) async {
  BuildContext context = getItClient<AppConfigurationService>().context;
  await AwesomeDialog(
      useRootNavigator: true,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: "Success",
      desc: "${"File Was Saved In"}\n $path",
      titleTextStyle: context.titleStyle,
      descTextStyle: context.subTitleStyle,
      btnCancelText: "Share",
      btnCancelIcon: Icons.share,
      btnCancelOnPress: () {
        getItClient<ShareService>().shareFile(file: XFile(path));
      },
      btnOkText: "Open",
      btnOkOnPress: () async {
        //PermissionHelper.instance.getStoreagePermission()
        if (await getItClient<PermissionService>().storagePermission() ==
            true) {
          final res = await OpenFile.open(path);
          if (res.type != ResultType.done) {
            showToast("${res.message} ${res.type}");
          }
          logger(res);
        }
      }).show();
}
