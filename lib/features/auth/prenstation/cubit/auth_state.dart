part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

 class AuthInitial extends AuthState {}


class LoadingAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadedAuthState extends AuthState {
  final UserAppModel data;
  const LoadedAuthState({required this.data});
  @override
  List<Object> get props => [data];
}

class EmptyAuthState extends AuthState {
  const EmptyAuthState();
  @override
  List<Object> get props => [];
}

class ErrorAuthState extends AuthState {
  final Failure failure;
  const ErrorAuthState({required this.failure});
  @override
  List<Object> get props => [failure];
}
