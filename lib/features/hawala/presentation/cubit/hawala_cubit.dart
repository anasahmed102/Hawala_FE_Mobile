// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/features/hawala/data/model/hawala.dart';
import 'package:hawala/features/hawala/domain/reposiroey/hawala_repository.dart';
import 'package:hawala/shared/enums.dart';
import 'package:hawala/shared/logger.dart';
import 'package:injectable/injectable.dart';

part 'hawala_state.dart';

@Named.from(HawalaCubit)
@LazySingleton()
class HawalaCubit extends Cubit<HawalaState> {
  HawalaCubit({
    required this.repository,
  }) : super(HawalaInitial());

  final HawalaRepository repository;

  Future<Either<Failure, List<HawalaModel>>> getData(
      {ShowMessageEnum showMessage = ShowMessageEnum.none,
      DataSource source = DataSource.local,
      required String startDate,
      required String endDate}) async {
    final result = await repository.getAll(
        params: {},
        showMessage: showMessage,
        dataSource: source,
        endDate: endDate,
        startDate: startDate);
    result.fold(
      (failure) => emit(ErrorCurrencyState(failure: failure)),
      (data) => emit(_mapPropsToState(data)),
    );
    logger(state);
    return result;
  }

  List<HawalaModel> get items {
    if (state is LoadedCurrencyState) {
      return (state as LoadedCurrencyState).data;
    }
    return <HawalaModel>[];
  }

  HawalaState _mapPropsToState(List<HawalaModel> entities) {
    return entities.isEmpty
        ? const EmptyCurrencyState()
        : LoadedCurrencyState(data: entities);
  }
}
