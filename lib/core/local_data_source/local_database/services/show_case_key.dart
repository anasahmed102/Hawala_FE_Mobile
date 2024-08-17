import 'package:flutter/material.dart';
import 'package:hawala/core/local_data_source/local_database.dart';
import 'package:hawala/model/show_case_model.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/logger.dart';
import 'package:sembast/sembast.dart';


class ShowCaseKeys {
  ShowCaseKeys._();
  static final ShowCaseKeys _singleton = ShowCaseKeys._();
  static ShowCaseKeys get instance => _singleton;
  ShowCaseModel showCaseModel = ShowCaseModel(
      cartWidget: true,
      printSetting: true,
      paymentPerformance: true,
      sellesPerformance: true);
  final _store = stringMapStoreFactory.store("SHOW_CASE_STORE");

  init() async {
    Map<String, Object?>? data = await _store.record("SHOW_CASE_STORE").get(
        await getItClient<AppDataBase>()
            .database); //await AppDataBase.instance.database
    logger(";data $data");
    if (data != null) {
      showCaseModel = ShowCaseModel.fromMap(data);
    }
  }

  setShowTot(ShowCaseModel newShowCaseModel) async {
    showCaseModel = newShowCaseModel;
    await _store
        .record("SHOW_CASE_STORE") //AppDataBase.instance.database
        .put(await getItClient<AppDataBase>().database,
            newShowCaseModel.toMap());
  }

  GlobalKey cartWidgetKey = GlobalKey();
  GlobalKey pintSettingKey = GlobalKey();
  GlobalKey sellesPerformanceKey = GlobalKey();
  GlobalKey paymentPerformanceKey = GlobalKey();
}
