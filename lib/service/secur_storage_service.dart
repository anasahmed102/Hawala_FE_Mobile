import 'dart:convert';


import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hawala/model/user_model.dart';
import 'package:hawala/service/validator_service.dart';
import 'package:injectable/injectable.dart';


@Named.from(SecureStorageService)
@LazySingleton()
class SecureStorageService {
  final storage = const FlutterSecureStorage(
    aOptions:
        AndroidOptions(encryptedSharedPreferences: true, resetOnError: true),
  );
  // static final SecureStorageHelper _singleton = SecureStorageHelper._();
  // static SecureStorageHelper get instance => _singleton;
  // SecureStorageHelper._();
  // UserInfo? userInfo;
  // AccountInfo? accountInfo;
  // WorkerInfo? workerInfo;

  // String lang = "ku";
  bool isDarkMode = true;
  // bool viewOrder = true;
  // bool isList = true;
  // bool primaryTheme = true;

  final String languageKey = "LANG";
  final String themeKey = "THEME";
  final String listKey = "LIST";
  final String primaryColorKey = "PRIMARY_COLOR";
  final userDataKey = "USER_DATA";
  final accountDataKey = "ACCOUNT_DATA";
  final firstTimeKey = "first_time";
  Future<void> initData() async {
    try {
      await getLang();
      await getList();
      await getTheme();
      await getPrimaryColor();
      await getUserData();
      await getMode();
      // await getViewOrder();
      // logger('get data from storage successfully');
    } catch (e) {
      // logger(e);
    }
  }

  //! E.g: ku , tr , en , ar
  Future<void> setLang(String language) async {
    await storage.write(key: languageKey, value: language);
  }

  Future<String?> getLang() async {
    return storage.read(key: languageKey);
  }

  //! E.g: dark , light
  Future<void> setTheme(String theme) async {
    await storage.write(key: themeKey, value: theme);
  }

  Future<String?> getTheme() async {
    return storage.read(key: themeKey);
  }

  //! E.g: list , grid
  Future<void> setList(String list) async {
    await storage.write(key: listKey, value: list);
  }

  Future<String?> getList() async {
    return storage.read(key: listKey);
  }

  //! E.g: yellow , red , blue........
  Future<void> setPrimaryColor(String primaryColor) async {
    await storage.write(key: primaryColorKey, value: primaryColor);
  }

  Future<String?> getPrimaryColor() async {
    return storage.read(key: primaryColorKey);
  }

  setMode(var newValue) async {
    isDarkMode = newValue;
    await storage.write(key: "isDark", value: isDarkMode.toString());
  }

  // setViewOrder(var newValue) async {
  //   viewOrder = newValue;
  //   await storage.write(key: "viewOrder", value: viewOrder.toString());
  // }

  getMode() async {
    final val = (await storage.read(key: "isDark"));

    isDarkMode = ValidatorService.checkBool(val);
  }

  // getViewOrder() async {
  //   viewOrder =
  //       ValidatorService.checkBool(await storage.read(key: "viewOrder"));
  // }

  Future<void> saveUserData(UserAppModel model) async {
    // userInfo = model;
    await storage.write(key: userDataKey, value: json.encode(model.toJson()));
    // value: await getItClient<EncryptorService>()
    //     .encrypt(json.encode(model.toJson())));
  }

  Future<UserAppModel?> getUserData() async {
    var data = await storage.read(key: userDataKey);
    if (ValidatorService.checkIsNullOrEmpty(data)) {
      return null;
    }
    // logger("data1 $data");
    return UserAppModel.fromJson(json.decode(data!));
    // json.decode(await getItClient<EncryptorService>().decrypt(data!)));
  }

  // Future<void> saveAccountInfo(AccountInfo model) async {
  //   // userInfo = model;
  //   await storage.write(
  //       key: accountDataKey, value: json.encode(model.toJson()));
  //   // value: await getItClient<EncryptorService>()
  //   //     .encrypt(json.encode(model.toJson())));
  // }

  // Future<AccountInfo?> getAccountInfo() async {
  //   var data = await storage.read(key: accountDataKey);
  //   if (ValidatorService.checkIsNullOrEmpty(data)) {
  //     return null;
  //   }
  //   logger("data1 $data");
  //   AccountInfo? accountInfo = AccountInfo.fromJson(json.decode(data!));
  //   // json.decode(await getItClient<EncryptorService>().decrypt(data!)));
  //   return accountInfo;
  // }

  Future<bool> firstTimeRead() async {
    final bool firstTime = await storage.read(key: firstTimeKey) == null;
    return firstTime;
  }

  Future<void> writeToStorage() async {
    await storage.write(key: firstTimeKey, value: 'false');
  }

  Future<void> clearAll() async {
    await storage.deleteAll();
    // userInfo = null;
  }
}
