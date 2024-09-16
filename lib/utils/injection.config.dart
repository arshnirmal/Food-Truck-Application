// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:food_truck/controllers/authentication_repository.dart' as _i545;
import 'package:food_truck/controllers/home_repository.dart' as _i809;
import 'package:food_truck/controllers/user_repository.dart' as _i169;
import 'package:food_truck/services/auth_service.dart' as _i655;
import 'package:food_truck/services/home_service.dart' as _i803;
import 'package:food_truck/services/notification_service.dart' as _i924;
import 'package:food_truck/utils/dio_client.dart' as _i802;
import 'package:food_truck/utils/injection.dart' as _i109;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

const String _test = 'test';
const String _dev = 'dev';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i924.NotificationService>(() => _i924.NotificationService());
    gh.lazySingleton<_i545.AuthenticationRepository>(
        () => _i545.AuthenticationRepository());
    gh.lazySingleton<_i169.UserRepository>(() => _i169.UserRepository());
    gh.lazySingleton<_i809.HomeRepository>(() => _i809.HomeRepository());
    gh.lazySingleton<_i655.AuthenticationService>(
        () => _i655.AuthenticationService());
    gh.lazySingleton<_i803.HomeService>(() => _i803.HomeService());
    gh.factory<String>(
      () => registerModule.testBaseUrl,
      instanceName: 'baseUrl',
      registerFor: {_test},
    );
    gh.factory<String>(
      () => registerModule.devBaseUrl,
      instanceName: 'baseUrl',
      registerFor: {_dev},
    );
    gh.singleton<_i802.DioClient>(
        () => _i802.DioClient(gh<String>(instanceName: 'baseUrl')));
    return this;
  }
}

class _$RegisterModule extends _i109.RegisterModule {}
