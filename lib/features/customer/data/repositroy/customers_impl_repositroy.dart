import 'package:dartz/dartz.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/core/helper/make_deciecion.dart';
import 'package:hawala/features/customer/data/datasource/local_datasource.dart';
import 'package:hawala/features/customer/data/datasource/remote_datasource.dart';
import 'package:hawala/features/customer/data/model/customers.dart';
import 'package:hawala/features/customer/domain/repository/customers_repository.dart';

import 'package:hawala/service/connection_service.dart';
import 'package:hawala/shared/enums.dart';
import 'package:injectable/injectable.dart';

@Named.from(HawalaRepositoryImpl)
@Injectable(as: CustomerRepository)
class HawalaRepositoryImpl extends CustomerRepository {
  final CustomeraNetworkOperation networkOperation;
  final CustomersLocalOperation localDataSource;
  final ConnectionChecker networkInfo;
  HawalaRepositoryImpl(
      {required this.networkOperation,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, CustomersModel?>> add({
    required ShowMessageEnum showMessage,
    DataSource dataSource = DataSource.checkNetwork,
    required CustomersModel data,
  }) {
    return networkOperation.create(showMessage: showMessage, data: {});
  }

  @override
  Future<Either<Failure, bool>> delete({required id}) {
    return networkOperation.delete(id: id);
  }

  @override
  Future<Either<Failure, List<CustomersModel>>> getAll(
      {Map<String, dynamic> params = const {},
      ShowMessageEnum showMessage = ShowMessageEnum.none,
      required DataSource dataSource}) async {
    final source = await makeDecision(dataSource);
    if (source.isRemote) {
      final res = await networkOperation.getData(
          showMessage: showMessage, params: params);
      res.fold(
          (l) {},
          (r) => localDataSource.addAll(
              data: r, getId: (data) => data.id.toString()));
      return res;
    } else {
      return localDataSource.getData(showMessage: showMessage, params: params);
    }
  }

  @override
  Future<Either<Failure, CustomersModel?>> getOne({
    required id,
    required DataSource dataSource,
    ShowMessageEnum showMessage = ShowMessageEnum.none,
    Map<String, String> params = const {},
  }) async {
    final source = await makeDecision(dataSource);
    if (source.isRemote) {
      return networkOperation.getOne(
          showMessage: showMessage, id: id, params: params);
    } else {
      return localDataSource.getOne(showMessage: showMessage, recordId: id);
    }
  }

  @override
  Future<Either<Failure, CustomersModel?>> update(
      {required id,
      required DataSource source,
      ShowMessageEnum showMessage = ShowMessageEnum.none,
      required CustomersModel model}) {
    if (source.isRemote) {
      return networkOperation.update(
          showMessage: showMessage, id: id, model: model);
    } else {
      return localDataSource.update(
          showMessage: showMessage, recordId: id, model: model);
    }
  }
}
