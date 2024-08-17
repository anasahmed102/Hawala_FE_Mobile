import 'dart:io';

import 'package:hawala/shared/logger.dart';
import 'package:injectable/injectable.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:device_info_plus/device_info_plus.dart';

@Named.from(PhotoPermissionService)
@LazySingleton()
class PhotoPermissionService {
  Future<bool> askPermission() async {
    try {
      PermissionStatus isGranted = PermissionStatus.denied;
      if (Platform.isAndroid) {
        final androidVersion =
            (await DeviceInfoPlugin().androidInfo).version.release;
        if (int.parse(androidVersion) >= 13) {
          isGranted = await Permission.photos.request();
        }
      }
      isGranted = await Permission.storage.request();
      return isGranted.isGranted || isGranted.isLimited;
    } catch (e, c) {
      logger("error when ask permission for photos $e");
      return false;
    }
  }
}
