// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/features/hawala/data/model/hawala.dart';

import 'package:hawala/features/hawala/domain/reposiroey/hawala_repository.dart';
import 'package:hawala/shared/enums.dart';
import 'package:injectable/injectable.dart';

part 'hawala_add_update_delete_state.dart';


@Named.from(HawalaAddUpdateDeleteCubit)
@LazySingleton()

class HawalaAddUpdateDeleteCubit extends Cubit<HawalaAddUpdateDeleteState> {
  HawalaAddUpdateDeleteCubit(
  { required this.hawalaRepository,
}) : super(HawalaAddUpdateDeleteInitial());
  final HawalaRepository hawalaRepository;

    Future<Either<Failure, HawalaModel?>> addCustomer(
      HawalaModel hawalaModel) async {
    emit(LoadingAddDeleteUpadateCustomerState());
    final failureOrDoneMessage = await hawalaRepository.add(
        showMessage: ShowMessageEnum.showSuccessToast, data: hawalaModel);

    emit(_eitherDoneMessageOrErrorStatee(
        failureOrDoneMessage, "Fav Book Added Sucesfully"));
    return failureOrDoneMessage;
  }
    Future<Either<Failure, bool>> deleteHawala(int? customerId) async {
    emit(LoadingAddDeleteUpadateCustomerState());
    final failureOrDoneMessage =
        await hawalaRepository.delete(id: customerId);

    emit(_eitherDoneMessageOrErrorState(
        failureOrDoneMessage, "Fav Book Added Sucesfully"));
    return failureOrDoneMessage;
  }

  HawalaAddUpdateDeleteState _eitherDoneMessageOrErrorState(
      Either<Failure, bool> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpadateHawalaState(
          message: _mapFailureTomessage(failure)),
      (_) => MessageAddDeleteUpadateHawalaState(message: message),
    );
  }

   HawalaAddUpdateDeleteState _eitherDoneMessageOrErrorStatee(
      Either<Failure, HawalaModel?> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpadateHawalaState(
          message: _mapFailureTomessage(failure)),
      (_) => MessageAddDeleteUpadateHawalaState(message: message),
    );
  }

  String _mapFailureTomessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "";

      case OfflineFailure:
        return "";

      case EmptyData:
        return "";
      default:
        return "unexpected error , please try again later";
    }
  }
}
