part of 'hawala_add_update_delete_cubit.dart';

sealed class HawalaAddUpdateDeleteState extends Equatable {
  const HawalaAddUpdateDeleteState();

  @override
  List<Object> get props => [];
}

class HawalaAddUpdateDeleteInitial extends HawalaAddUpdateDeleteState{}

class LoadingAddDeleteUpadateCustomerState
    extends HawalaAddUpdateDeleteState {}

class ErrorAddDeleteUpadateHawalaState extends HawalaAddUpdateDeleteState {
  final String message;
  const ErrorAddDeleteUpadateHawalaState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpadateHawalaState
    extends HawalaAddUpdateDeleteState {
  final String message;
  const MessageAddDeleteUpadateHawalaState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
