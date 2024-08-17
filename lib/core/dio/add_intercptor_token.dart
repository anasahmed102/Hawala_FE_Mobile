import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/logger.dart';

import 'package:injectable/injectable.dart';

import 'package:package_info_plus/package_info_plus.dart';

@Injectable()
class AddTokenInterceptor extends Interceptor {
  String? version;
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    version ??= (await PackageInfo.fromPlatform()).version;
    options.headers.addAll({
      "Accept": "application/json",
      "Content-type": "application/json",
      "user-agent": Platform.isAndroid ? "Android" : "iOS",
      "Version": version,
      "Authorization":
          "Bearer ${getItClient<AppConfigurationService>().accessToken()}", //ProfileNotifier.instance.userInfo?.accessToken
    });

    logger("options dio: ${options.data}");
    handler.next(options);
  }
}
