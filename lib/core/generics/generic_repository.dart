
import 'package:dartz/dartz.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/shared/enums.dart';

/// use for local data that is only viewed not editable
abstract class GenericRepository<T> {
  Future<Either<Failure, bool>> delete({required id});
  Future<Either<Failure, T?>> add({
    required ShowMessageEnum showMessage,
    DataSource dataSource = DataSource.checkNetwork,
    required T data,
  });
  Future<Either<Failure, List<T>>> getAll({
    Map<String, String> params = const {},
    required ShowMessageEnum showMessage,
    required DataSource dataSource,
  });
  Future<Either<Failure, T?>> getOne({
    required id,
    required ShowMessageEnum showMessage,
    required DataSource dataSource,
    Map<String, String> params = const {},
  });
  Future<Either<Failure, T?>> update({
    required id,
    required ShowMessageEnum showMessage,
    required DataSource source,
    required T model,
  });
}
