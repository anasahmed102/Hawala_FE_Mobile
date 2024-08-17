
import 'package:hawala/service/permission/camera_permission_service.dart';
import 'package:hawala/service/permission/photo_permission_service.dart';
import 'package:injectable/injectable.dart';


import '../injection/injection.dart';


@Named.from(PermissionService)
@LazySingleton()
class PermissionService {
  // static final PermissionHelper _singleton = PermissionHelper._();
  // static PermissionHelper get instance => _singleton;
  // PermissionHelper._();

  // Future<bool> bluetoothPermission() =>
  //     getItClient<BluetoothPermissionService>().askPermission();

  Future<bool> storagePermission() =>
      getItClient<PhotoPermissionService>().askPermission();

  Future<bool> cameraPermission() =>
      getItClient<CameraPermissionService>().askPermission();

  // Future<bool> locationPermission() =>
  //     getItClient<LocationService>().askPermission();

  // Future<bool> locationBackgroundPermission() =>
  //     getItClient<LocationService>().askPermissionBackground();

  // Future<bool> nfcPermission() =>
  //     getItClient<NFCPermissionService>().askPermission();

  // Future<bool> openGPSPermission() => getItClient<LocationService>().openGPS();

  Future<void> openSettings() => openSettings();
}
