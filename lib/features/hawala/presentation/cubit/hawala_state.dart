part of 'hawala_cubit.dart';

sealed class HawalaState extends Equatable {
  const HawalaState();

  @override
  List<Object> get props => [];
}

class HawalaInitial extends HawalaState {
  @override
  List<Object> get props => [];
}

class LoadingCurrencyState extends HawalaState {
  @override
  List<Object> get props => [];
}

class LoadedCurrencyState extends HawalaState {
  final List<HawalaModel> data;
  const LoadedCurrencyState({required this.data});
  @override
  List<Object> get props => [data];
}

class EmptyCurrencyState extends HawalaState {
  const EmptyCurrencyState();
  @override
  List<Object> get props => [];
}

class ErrorCurrencyState extends HawalaState {
  final Failure failure;
  const ErrorCurrencyState({required this.failure});
  @override
  List<Object> get props => [failure];
}
