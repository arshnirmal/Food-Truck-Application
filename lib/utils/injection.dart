import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:urban_bites/resources/res.dart';
import 'package:urban_bites/utils/injection.config.dart';

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
