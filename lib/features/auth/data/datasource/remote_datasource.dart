import 'package:dartz/dartz.dart';
import 'package:hawala/core/dio/remote_data_source_abs.dart';
import 'package:hawala/core/error/failures.dart';
import 'package:hawala/features/auth/data/model/login_request.dart';
import 'package:hawala/localization/translate_keys.dart';
import 'package:hawala/model/user_model.dart';
import 'package:hawala/service/profile_notifier_service.dart';
import 'package:hawala/shared/enums.dart';

import 'package:injectable/injectable.dart';


import '../../../../service/injection/injection.dart';

@Named.from(AuthRemoteDataSource)
@Injectable()
class AuthRemoteDataSource {
  late RemoteDataSourceAbs networkOperation;

  AuthRemoteDataSource({required this.networkOperation});
  // final String _endPoint = "/Currency";
  // final CurrencyModel Function(Map<String, dynamic>) fromJsonModel =
  //     CurrencyModel.fromJson;
  // final String _name = Trans.currency;
  // final String _names = Trans.currency;

  Future<Either<Failure, UserAppModel?>> login({
    required LoginRequest loginRequest,
    required ShowMessageEnum showMessage,
  }) async {
    final res = await networkOperation.create<UserAppModel>(
      endPoint: "/login",
      fromJsonModel: UserAppModel.fromMap,
      errorMsg: Trans.operationFailedUnKnownError.trans(),
      data: {"fname": loginRequest.fname, "password": loginRequest.password},
      logoutOn401: false,
      showLoading: ShowLoading.show,
      showMessage: ShowMessageEnum.showFailedAlert,
    );
    res.fold((error) {}, (success) async {
      getItClient<ProfileNotifier>().updateUserModel(success!);
      // Navigator.pushAndRemoveUntil(
      //     getItClient<AppConfigurationService>().context, //Helper.i.context
      //     MaterialPageRoute(builder: (_) => const SplashScreen()),
      //     (route) => false);
    });

    return res;
  }
}
