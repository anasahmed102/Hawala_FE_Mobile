import 'package:hawala/shared/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';


@Named.from(CameraPermissionService)
@LazySingleton()
class CameraPermissionService {
  Future<bool> askPermission() async {
    try {
      PermissionStatus isGranted = await Permission.camera.request();
      return isGranted.isGranted || isGranted.isLimited;
    } catch (e, c) {
      logger("error when ask permission for camera $e");
      return false;
    }
  }
}
