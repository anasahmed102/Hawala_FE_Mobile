import 'package:dartz/dartz.dart';

import 'package:hawala/core/error/failures.dart';
import 'package:hawala/core/helper/database_filter.dart';
import 'package:hawala/shared/enums.dart';

abstract class ILocalDataSource {
  Future<Either<Failure, bool>> delete({
    required recordId,
    required DataBaseType type,
    required String? name,
    required String tableName,
    required ShowLoading showLoading,
    required String? errorMsg,
    required ShowMessageEnum showMessage,
    required String? successMsg,
  });
  Future<Either<Failure, T?>> create<T>(
      {required Map<String, dynamic> data,
      required recordId,
      required String? errorMsg,
      required String tableName,
      required ShowLoading showLoading,
      required DataBaseType type,
      required String? name,
      required T Function(Map<String, dynamic> json) fromJsonModel,
      required String? successMsg,
      required ShowMessageEnum showMessage});
  Future<Either<Failure, List<T>>> addAll<T>(
      {required bool deleteOldRecord,
      required List<T> listOfData,
      required DataBaseType type,
      required ShowLoading showLoading,
      required Map<String, dynamic> Function(T model) toJson,
      required dynamic Function(T data) getId,
      required String? errorMsg,
      required String? successMsg,
      required String? name,
      required String tableName,
      required ShowMessageEnum showMessage});
  Future<Either<Failure, List<T>>> getData<T>({
    required Map<String, dynamic> params,
    required String? errorMsg,
    required DataBaseType type,
    required String tableName,
    required List<DataBaseFilter> filters,
    required String? name,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    required String? successMsg,
    required ShowMessageEnum showMessage,
  });
  Future<Either<Failure, T?>> getOne<T>({
    required recordId,
    required String? errorMsg,
    required String tableName,
    required ShowLoading showLoading,
    required DataBaseType type,
    required String? name,
    required String? successMsg,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    required ShowMessageEnum showMessage,
  });
  Future<Either<Failure, T?>> update<T>(
      {required recordId,
      required DataBaseType type,
      required String tableName,
      required String? name,
      required ShowLoading showLoading,
      required ShowMessageEnum showMessage,
      required T Function(Map<String, dynamic> json) fromJsonModel,
      required Map<String, dynamic> body,
      required String? errorMsg,
      required String? successMsg});
}
