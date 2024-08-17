import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hawala/service/injection/injection.dart';

class Apps {
  //? Local server
  // static AppConfig $dev = AppConfig(doc: "v1", url: dotenv.env['DEV'] ?? '');
  static AppConfig $test = AppConfig(doc: "v1", url: dotenv.env['TEST'] ?? '');
  // //? Live server
  // static AppConfig $prod = AppConfig(doc: "v1", url: dotenv.env['PROD'] ?? '');
}

class AppConfig {
  final String url, doc;
  AppConfig({required this.url, required this.doc});
}

//TODO change on release or dev
AppConfig _appConfig = Apps.$test;
String get versionDoc => _appConfig.doc;
String get api => _appConfig.url;
String apiUrl = "http://$api";
String wsUrl = '$apiUrl${dotenv.env['SOCKET'] ?? ''}'; //For example

String appVersion = '1.0.5+5';
Env envType = Env.test;
