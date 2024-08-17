import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/core/helper/database_filter.dart';
import 'package:hawala/core/local_data_source/local_data_source_impl.dart';
import 'package:hawala/core/local_data_source/local_database/database_class.dart';
import 'package:hawala/features/customer/data/model/customers.dart';
import 'package:hawala/features/hawala/data/model/hawala.dart';
import 'package:hawala/localization/translate_keys.dart';
import 'package:hawala/shared/enums.dart';
import 'package:injectable/injectable.dart';

@Named.from(CustomersLocalOperation)
@Injectable()
class CustomersLocalOperation {
  static String tableName = DataBaseTables.currencyTable;
  final LocalDataSourceImp localOperation;
  final String _name = Trans.currency;
  final String _names = Trans.currency;
  final CustomersModel Function(Map<String, dynamic>) fromJsonModel =
      CustomersModel.fromMap;
  CustomersLocalOperation({required this.localOperation});
  Future<Either<Failure, CustomersModel?>> create({
    required CustomersModel model,
    required recordId,
    required ShowMessageEnum showMessage,
  }) async {
    return localOperation.create<CustomersModel>(
      data: model.toMap(),
      recordId: model.id,
      name: _name,
      tableName: tableName,
      type: DataBaseType.Strings,
      fromJsonModel: fromJsonModel,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, bool>> delete({
    required recordId,
    required ShowMessageEnum showMessage,
  }) async {
    return localOperation.delete(
      name: _name,
      recordId: recordId,
      tableName: tableName,
      type: DataBaseType.Strings,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, List<CustomersModel>>> getData({
    required Map<String, dynamic> params,
    List<DataBaseFilter> filters = const [],
    ShowMessageEnum showMessage = ShowMessageEnum.none,
  }) async {
    return localOperation.getData<CustomersModel>(
      params: params,
      filters: filters,
      tableName: tableName,
      fromJsonModel: fromJsonModel,
      showMessage: showMessage,
      type: DataBaseType.Strings,
      name: _names,
    );
  }

  Future<Either<Failure, CustomersModel?>> getOne({
    required recordId,
    ShowMessageEnum showMessage = ShowMessageEnum.none,
  }) async {
    return localOperation.getOne<CustomersModel>(
        recordId: recordId,
        tableName: tableName,
        type: DataBaseType.Strings,
        fromJsonModel: fromJsonModel,
        showMessage: showMessage,
        name: _name);
  }

  Future<Either<Failure, CustomersModel?>> update({
    required recordId,
    required CustomersModel model,
    ShowMessageEnum showMessage = ShowMessageEnum.none,
  }) async {
    return localOperation.update<CustomersModel?>(
        recordId: model.id,
        showMessage: showMessage,
        tableName: tableName,
        fromJsonModel: fromJsonModel,
        body: model.toMap(),
        type: DataBaseType.Strings,
        name: _name);
  }

  Future<Either<Failure, List<CustomersModel>>> addAll({
    bool deleteOldRecord = true,
    required List<CustomersModel> data,
    ShowMessageEnum showMessage = ShowMessageEnum.none,
    required String Function(CustomersModel) getId,
  }) async {
    return localOperation.addAll<CustomersModel>(
        deleteOldRecord: deleteOldRecord,
        listOfData: data,
        tableName: tableName,
        type: DataBaseType.Strings,
        getId: getId,
        toJson: (model) {
          return model.toMap();
        },
        name: _names,
        showMessage: showMessage);
  }
}
