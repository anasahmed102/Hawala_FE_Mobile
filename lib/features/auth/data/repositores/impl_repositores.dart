// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:flutter/material.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/features/auth/data/datasource/local_datasource.dart';
import 'package:hawala/features/auth/data/datasource/remote_datasource.dart';
import 'package:hawala/features/auth/data/model/login_request.dart';
import 'package:hawala/features/auth/domain/repositroy/repositroy.dart';
import 'package:hawala/model/user_model.dart';
import 'package:hawala/service/injection/injection.dart';
import 'package:hawala/service/profile_notifier_service.dart';
import 'package:hawala/shared/enums.dart';
import 'package:hawala/splash_screen.dart';
import 'package:injectable/injectable.dart';

import '../../../../service/app_configuration_service.dart';


@Named.from(AuthRepositoryImpl)
@Injectable(as: AuthRepository)

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource networkOperation;
  final LocalAccountSrc localAccountSrc;
  AuthRepositoryImpl({
    required this.networkOperation,
    required this.localAccountSrc,
  });

  @override
  Future<Either<Failure, UserAppModel?>> login({
    required DataSource dataSource,
    required LoginRequest loginRequest,
    ShowMessageEnum showMessage = ShowMessageEnum.none,
  }) async {
    if (dataSource.isRemote) {
      final res = await networkOperation.login(
          showMessage: showMessage,
          loginRequest: LoginRequest(
            fname: loginRequest.fname,
            password: loginRequest.password,
          ));
      res.fold((l) => null, (r) {
        localAccountSrc.saveLoginModel(r!);
        getItClient<ProfileNotifier>().userInfo = r;
        Navigator.pushAndRemoveUntil(
            getItClient<AppConfigurationService>().context,
            MaterialPageRoute(builder: (_) => const SplashScreen()),
            (route) => false);
      });
      return res;
    } else {
      return localAccountSrc.getLoginModel();
    }
  }
}
