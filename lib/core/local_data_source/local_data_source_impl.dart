import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hawala/alerts/loading_alert.dart';
import 'package:hawala/alerts/success_alert.dart';
import 'package:hawala/alerts/toast/failed_toast.dart';
import 'package:hawala/alerts/toast/success_toast.dart';
import 'package:hawala/core/error/failure_message_model.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/core/helper/database_filter.dart';
import 'package:hawala/core/helper/error_string.dart';
import 'package:hawala/core/local_data_source/local_data_source_abs.dart';
import 'package:hawala/core/local_data_source/local_database.dart';
import 'package:hawala/core/parser/local_parser.dart';
import 'package:hawala/localization/translate_keys.dart';
import 'package:hawala/service/app_configuration_service.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/shared/enums.dart';
import 'package:hawala/shared/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

import '../../alerts/failed_alert.dart';
import '../../service/validator_service.dart';


@dev
@test
@prod
@Named.from(LocalDataSourceImp)
@LazySingleton()
class LocalDataSourceImp implements ILocalDataSource {
  StoreRef getStore(DataBaseType type, String tableName) {
    if (type == DataBaseType.Strings) {
      return stringMapStoreFactory.store(tableName);
    } else {
      return intMapStoreFactory.store(tableName);
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
  Future<Either<Failure, T>> create<T>(
      {required Map<String, dynamic> data,
      required recordId,
      required DataBaseType type,
      String? name,
      showLoading = ShowLoading.none,
      String? errorMsg,
      required String tableName,
      required ShowMessageEnum showMessage,
      required T Function(Map<String, dynamic> json) fromJsonModel,
      String? successMsg}) async {
    try {
      _showLoading(showLoading);
      final store = getStore(type, tableName);
      await store.record(recordId).put(
          await getItClient<AppDataBase>().database,
          data); //AppDataBase.instance.database
      _closeLoading(showLoading);
      _showSuccessMessage(
          showMessage,
          getMessageResponse(
              message: successMsg,
              name: name,
              operationType: OperationType.SuccessAddOne));
      return Right(parseLocalOne<T>(
          ResLocalOne<T>(data: data, fromJsonModel: fromJsonModel)));
    } catch (e) {
      _closeLoading(showLoading);

      logger("tableName $tableName $e");
      FailureMessage error = getMessageResponse(
          message: errorMsg,
          operationType: OperationType.FailedAddOne,
          name: name,
          reason: Trans.unKnownErrorPleaseRetryLater.trans());
      _showErrorMessage(showMessage, error);
      return Left(ErrorFailure(error: error));
    }
  }

  @override
  Future<Either<Failure, bool>> delete(
      {String? errorMsg,
      required recordId,
      showLoading = ShowLoading.none,
      required String tableName,
      required DataBaseType type,
      String? name,
      required ShowMessageEnum showMessage,
      String? successMsg}) async {
    try {
      _showLoading(showLoading);

      final store = getStore(type, tableName);
      await store.record(recordId).delete(await getItClient<AppDataBase>()
          .database); //AppDataBase.instance.database
      _closeLoading(showLoading);
      _showSuccessMessage(
          showMessage,
          getMessageResponse(
              message: successMsg,
              name: name,
              operationType: OperationType.SuccessDelete));
      return const Right(true);
    } catch (e) {
      _closeLoading(showLoading);

      logger("tableName $tableName $e");
      FailureMessage error = getMessageResponse(
          message: errorMsg,
          operationType: OperationType.FailedDelete,
          name: name,
          reason: Trans.unKnownErrorPleaseRetryLater.trans());
      _showErrorMessage(showMessage, error);
      return Left(ErrorFailure(error: error));
    }
  }

  @override
  Future<Either<Failure, List<T>>> getData<T>(
      {required Map<String, dynamic> params,
      required ShowMessageEnum showMessage,
      String? successMsg,
      String? name,
      List<DataBaseFilter> filters = const [],
      required String tableName,
      required DataBaseType type,
      required T Function(Map<String, dynamic> json) fromJsonModel,
      String? errorMsg}) async {
    try {
      final store = getStore(type, tableName);
      var res = await store.find(await getItClient<AppDataBase>().database,
          finder: getFilterFinder(filters)); //AppDataBase.instance.database

      logger("$tableName total records found:  ${res.length} $res");
      _showSuccessMessage(
          showMessage,
          getMessageResponse(
              message: successMsg,
              name: name,
              operationType: OperationType.SuccessGetAll));
      return Right(parseLocalList(ResLocalList<T>(
          data: res.map((e) => e.value as Map<String, dynamic>).toList(),
          fromJsonModel: fromJsonModel)));
    } catch (e) {
      logger("tableName $tableName $e");

      FailureMessage error = getMessageResponse(
          message: errorMsg,
          operationType: OperationType.FailedGetAll,
          name: name,
          reason: Trans.unKnownErrorPleaseRetryLater.trans());
      _showErrorMessage(showMessage, error);
      return Left(ErrorFailure(error: error));
    }
  }

  @override
  Future<Either<Failure, T?>> getOne<T>(
      {required recordId,
      String? successMsg,
      String? name,
      required String tableName,
      showLoading = ShowLoading.none,
      required DataBaseType type,
      required T Function(Map<String, dynamic> json) fromJsonModel,
      required ShowMessageEnum showMessage,
      String? errorMsg}) async {
    try {
      _showLoading(showLoading);

      final store = getStore(type, tableName);
      final res = await store.record(recordId).get(
          await getItClient<AppDataBase>()
              .database); // AppDataBase.instance.database
      _closeLoading(showLoading);

      if (res == null) {
        _showSuccessMessage(
            showMessage,
            getMessageResponse(
                message: successMsg,
                name: name,
                operationType: OperationType.SuccessGetOne));
        return const Right(null);
      }

      return Right(parseLocalOne(ResLocalOne<T>(
          data: res as Map<String, dynamic>, fromJsonModel: fromJsonModel)));
    } catch (e) {
      _closeLoading(showLoading);

      logger("tableName $tableName $e");
      FailureMessage error = getMessageResponse(
          message: errorMsg,
          operationType: OperationType.FailedGetOne,
          name: name,
          reason: Trans.unKnownErrorPleaseRetryLater.trans());
      _showErrorMessage(showMessage, error);
      return Left(ErrorFailure(error: error));
    }
  }

  @override
  Future<Either<Failure, T?>> update<T>(
      {required recordId,
      required String tableName,
      required ShowMessageEnum showMessage,
      required Map<String, dynamic> body,
      String? errorMsg,
      showLoading = ShowLoading.none,
      required DataBaseType type,
      String? name,
      required T Function(Map<String, dynamic> json) fromJsonModel,
      String? successMsg}) async {
    try {
      _showLoading(showLoading);

      final store = getStore(type, tableName);
      final res = await store.record(recordId).put(
          await getItClient<AppDataBase>().database,
          body); //AppDataBase.instance.database
      _closeLoading(showLoading);

      _showSuccessMessage(
          showMessage,
          getMessageResponse(
              message: successMsg,
              name: name,
              operationType: OperationType.SuccessUpdate));
      return Right(parseLocalOne(ResLocalOne<T>(
          data: res as Map<String, dynamic>, fromJsonModel: fromJsonModel)));
    } catch (e) {
      _closeLoading(showLoading);

      logger("tableName $tableName $e");
      FailureMessage error = getMessageResponse(
          message: errorMsg,
          operationType: OperationType.FailedUpdate,
          name: name,
          reason: Trans.unKnownErrorPleaseRetryLater.trans());
      _showErrorMessage(showMessage, error);
      return Left(ErrorFailure(error: error));
    }
  }

  _showErrorMessage(ShowMessageEnum showMessageEnum, FailureMessage message) {
    if (ValidatorService.checkIsNullOrEmpty(message)) {
      throw Exception("Message is Null");
    }
    if (showMessageEnum.failedAlert) {
      failedAlert(error: "$message");
    } else if (showMessageEnum.failedToast) {
      showFailedFlashBar("$message");
    }
  }

  _showSuccessMessage(ShowMessageEnum showMessageEnum, FailureMessage message) {
    if (showMessageEnum.successAlert) {
      successAlert(message: message.toString());
    } else if (showMessageEnum.successToast) {
      // showSuccessFlashBar(message.toString());
    }
  }

  @override
  Future<Either<Failure, List<T>>> addAll<T>(
      {required bool deleteOldRecord,
      required List<T> listOfData,
      String? name,
      required String tableName,
      required dynamic Function(T data) getId,
      String? errorMsg,
      required DataBaseType type,
      showLoading = ShowLoading.none,
      required Map<String, dynamic> Function(T model) toJson,
      String? successMsg,
      ShowMessageEnum showMessage = ShowMessageEnum.none}) async {
    try {
      _showLoading(showLoading);

      StoreRef storeRef = getStore(type, tableName);
      if (deleteOldRecord) {
        final deletedItems = await storeRef.delete(
            await getItClient<AppDataBase>()
                .database); //AppDataBase.instance.database
        logger("deletedItems $deletedItems");
      }
      for (var element in listOfData) {
        await storeRef.record(getId(element)).put(
            await getItClient<AppDataBase>().database,
            toJson(element)); //AppDataBase.instance.database
      }
      _closeLoading(showLoading);

      _showSuccessMessage(
          showMessage,
          getMessageResponse(
              message: successMsg,
              name: name,
              operationType: OperationType.SuccessAddAll));
      return Right(listOfData);
    } catch (e) {
      _closeLoading(showLoading);

      logger("tableName $tableName $e");
      FailureMessage error = getMessageResponse(
          message: errorMsg,
          operationType: OperationType.FailedAddAll,
          name: name,
          reason: Trans.unKnownErrorPleaseRetryLater.trans());
      _showErrorMessage(showMessage, error);
      return Left(ErrorFailure(error: error));
    }
  }
}
