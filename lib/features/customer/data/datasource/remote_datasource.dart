import 'package:dartz/dartz.dart';
import 'package:hawala/core/dio/remote_data_source_abs.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/features/customer/data/model/customers.dart';
import 'package:hawala/localization/translate_keys.dart';
import 'package:hawala/shared/enums.dart';
import 'package:injectable/injectable.dart';

@Named.from(CustomeraNetworkOperation)
@Injectable()
class CustomeraNetworkOperation {
  late RemoteDataSourceAbs networkOperation;
  final CustomersModel Function(Map<String, dynamic>) fromJsonModel =
      CustomersModel.fromMap;
  CustomeraNetworkOperation({required this.networkOperation});
  final String _endPoint = "/customer";
  final String _name = Trans.customer;
  final String _names = Trans.customer;
  Future<Either<Failure, CustomersModel?>> create(
      {required ShowMessageEnum showMessage,
      required CustomersModel customersModel}) {
    return networkOperation.create<CustomersModel>(
        endPoint: _endPoint,
        fromJsonModel: fromJsonModel,
        data: {"CustomerName": customersModel.customerName,"Phone":customersModel.phone},
        showMessage: showMessage,
        name: _name);
  }

  Future<Either<Failure, bool>> delete({required id}) {
    return networkOperation.delete(
      name: _name,
      endPoint: "$_endPoint/$id",
    );
  }

  Future<Either<Failure, List<CustomersModel>>> getData({
    required Map<String, dynamic> params,
    required ShowMessageEnum showMessage,
  }) async {
    return await networkOperation.getData<CustomersModel>(
      fromJsonModel: fromJsonModel,
      endPoint: _endPoint,
      parseBody: ParseBody.direct,
      params: params,
      name: _names,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, CustomersModel?>> getOne({
    required id,
    Map<String, String> params = const {},
    required ShowMessageEnum showMessage,
  }) async {
    return await networkOperation.getOne<CustomersModel>(
        fromJsonModel: fromJsonModel,
        showMessage: showMessage,
        endPoint: "$_endPoint/$id",
        params: params,
        name: _name);
  }

  Future<Either<Failure, CustomersModel?>> update(
      {required ShowMessageEnum showMessage,
      required id,
      required CustomersModel model}) {
    return networkOperation.update<CustomersModel>(
        fromJsonModel: fromJsonModel,
        showMessage: showMessage,
        endPoint: "$_endPoint/$id",
        body: model.toMap(),
        name: _name);
  }
}
