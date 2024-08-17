import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

@Named.from(AppDataBase)
@LazySingleton()
class AppDataBase {
  // static final AppDataBase _singleton = AppDataBase._();
  // static AppDataBase get instance => _singleton;
  Completer<Database>? _dbOpenCompleter;
  // AppDataBase._();
  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }
    return _dbOpenCompleter!.future;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'sembast.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);
    _dbOpenCompleter?.complete(database);
  }
}
