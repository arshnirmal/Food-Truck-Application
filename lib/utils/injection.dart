import 'package:food_truck/resources/res.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@module
abstract class RegisterModule {
  @prod
  @Named('baseUrl')
  String get prodBaseUrl => R.strings.prodAPI;

  @dev
  @Named('baseUrl')
  String get devBaseUrl => R.strings.devAPI;
}

@injectableInit
void configureDependencies(String environment) => getIt.init(environment: environment);
