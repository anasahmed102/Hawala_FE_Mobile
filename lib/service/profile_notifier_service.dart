
import 'package:flutter/material.dart';
import 'package:hawala/model/user_model.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/service/secur_storage_service.dart';
import 'package:hawala/splash_screen.dart';
import 'package:injectable/injectable.dart';


@Named.from(ProfileNotifier)
@LazySingleton()
class ProfileNotifier extends ChangeNotifier {
  // UserInfo? userInfo = SecureStorageHelper.instance.userInfo;
  // AccountInfo? accountInfo = SecureStorageHelper.instance.accountInfo;
  // WorkerInfo? workInfo = SecureStorageHelper.instance.workerInfo;
  // static final ProfileNotifier _singleton = ProfileNotifier._();
  // static ProfileNotifier get instance => _singleton;
  // ProfileNotifier._();
  // UserInfo? userInfo = SecureStorageHelper.instance.userInfo;
  UserAppModel? userInfo = getItClient<AppConfigurationService>().userInfo;

  updateUserModel(UserAppModel newAccountModel) {
    userInfo = newAccountModel;
    getItClient<AppConfigurationService>().userInfo = newAccountModel;
    getItClient<SecureStorageService>().saveUserData(newAccountModel);
    notifyListeners();
  }

  Future<void> signOut(bool val) async {
    //await SecureStorageHelper.instance.clearAll()
    await getItClient<SecureStorageService>().clearAll();
    // ProfileNotifier.instance.signOut();
    userInfo = null;
    notifyListeners();

    //Helper.i.context,
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        getItClient<AppConfigurationService>().context,
        MaterialPageRoute(builder: (_) => const SplashScreen()),
        (route) => false);
  }

  // Future<void> signOut(bool val) async {
  //   await SecureStorageHelper.instance.clearAll();
  //   notifyListeners();
  //   userInfo = null;
  //   workInfo = null;
  //   notifyListeners();
  //   // ignore: use_build_context_synchronously
  //   Navigator.pushAndRemoveUntil(
  //       Helper.i.context,
  //       MaterialPageRoute(builder: (_) => const SplashScreen()),
  //       (route) => false);
  // }
}
