import 'package:get_it/get_it.dart';
import 'package:hawala/service/injection/injection.config.dart';
import 'package:injectable/injectable.dart';

@InjectableInit()
Future<void> configureInjection(String environment) async {
  getItClient.init(environment: environment);
}

//! Injection variable
GetIt getItClient = GetIt.instance;

//! Environments Types
enum Env { 
  test, 
 }

//! Environments Annotations (Like @dev), optional
// const dev = Environment('dev');
// const test = Environment('test');
// const prod = Environment('prod');
