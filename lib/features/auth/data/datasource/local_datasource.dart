import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hawala/core/error/failure_message_model.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/localization/translate_keys.dart';
import 'package:hawala/service/validator_service.dart';
import 'package:hawala/shared/logger.dart';
import 'package:injectable/injectable.dart';

import '../../../../model/user_model.dart';


@Named.from(LocalAccountSrc)
@Injectable()
class LocalAccountSrc {
  final storage = const FlutterSecureStorage();
    Future<Either<Failure, UserAppModel>> getLoginModel() async {
    var data = await storage.read(key: _loginKey);
    logger("_loginKey $data");
    if (ValidatorService.checkIsNullOrEmpty(data)) {
      return Left(ErrorFailure(
          error: FailureMessage(
              reason: "",
              message: Trans.unKnownErrorPleaseRetryLater.trans(),
              elementLoaded: "")));
    }
    return Right(UserAppModel.fromJson(json.decode(data!)));
  }


  Future saveLoginModel(UserAppModel model) async {
    await storage.write(key: _loginKey, value: json.encode(model.toJson()));
  }

  final _loginKey = "LOGIN_KEY";
  final _detalisKey = "DETALIS_KEY";
  Future<void> clearAll() async {
    await storage.delete(key: _loginKey);
    await storage.delete(key: _detalisKey);
  }
}
