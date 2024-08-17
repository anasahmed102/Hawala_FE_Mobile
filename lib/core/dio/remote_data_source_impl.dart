import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hawala/alerts/failed_alert.dart';
import 'package:hawala/alerts/loading_alert.dart';
import 'package:hawala/alerts/login_status.dart';
import 'package:hawala/alerts/success_alert.dart';
import 'package:hawala/alerts/toast/failed_toast.dart';
import 'package:hawala/alerts/toast/success_toast.dart';
import 'package:hawala/core/dio/remote_data_source_abs.dart';
import 'package:hawala/core/error/error_checker.dart';
import 'package:hawala/core/error/failure_message_model.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/core/helper/error_string.dart';
import 'package:hawala/core/parser/remote_parser.dart';
import 'package:hawala/core/parser/server_error_parser.dart';
import 'package:hawala/localization/translate_keys.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/service/validator_service.dart';
import 'package:hawala/shared/enums.dart';
import 'package:hawala/shared/env.dart';
import 'package:hawala/shared/functions.dart';
import 'package:hawala/shared/logger.dart';
import 'package:injectable/injectable.dart';

import 'dio.dart';


@test
@Named.from(RemoteDataSourceImp)
@LazySingleton(as: RemoteDataSourceAbs)
class RemoteDataSourceImp implements RemoteDataSourceAbs {
  final String _appUrl = api;

  _popUpTimes(int popTimes) {
    for (var i = 0; i < popTimes; i++) {
      getItClient<AppConfigurationService>().pop();
      // Helper.i.pop();
    }
  }

  _showLoading(ShowLoading showLoading) {
    if (showLoading.isShow) {
      showLoadingProgressAlert();
    }
  }

  _closeLoading(ShowLoading showLoading) {
    logger("_closeLoading $showLoading");
    if (showLoading.isShow || showLoading.isNone) {
      getItClient<AppConfigurationService>().pop();
      // Helper.i.pop();
    }
  }

  @override
  Future<Either<Failure, T?>> create<T>({
    required String endPoint,
    String? name,
    bool logoutOn401 = true,
    ShowLoading showLoading = ShowLoading.none,
    int popupTimes = 0,
    parseBody = ParseBody.direct,
    bool throwError = false,
    Map<String, dynamic> params = const {},
    required Map<String, dynamic> data,
    String? errorMsg,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    String? successMsg,
    ShowMessageEnum showMessage = ShowMessageEnum.none,
  }) async {
    String errorCode = generateRandom();
    var stopWatch = Stopwatch()..start();
    try {
      logger("Data Dio: $data");
      logger("Data Dio jsonEncode: ${jsonEncode(data)}");
      _showLoading(showLoading);
      //DioInstance.i.instnace
      DioInstance dio = getItClient<DioInstance>();
      final response = await dio.instance
          .post(endPoint, queryParameters: params, data: jsonEncode(data))
          .timeout(dio.durationRequest);
      //kDebugMode
      //    ? DioInstance.i.durationRequest
      //    : DioInstance.i.durationRequest
      stopWatch.stop();

      _closeLoading(showLoading);

      if (ValidatorService.isSuccess(response.statusCode)) {
        _popUpTimes(popupTimes);
        await _showSuccessMessage(
            showMessage,
            getMessageResponse(
                message: successMsg,
                name: name,
                operationType: OperationType.SuccessAddOne));
        return Right(parseBodyOne(
            ResRemote<T>(
                parseBody: parseBody,
                body: response.data!,
                fromJsonModel: fromJsonModel), onError: (e) async {
          FailureMessage error = getMessageResponse(
              message: errorMsg,
              operationType: OperationType.FailedAddOne,
              name: name,
              reason: Trans.unKnownErrorPleaseRetryLater.trans());
          await _showErrorMessage(showMessage, error);
        }));
      } else if (response.statusCode == 401) {
        FailureMessage error = getMessageResponse(
            message: errorMsg,
            operationType: OperationType.FailedAddOne,
            name: name,
            reason: Trans.youAreNotAuthorizedReloginAndRetryAgain.trans());
        await loginStatusAlert(
            title: Trans.failed.trans(),
            desc: error.toString(),
            isAuth: logoutOn401);

        return Left(UnAuthFailure(error: error));
      } else {
        FailureMessage error = getMessageResponse(
            operationType: OperationType.FailedAddOne,
            message: errorMsg,
            name: name,
            reason: parseServerError(
                response.data!,
                Trans.unKnownErrorPleaseRetryLater.trans(),
                response.statusCode!));

        await _showErrorMessage(showMessage, error);

        return Left(ServerFailure(error: error));
      }
    } catch (e, c) {
      stopWatch.stop();
      _closeLoading(showLoading);

      // recordError(e, c);
      logger("Error $endPoint $e");
      if (checkIsNetError(e)) {
        FailureMessage error = getMessageResponse(
            message: errorMsg,
            operationType: OperationType.FailedAddOne,
            name: name,
            reason: Trans.internetConnectionError.trans());
        await _showErrorMessage(showMessage, error);

        return Left(NetworkFailure(error: error));
      } else {
        FailureMessage error = getMessageResponse(
            message: errorMsg,
            operationType: OperationType.FailedAddOne,
            name: name,
            reason: Trans.unKnownErrorPleaseRetryLater.trans());
        await _showErrorMessage(showMessage, error);

        return Left(ErrorFailure(error: error));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> delete(
      {required String endPoint,
      String? errorMsg,
      String? name,
      Map<String, dynamic> params = const {},
      ShowMessageEnum showMessage = ShowMessageEnum.none,
      String? successMsg}) async {
    String errorCode = generateRandom();
    var stopWatch = Stopwatch()..start();
    try {
      DioInstance dio = getItClient<DioInstance>();
      //DioInstance.i.instnace
      final response = await dio.instance
          .delete(
            endPoint,
            queryParameters: params,
          )
          .timeout(dio.durationRequest);

      stopWatch.stop();

      //kDebugMode
      //    ? DioInstance.i.durationRequest
      //    : DioInstance.i.durationRequest

      if (ValidatorService.isSuccess(response.statusCode)) {
        _showSuccessMessage(
            showMessage,
            getMessageResponse(
                message: successMsg,
                name: name,
                operationType: OperationType.SuccessDelete));
        return const Right(true);
      } else if (response.statusCode == 401) {
        FailureMessage error = getMessageResponse(
            message: errorMsg,
            operationType: OperationType.FailedDelete,
            name: name,
            reason: Trans.youAreNotAuthorizedReloginAndRetryAgain.trans());
        await loginStatusAlert(
            title: Trans.failed.trans(), desc: error.toString(), isAuth: true);

        return Left(UnAuthFailure(error: error));
      } else {
        FailureMessage error = getMessageResponse(
            operationType: OperationType.FailedDelete,
            message: errorMsg,
            name: name,
            reason: parseServerError(
                response.data!,
                Trans.unKnownErrorPleaseRetryLater.trans(),
                response.statusCode!));
        await _showErrorMessage(showMessage, error);

        return Left(ServerFailure(error: error));
      }
    } catch (e, c) {
      stopWatch.stop();
      // recordError(e, c);
      logger("Error $endPoint Delete $e");
      if (checkIsNetError(e)) {
        FailureMessage error = getMessageResponse(
            message: errorMsg,
            operationType: OperationType.FailedDelete,
            name: name,
            reason: Trans.internetConnectionError.trans());
        await _showErrorMessage(showMessage, error);

        return Left(NetworkFailure(error: error));
      } else {
        FailureMessage error = getMessageResponse(
            message: errorMsg,
            operationType: OperationType.FailedDelete,
            name: name,
            reason: Trans.unKnownErrorPleaseRetryLater.trans());
        await _showErrorMessage(showMessage, error);

        return Left(ErrorFailure(error: error));
      }
    }
  }

  @override
  Future<Either<Failure, List<T>>> getData<T>({
    required String endPoint,
    String? name,
    ParseBody parseBody = ParseBody.direct,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    Map<String, dynamic> params = const {},
    ShowMessageEnum showMessage = ShowMessageEnum.none,
    String? errorMsg,
    bool throwError = false,
    String? successMsg,
  }) async {
    String errorCode = generateRandom();
    var stopWatch = Stopwatch()..start();
    try {
      logger("$_appUrl $_appUrl$endPoint");
      DioInstance dio = getItClient<DioInstance>();
      //DioInstance.i.instnace
      final response = await dio.instance
          .get(
            endPoint,
            queryParameters: params,
          )
          .timeout(dio.durationRequest);

      stopWatch.stop();
      //kDebugMode
      //    ? DioInstance.i.durationRequest
      //    : DioInstance.i.durationRequest

      if (ValidatorService.isSuccess(response.statusCode)) {
        final List<T> res = await compute<ResRemote<T>, List<T>>(
            (ResRemote<T> resRemote) => parseBodyList(
                  resRemote,
                  onError: (e) async {
                    FailureMessage error = getMessageResponse(
                        message: errorMsg,
                        operationType: OperationType.FailedGetAll,
                        name: name,
                        reason: Trans.unKnownErrorPleaseRetryLater.trans());
                    await _showErrorMessage(showMessage, error);
                  },
                ),
            ResRemote<T>(
                parseBody: parseBody,
                body: response.data!,
                fromJsonModel: fromJsonModel));
        _showSuccessMessage(
            showMessage,
            getMessageResponse(
                length: res.length,
                message: successMsg,
                name: name,
                operationType: OperationType.SuccessGetAll));

        return Right(res);
      } else if (response.statusCode == 401) {
        FailureMessage error = getMessageResponse(
            message: errorMsg,
            operationType: OperationType.FailedGetAll,
            name: name,
            reason: Trans.youAreNotAuthorizedReloginAndRetryAgain.trans());

        await loginStatusAlert(
            title: Trans.failed.trans(), desc: error.toString(), isAuth: true);

        return Left(UnAuthFailure(error: error));
      } else {
        FailureMessage error = getMessageResponse(
            operationType: OperationType.FailedGetAll,
            message: errorMsg,
            name: name,
            reason: parseServerError(
                response.data!,
                Trans.unKnownErrorPleaseRetryLater.trans(),
                response.statusCode!));
        await _showErrorMessage(showMessage, error);

        return Left(ServerFailure(error: error));
      }
    } catch (e, c) {
      stopWatch.stop();
      // recordError(e, c);

      logger("Error $endPoint get $e");
      if (checkIsNetError(e)) {
        FailureMessage error = getMessageResponse(
            message: errorMsg,
            operationType: OperationType.FailedGetAll,
            name: name,
            reason: Trans.internetConnectionError.trans());
        await _showErrorMessage(showMessage, error);

        return Left(NetworkFailure(error: error));
      } else {
        FailureMessage error = getMessageResponse(
            message: errorMsg,
            operationType: OperationType.FailedGetAll,
            name: name,
            reason: Trans.unKnownErrorPleaseRetryLater.trans());
        await _showErrorMessage(showMessage, error);

        return Left(ErrorFailure(error: error));
      }
    }
  }

  @override
  Future<Either<Failure, T?>> getOne<T>({
    required String endPoint,
    String? name,
    ParseBody parseBody = ParseBody.direct,
    bool throwError = false,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    ShowMessageEnum showMessage = ShowMessageEnum.none,
    ShowLoading showLoading = ShowLoading.none,
    Map<String, dynamic> params = const {},
    String? errorMsg,
    String? successMsg,
  }) async {
    String errorCode = generateRandom();
    var stopWatch = Stopwatch()..start();
    try {
      _showLoading(showLoading);
      DioInstance dio = getItClient<DioInstance>();
      //DioInstance.i.instnace
      final response = await dio.instance
          .get(endPoint, queryParameters: params)
          .timeout(dio.durationRequest);

      stopWatch.stop();
      //kDebugMode
      //    ? DioInstance.i.durationRequest
      //    : DioInstance.i.durationRequest

      _closeLoading(showLoading);

      if (ValidatorService.isSuccess(response.statusCode)) {
        _showSuccessMessage(
            showMessage,
            getMessageResponse(
                message: successMsg,
                name: name,
                operationType: OperationType.SuccessGetOne));
        return Right(parseBodyOne(
            ResRemote<T>(
                parseBody: parseBody,
                body: response.data!,
                fromJsonModel: fromJsonModel), onError: (e) async {
          FailureMessage error = getMessageResponse(
              message: errorMsg,
              operationType: OperationType.FailedGetOne,
              name: name,
              reason: Trans.unKnownErrorPleaseRetryLater.trans());
          await _showErrorMessage(showMessage, error);
        }));
      } else if (response.statusCode == 401) {
        FailureMessage error = getMessageResponse(
            message: errorMsg,
            operationType: OperationType.FailedGetOne,
            name: name,
            reason: Trans.youAreNotAuthorizedReloginAndRetryAgain.trans());
        await loginStatusAlert(
            title: Trans.failed.trans(), desc: error.toString(), isAuth: true);

        return Left(UnAuthFailure(error: error));
      } else {
        FailureMessage error = getMessageResponse(
            operationType: OperationType.FailedGetOne,
            message: errorMsg,
            name: name,
            reason: parseServerError(
                response.data!,
                Trans.unKnownErrorPleaseRetryLater.trans(),
                response.statusCode!));
        await _showErrorMessage(showMessage, error);

        return Left(ServerFailure(error: error));
      }
    } catch (e, c) {
      stopWatch.stop();
      _closeLoading(showLoading);
      // recordError(e, c);
      logger("Error $endPoint getone $e");
      if (checkIsNetError(e)) {
        FailureMessage error = getMessageResponse(
            message: errorMsg,
            operationType: OperationType.FailedGetOne,
            name: name,
            reason: Trans.internetConnectionError.trans());
        await _showErrorMessage(showMessage, error);

        return Left(NetworkFailure(error: error));
      } else {
        FailureMessage error = getMessageResponse(
            message: errorMsg,
            operationType: OperationType.FailedGetOne,
            name: name,
            reason: Trans.unKnownErrorPleaseRetryLater.trans());
        await _showErrorMessage(showMessage, error);

        return Left(ErrorFailure(error: error));
      }
    }
  }

  @override
  Future<Either<Failure, T?>> update<T>({
    required String endPoint,
    String? name,
    required Map<String, dynamic> body,
    Map<String, String> params = const {},
    String? errorMsg,
    int popupTimes = 0,
    ShowLoading showLoading = ShowLoading.none,
    String? successMsg,
    bool throwError = false,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    ShowMessageEnum showMessage = ShowMessageEnum.none,
  }) async {
    String errorCode = generateRandom();
    var stopWatch = Stopwatch()..start();
    try {
      _showLoading(showLoading);
      logger("body $body");
      DioInstance dio = getItClient<DioInstance>();
      //DioInstance.i.instnace
      final response = await dio.instance
          .put(endPoint, queryParameters: params, data: jsonEncode(body))
          .timeout(dio.durationRequest);

      stopWatch.stop();

      //kDebugMode
      //    ? DioInstance.i.durationRequest
      //    : DioInstance.i.durationRequest

      _closeLoading(showLoading);

      if (ValidatorService.isSuccess(response.statusCode)) {
        _popUpTimes(popupTimes);
        _showSuccessMessage(
            showMessage,
            getMessageResponse(
                message: successMsg,
                name: name,
                operationType: OperationType.SuccessUpdate));
        return Right(parseBodyOne(
            ResRemote<T>(
                parseBody: ParseBody.direct,
                body: response.data!,
                fromJsonModel: fromJsonModel), onError: (e) async {
          FailureMessage error = getMessageResponse(
              message: errorMsg,
              operationType: OperationType.FailedUpdate,
              name: name,
              reason: Trans.unKnownErrorPleaseRetryLater.trans());
          await _showErrorMessage(showMessage, error);
        }));
      } else if (response.statusCode == 401) {
        FailureMessage error = getMessageResponse(
            message: errorMsg,
            operationType: OperationType.FailedUpdate,
            name: name,
            reason: Trans.internetConnectionError.trans());
        await loginStatusAlert(
            title: Trans.failed.trans(), desc: error.toString(), isAuth: true);
        return Left(UnAuthFailure(error: error));
      } else {
        FailureMessage error = getMessageResponse(
            operationType: OperationType.FailedUpdate,
            message: errorMsg,
            name: name,
            reason: parseServerError(
                response.data!,
                Trans.unKnownErrorPleaseRetryLater.trans(),
                response.statusCode!));
        await _showErrorMessage(showMessage, error);

        return Left(ServerFailure(error: error));
      }
    } catch (e, c) {
      stopWatch.stop();
      _closeLoading(showLoading);

      // recordError(e, c);
      logger("Error put $endPoint $e");

      if (checkIsNetError(e)) {
        FailureMessage error = getMessageResponse(
            message: errorMsg,
            operationType: OperationType.FailedUpdate,
            name: name,
            reason: Trans.internetConnectionError.trans());
        await _showErrorMessage(showMessage, error);

        return Left(NetworkFailure(error: error));
      } else {
        FailureMessage error = getMessageResponse(
            message: errorMsg,
            operationType: OperationType.FailedUpdate,
            name: name,
            reason: Trans.unKnownErrorPleaseRetryLater.trans());
        await _showErrorMessage(showMessage, error);

        return Left(ErrorFailure(error: error));
      }
    }
  }

  _showErrorMessage(ShowMessageEnum showMessageEnum, FailureMessage message) {
    if (showMessageEnum.failedAlert) {
      failedAlert(error: message.toString());
    } else if (showMessageEnum.failedToast) {
      showFailedFlashBar(message.toString());
    }
  }

  _showSuccessMessage(
      ShowMessageEnum showMessageEnum, FailureMessage message) async {
    if (showMessageEnum.successAlert) {
      await successAlert(message: message.toString());
    } else if (showMessageEnum.successToast) {
      showSuccessFlashBar(message.toString());
    }
  }
}
