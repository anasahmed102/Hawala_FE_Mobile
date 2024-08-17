import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class AppModule {
  //! Inject Storage Service
  // @LazySingleton()
  // StorageService get storage => StorageService();

  //! Inject Dio Service
  // @LazySingleton()
  // DioInstance get remote => DioInstance();

  @LazySingleton()
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
}
