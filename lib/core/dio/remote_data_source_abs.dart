import 'package:dartz/dartz.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/shared/enums.dart';

import 'package:injectable/injectable.dart';


abstract class RemoteDataSourceAbs {
  Future<Either<Failure, bool>> delete(
      {required String endPoint,
      String? name,
      Map<String, String> params = const {},
      ShowMessageEnum showMessage,
      String? errorMsg,
      String? successMsg});
  Future<Either<Failure, T?>> create<T>({
    required String endPoint,
    ShowLoading showLoading,
    int popupTimes,
    bool logoutOn401,
    Map<String, String> params = const {},
    required Map<String, dynamic> data,
    String? errorMsg,
    ParseBody parseBody,
    String? name,
    bool throwError,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    String? successMsg,
    ShowMessageEnum showMessage,
  });
  Future<Either<Failure, List<T>>> getData<T>({
    required String endPoint,
    required ParseBody parseBody,
    String? name,
    bool throwError,
    ShowMessageEnum showMessage,
    Map<String, dynamic> params = const {},
    String? errorMsg,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    String? successMsg,
  });
  Future<Either<Failure, T?>> getOne<T>({
    required String endPoint,
    ParseBody parseBody = ParseBody.direct,
    ShowMessageEnum showMessage,
    bool throwError,
    ShowLoading showLoading = ShowLoading.none,
    Map<String, String> params = const {},
    String? name,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    String? errorMsg,
    String? successMsg,
  });
  Future<Either<Failure, T?>> update<T>({
    required String endPoint,
    Map<String, String> params = const {},
    ShowMessageEnum showMessage,
    bool throwError,
    String? name,
    ShowLoading showLoading,
    int popupTimes,
    required T Function(Map<String, dynamic> json) fromJsonModel,
    required Map<String, dynamic> body,
    String? errorMsg,
    String? successMsg,
  });
}
