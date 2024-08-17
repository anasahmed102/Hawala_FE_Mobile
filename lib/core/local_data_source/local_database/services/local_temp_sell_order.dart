import 'package:hawala/core/local_data_source/local_database.dart';
import 'package:hawala/core/local_data_source/local_database/database_class.dart';
import 'package:hawala/service/data_formatting_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/logger.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';


//Save sell order in local db and retrive them if they saved in same day else delete theme
// this used to cache sell order to retrive them when user close app by mistake or app crahe
class LocalTempSellOrder {
  final String _astDateKey = "LastDateKey";

  final SharedPreferences preferences;
  final store = stringMapStoreFactory.store(DataBaseTables.localTemoSellOrder);

  LocalTempSellOrder({required this.preferences});
  Future puts(Map<String, List> data) async {
    try {
      preferences.setString(_astDateKey, DateTime.now().toIso8601String());
      await deleteAll();
      data.forEach((key, value) async {
        store
            .record(key) //AppDataBase.instance.database
            .put(await getItClient<AppDataBase>().database, {"value": value});
      });
    } catch (e) {
      logger("error in put temp local order $e");
    }
  }

  Future _getAll() async {
    try {
      //await AppDataBase.instance.database
      final res = await store.find(await getItClient<AppDataBase>().database);
      if (res.isNotEmpty) {
        Map<String, List> otherOrder = {};
        for (var element in res) {
          otherOrder[element.key] = element.value['value'] as List;
        }
        // CreateOrderNotifer.instance.setAllCustomerOrder(otherOrder);
      }
    } catch (e) {
      logger("error in put temp local order $e");
    }
  }

  Future deleteAll() async {
    try {
      //AppDataBase.instance.database
      await store.delete(await getItClient<AppDataBase>().database);
    } catch (e) {
      logger("error deleteAll local temp orders $e");
    }
  }

  getOldData() {
    final String? date = preferences.getString(_astDateKey);
    if (date != null) {
      DateTime lastDate = DateTime.parse(date);
      if (DateFormatterService.isToday(lastDate)) {
        _getAll();
      } else {
        deleteAll();
      }
    }
  }
}
