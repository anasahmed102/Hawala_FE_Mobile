// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hawala/core/dio/add_intercptor_token.dart' as _i3;
import 'package:hawala/core/dio/dio.dart' as _i6;
import 'package:hawala/core/dio/remote_data_source_abs.dart' as _i19;
import 'package:hawala/core/dio/remote_data_source_impl.dart' as _i20;
import 'package:hawala/core/local_data_source/local_data_source_impl.dart'
    as _i21;
import 'package:hawala/core/local_data_source/local_database.dart' as _i5;
import 'package:hawala/features/auth/data/datasource/local_datasource.dart'
    as _i4;
import 'package:hawala/features/auth/data/datasource/remote_datasource.dart'
    as _i22;
import 'package:hawala/features/auth/data/repositores/impl_repositores.dart'
    as _i35;
import 'package:hawala/features/auth/domain/repositroy/repositroy.dart' as _i34;
import 'package:hawala/features/auth/prenstation/cubit/auth_cubit.dart' as _i36;
import 'package:hawala/features/customer/data/datasource/local_datasource.dart'
    as _i26;
import 'package:hawala/features/customer/data/datasource/remote_datasource.dart'
    as _i24;
import 'package:hawala/features/customer/data/repositroy/customers_impl_repositroy.dart'
    as _i29;
import 'package:hawala/features/customer/domain/repository/customers_repository.dart'
    as _i28;
import 'package:hawala/features/customer/presentation/cubit/cubit/add_update_delete_customer_cubit.dart'
    as _i30;
import 'package:hawala/features/customer/presentation/cubit/customers_cubit.dart'
    as _i33;
import 'package:hawala/features/hawala/data/datasource/local_datasource.dart'
    as _i25;
import 'package:hawala/features/hawala/data/datasource/remote_datasource.dart'
    as _i23;
import 'package:hawala/features/hawala/data/repository/impl_repository.dart'
    as _i32;
import 'package:hawala/features/hawala/domain/reposiroey/hawala_repository.dart'
    as _i31;
import 'package:hawala/features/hawala/presentation/cubit/hawala_cubit.dart'
    as _i37;
import 'package:hawala/service/alert_service.dart' as _i13;
import 'package:hawala/service/app_configuration_service.dart' as _i27;
import 'package:hawala/service/connection_service.dart' as _i11;
import 'package:hawala/service/data_formatting_service.dart' as _i8;
import 'package:hawala/service/injection/app_moudle.dart' as _i38;
import 'package:hawala/service/luncher_service.dart' as _i7;
import 'package:hawala/service/permission/camera_permission_service.dart'
    as _i17;
import 'package:hawala/service/permission/permission_service.dart' as _i16;
import 'package:hawala/service/permission/photo_permission_service.dart'
    as _i18;
import 'package:hawala/service/profile_notifier_service.dart' as _i15;
import 'package:hawala/service/secur_storage_service.dart' as _i14;
import 'package:hawala/service/share_service.dart' as _i10;
import 'package:hawala/service/validator_service.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i12;

const String _test = 'test';
const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i3.AddTokenInterceptor>(() => _i3.AddTokenInterceptor());
    gh.factory<_i4.LocalAccountSrc>(() => _i4.LocalAccountSrc());
    gh.lazySingleton<_i5.AppDataBase>(() => _i5.AppDataBase());
    gh.lazySingleton<_i6.DioInstance>(() => _i6.DioInstance());
    gh.lazySingleton<_i7.LauncherService>(() => _i7.LauncherService());
    gh.lazySingleton<_i8.DateFormatterService>(
        () => _i8.DateFormatterService());
    gh.lazySingleton<_i9.ValidatorService>(() => _i9.ValidatorService());
    gh.lazySingleton<_i10.ShareService>(() => _i10.ShareService());
    gh.lazySingleton<_i11.ConnectionService>(() => _i11.ConnectionService());
    gh.lazySingletonAsync<_i12.SharedPreferences>(
        () => appModule.sharedPreferences);
    gh.lazySingleton<_i13.AlertService>(() => _i13.AlertService());
    gh.lazySingleton<_i14.SecureStorageService>(
        () => _i14.SecureStorageService());
    gh.lazySingleton<_i15.ProfileNotifier>(() => _i15.ProfileNotifier());
    gh.lazySingleton<_i16.PermissionService>(() => _i16.PermissionService());
    gh.lazySingleton<_i17.CameraPermissionService>(
        () => _i17.CameraPermissionService());
    gh.lazySingleton<_i18.PhotoPermissionService>(
        () => _i18.PhotoPermissionService());
    gh.lazySingleton<_i19.RemoteDataSourceAbs>(
      () => _i20.RemoteDataSourceImp(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i11.ConnectionChecker>(
        () => _i11.ConnectionCheckerImpl());
    gh.lazySingleton<_i21.LocalDataSourceImp>(
      () => _i21.LocalDataSourceImp(),
      registerFor: {
        _dev,
        _test,
        _prod,
      },
    );
    gh.factory<_i22.AuthRemoteDataSource>(() => _i22.AuthRemoteDataSource(
        networkOperation: gh<_i19.RemoteDataSourceAbs>()));
    gh.factory<_i23.HawalaNetworkOperation>(() => _i23.HawalaNetworkOperation(
        networkOperation: gh<_i19.RemoteDataSourceAbs>()));
    gh.factory<_i24.CustomeraNetworkOperation>(() =>
        _i24.CustomeraNetworkOperation(
            networkOperation: gh<_i19.RemoteDataSourceAbs>()));
    gh.factory<_i25.HawalaLocalOperation>(() => _i25.HawalaLocalOperation(
        localOperation: gh<_i21.LocalDataSourceImp>()));
    gh.factory<_i26.CustomersLocalOperation>(() => _i26.CustomersLocalOperation(
        localOperation: gh<_i21.LocalDataSourceImp>()));
    gh.lazySingleton<_i27.AppConfigurationService>(
        () => _i27.AppConfigurationService(gh<_i14.SecureStorageService>()));
    gh.factory<_i28.CustomerRepository>(() => _i29.HawalaRepositoryImpl(
          networkOperation: gh<_i24.CustomeraNetworkOperation>(),
          localDataSource: gh<_i26.CustomersLocalOperation>(),
          networkInfo: gh<_i11.ConnectionChecker>(),
        ));
    gh.lazySingleton<_i30.AddUpdateDeleteCustomerCubit>(() =>
        _i30.AddUpdateDeleteCustomerCubit(
            customerRepository: gh<_i28.CustomerRepository>()));
    gh.factory<_i31.HawalaRepository>(() => _i32.HawalaRepositoryImpl(
          networkOperation: gh<_i23.HawalaNetworkOperation>(),
          localDataSource: gh<_i25.HawalaLocalOperation>(),
          networkInfo: gh<_i11.ConnectionChecker>(),
        ));
    gh.lazySingleton<_i33.CustomersCubit>(
        () => _i33.CustomersCubit(repository: gh<_i28.CustomerRepository>()));
    gh.factory<_i34.AuthRepository>(() => _i35.AuthRepositoryImpl(
          networkOperation: gh<_i22.AuthRemoteDataSource>(),
          localAccountSrc: gh<_i4.LocalAccountSrc>(),
        ));
    gh.lazySingleton<_i36.AuthCubit>(
        () => _i36.AuthCubit(gh<_i34.AuthRepository>()));
    gh.lazySingleton<_i37.HawalaCubit>(
        () => _i37.HawalaCubit(repository: gh<_i31.HawalaRepository>()));
    return this;
  }
}

class _$AppModule extends _i38.AppModule {}
