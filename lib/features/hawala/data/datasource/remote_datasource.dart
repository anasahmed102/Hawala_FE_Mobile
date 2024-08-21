import 'package:dartz/dartz.dart';
import 'package:hawala/core/dio/remote_data_source_abs.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/features/hawala/data/model/hawala.dart';
import 'package:hawala/localization/translate_keys.dart';
import 'package:hawala/shared/enums.dart';
import 'package:injectable/injectable.dart';

@Named.from(HawalaNetworkOperation)
@Injectable()
class HawalaNetworkOperation {
  late RemoteDataSourceAbs networkOperation;
  final HawalaModel Function(Map<String, dynamic>) fromJsonModel =
      HawalaModel.fromMap;
  HawalaNetworkOperation({required this.networkOperation});
  final String _endPoint = "/hawala";
  final String _name = Trans.currency;
  final String _names = Trans.currency;
  Future<Either<Failure, HawalaModel?>> create({
    required Map<String, dynamic> data,
    required ShowMessageEnum showMessage,
  }) {
    return networkOperation.create<HawalaModel>(
        endPoint: _endPoint,
        fromJsonModel: fromJsonModel,
        data: data,
        showMessage: showMessage,
        name: _name);
  }

  Future<Either<Failure, bool>> delete({required id}) {
    return networkOperation.delete(
      name: _name,
      endPoint: "$_endPoint/$id",
    );
  }

  Future<Either<Failure, List<HawalaModel>>> getData(
      {required Map<String, dynamic> params,
      required ShowMessageEnum showMessage,
      required String startDate,
      required String endDate}) async {
    return await networkOperation.getData<HawalaModel>(
      fromJsonModel: fromJsonModel,
      endPoint: "$_endPoint?fromDate=$startDate&toDate=$endDate",
      parseBody: ParseBody.direct,
      params: params,
      name: _names,
      showMessage: showMessage,
    );
  }

  Future<Either<Failure, HawalaModel?>> getOne({
    required id,
    Map<String, String> params = const {},
    required ShowMessageEnum showMessage,
  }) async {
    return await networkOperation.getOne<HawalaModel>(
        fromJsonModel: fromJsonModel,
        showMessage: showMessage,
        endPoint: "$_endPoint/$id",
        params: params,
        name: _name);
  }

  Future<Either<Failure, HawalaModel?>> update(
      {required ShowMessageEnum showMessage,
      required id,
      required HawalaModel model}) {
    return networkOperation.update<HawalaModel>(
        fromJsonModel: fromJsonModel,
        showMessage: showMessage,
        endPoint: "$_endPoint/$id",
        body: model.toMap(),
        name: _name);
  }
}
