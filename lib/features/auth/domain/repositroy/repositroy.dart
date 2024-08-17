import 'package:dartz/dartz.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/features/auth/data/model/login_request.dart';
import 'package:hawala/model/user_model.dart';
import 'package:hawala/shared/enums.dart';


abstract class AuthRepository {
  Future<Either<Failure, UserAppModel?>> login(
      {required DataSource dataSource, required LoginRequest loginRequest});
}
