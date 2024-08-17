part of 'customers_cubit.dart';

sealed class CustomersState extends Equatable {
  const CustomersState();

  @override
  List<Object> get props => [];
}

class CustomersInitial extends CustomersState {
  @override
  List<Object> get props => [];
}

class LoadingCustomersState extends CustomersState {
  @override
  List<Object> get props => [];
}

class LoadedCustomersState extends CustomersState {
  final List<CustomersModel> data;
  const LoadedCustomersState({required this.data});
  @override
  List<Object> get props => [data];
}

class EmptyCustomersState extends CustomersState {
  const EmptyCustomersState();
  @override
  List<Object> get props => [];
}

class ErrorCustomersState extends CustomersState {
  final Failure failure;
  const ErrorCustomersState({required this.failure});
  @override
  List<Object> get props => [failure];
}
