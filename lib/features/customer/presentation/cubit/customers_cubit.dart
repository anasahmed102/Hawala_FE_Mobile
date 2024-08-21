// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/features/customer/data/model/customers.dart';
import 'package:hawala/features/customer/domain/repository/customers_repository.dart';
import 'package:hawala/shared/enums.dart';
import 'package:hawala/shared/logger.dart';
import 'package:injectable/injectable.dart';

part 'customers_state.dart';

@Named.from(CustomersCubit)
@LazySingleton()
class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit({
    required this.repository,
  }) : super(CustomersInitial());

  final CustomerRepository repository;

  Future<Either<Failure, List<CustomersModel>>> getData({
    ShowMessageEnum showMessage = ShowMessageEnum.none,
    DataSource source = DataSource.remote,
  }) async {
    final result = await repository
        .getAll(params: {}, showMessage: showMessage, dataSource: source);
    result.fold(
      (failure) => emit(ErrorCustomersState(failure: failure)),
      (data) {
        emit(_mapPropsToState(data));
      },
    );
    logger(state);
    return result;
  }

  List<CustomersModel> get items {
    if (state is LoadedCustomersState) {
      return (state as LoadedCustomersState).data;
    }
    return <CustomersModel>[];
  }

  CustomersState _mapPropsToState(List<CustomersModel> entities) {
    return entities.isEmpty
        ? const EmptyCustomersState()
        : LoadedCustomersState(data: entities);
  }
}
