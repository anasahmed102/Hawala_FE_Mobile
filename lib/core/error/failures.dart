import 'package:equatable/equatable.dart';
import 'package:hawala/core/error/failure_message_model.dart';

abstract class Failure extends Equatable {
  const Failure({required this.error});
  final FailureMessage error;
}

class ServerFailure extends Failure {
  const ServerFailure({required super.error});
  @override
  List<Object?> get props => [error];
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.error});

  @override
  List<Object?> get props => [FailureMessage];
}

class UnAuthFailure extends Failure {
  const UnAuthFailure({required super.error});

  @override
  List<Object?> get props => [error];
}

class ErrorFailure extends Failure {
  const ErrorFailure({required super.error});

  @override
  List<Object?> get props => [error];
}

class EmptyData extends Failure {
  const EmptyData({required super.error});

  @override
  List<Object?> get props => [error];
}
class OfflineFailure extends Failure {
  const OfflineFailure({required super.error});

  @override
  List<Object?> get props => [error];
}
