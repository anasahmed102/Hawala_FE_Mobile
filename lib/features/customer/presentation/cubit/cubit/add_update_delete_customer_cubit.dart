// ignore_for_file: public_member_api_docs, sort_constructors_first, type_literal_in_constant_pattern
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/features/customer/data/model/customers.dart';
import 'package:hawala/features/customer/domain/repository/customers_repository.dart';
import 'package:hawala/shared/enums.dart';
import 'package:injectable/injectable.dart';

part 'add_update_delete_customer_state.dart';

@Named.from(AddUpdateDeleteCustomerCubit)
@LazySingleton()
class AddUpdateDeleteCustomerCubit extends Cubit<AddUpdateDeleteCustomerState> {
  AddUpdateDeleteCustomerCubit({required this.customerRepository})
      : super(AddUpdateDeleteCustomerInitial());

  final CustomerRepository customerRepository;

  Future<Either<Failure, bool>> deleteCustomer(int? customerId) async {
    emit(LoadingAddDeleteUpadateCustomerState());
    final failureOrDoneMessage =
        await customerRepository.delete(id: customerId);

    emit(_eitherDoneMessageOrErrorState(
        failureOrDoneMessage, "Fav Book Added Sucesfully"));
    return failureOrDoneMessage;
  }

  Future<Either<Failure, CustomersModel?>> addCustomer(
      CustomersModel customersModel) async {
    emit(LoadingAddDeleteUpadateCustomerState());
    final failureOrDoneMessage = await customerRepository.add(
        showMessage: ShowMessageEnum.showSuccessToast, data: customersModel);

    emit(_eitherDoneMessageOrErrorStatee(
        failureOrDoneMessage, "Fav Book Added Sucesfully"));
    return failureOrDoneMessage;
  }

  Future<Either<Failure, CustomersModel?>> editCustomer(
      CustomersModel customersModel) async {
    emit(LoadingAddDeleteUpadateCustomerState());
    final failureOrDoneMessage = await customerRepository.update(
        id: customersModel.id,
        source: DataSource.remote,
        model: customersModel,
        showMessage: ShowMessageEnum.showSuccessToast);

    emit(_eitherDoneMessageOrErrorStatee(
        failureOrDoneMessage, "Fav Book Added Sucesfully"));
    return failureOrDoneMessage;
  }

  Future<Either<Failure, CustomersModel?>> updateCustomer(
      CustomersModel customersModel) async {
    emit(LoadingAddDeleteUpadateCustomerState());
    final failureOrDoneMessage = await customerRepository.update(
        showMessage: ShowMessageEnum.showSuccessToast,
        id: customersModel.id,
        source: DataSource.remote,
        model: customersModel);

    emit(_eitherDoneMessageOrErrorStatee(
        failureOrDoneMessage, "Fav Book Added Sucesfully"));
    return failureOrDoneMessage;
  }

  AddUpdateDeleteCustomerState _eitherDoneMessageOrErrorState(
      Either<Failure, bool> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpadateCustomerState(
          message: _mapFailureTomessage(failure)),
      (_) => MessageAddDeleteUpadateCustomerState(message: message),
    );
  }

  AddUpdateDeleteCustomerState _eitherDoneMessageOrErrorStatee(
      Either<Failure, CustomersModel?> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpadateCustomerState(
          message: _mapFailureTomessage(failure)),
      (_) => MessageAddDeleteUpadateCustomerState(message: message),
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
