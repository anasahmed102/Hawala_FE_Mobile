part of 'add_update_delete_customer_cubit.dart';

sealed class AddUpdateDeleteCustomerState extends Equatable {
  const AddUpdateDeleteCustomerState();

  @override
  List<Object> get props => [];
}

class AddUpdateDeleteCustomerInitial extends AddUpdateDeleteCustomerState {}

class LoadingAddDeleteUpadateCustomerState
    extends AddUpdateDeleteCustomerState {}

class ErrorAddDeleteUpadateCustomerState extends AddUpdateDeleteCustomerState {
  final String message;
  const ErrorAddDeleteUpadateCustomerState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpadateCustomerState
    extends AddUpdateDeleteCustomerState {
  final String message;
  const MessageAddDeleteUpadateCustomerState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
