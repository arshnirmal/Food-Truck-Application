import 'package:food_truck/resources/res.dart';
import 'package:food_truck/utils/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@module
abstract class RegisterModule {
  @dev
  @Named('baseUrl')
  String get devBaseUrl => R.strings.devAPI;

  @test
  @Named('baseUrl')
  String get testBaseUrl => R.strings.testAPI;
}

@injectableInit
void configureDependencies(String environment) => getIt.init(environment: environment);
