import 'package:equatable/equatable.dart';
import 'package:hawala/core/error/failures.dart';

abstract class GenericsState extends Equatable {
  const GenericsState();
  @override
  List<Object> get props => [];
}

class GenericsInitial extends GenericsState {
  @override
  List<Object> get props => [];
}

class LoadingGenericsState extends GenericsState {
  @override
  List<Object> get props => [];
}

class LoadedGenericsState<T> extends GenericsState {
  final List<T> data;

  const LoadedGenericsState({required this.data});

  @override
  List<Object> get props => [data];
}

class ErrorGenericsState extends GenericsState {
  final Failure failure;
  const ErrorGenericsState({required this.failure});
  @override
  List<Object> get props => [failure];
}
