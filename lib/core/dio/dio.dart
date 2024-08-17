import 'package:dio/dio.dart' as dio;
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/env.dart';

import 'package:injectable/injectable.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../shared/logger.dart';
import 'add_intercptor_token.dart';

@Named.from(DioInstance)
@LazySingleton()
class DioInstance {
  final Duration durationRequest = const Duration(milliseconds: 30000);

  dio.Dio get instance {
    return dio.Dio()
      ..options.baseUrl = apiUrl
      ..options.validateStatus = validateStatus
      ..options.responseType = dio.ResponseType.plain
      ..options.followRedirects = true
      ..options.connectTimeout = durationRequest
      ..options.receiveTimeout = durationRequest
      ..options.sendTimeout = durationRequest
      ..options.receiveDataWhenStatusError = true
      ..options.contentType = "application/json; charset=utf-8"
      ..interceptors.addAll([
        getItClient.get<AddTokenInterceptor>(),
        // AddTokenInterceptor(),
        // CustomeInterceptor(),
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          request: true,
          responseHeader: true,
          error: true,
          logPrint: logger,
          compact: true,
          maxWidth: 150,
        )
      ]);
  }

  bool validateStatus(int? v) {
    logger("validateStatus $v");
    return true;
  }
}
