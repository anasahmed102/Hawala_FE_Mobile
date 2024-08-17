// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import 'package:equatable/equatable.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/features/auth/data/model/login_request.dart';
import 'package:hawala/features/auth/domain/repositroy/repositroy.dart';
import 'package:hawala/model/user_model.dart';
import 'package:hawala/shared/enums.dart';
import 'package:injectable/injectable.dart';


part 'auth_state.dart';

@Named.from(AuthCubit)
@LazySingleton()
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit(
    this.authRepository,
  ) : super(AuthInitial());

  Future<Either<Failure, UserAppModel?>> login(
      {required LoginRequest loginRequest,
      required DataSource dataSource}) async {
    final result = await authRepository.login(
        loginRequest: LoginRequest(
            fname: loginRequest.fname, password: loginRequest.password),
        dataSource: dataSource);
    result.fold((error) => emit(ErrorAuthState(failure: error)),
        (success) => emit(_mapPropsToState(success)));
    return result;
  }

  UserAppModel? get info {
    if (state is LoadedAuthState) {
      return (state as LoadedAuthState).data;
    }
    return null;
  }

  AuthState _mapPropsToState(UserAppModel? entities) {
    return entities == null
        ? const EmptyAuthState()
        : LoadedAuthState(data: entities);
  }
}
