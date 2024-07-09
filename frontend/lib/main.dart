import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_truck/models/user_repository.dart';
import 'package:food_truck/resources/res.dart';
import 'package:food_truck/screens/auth/authentication_repository.dart';
import 'package:food_truck/screens/auth/bloc/authentication_bloc.dart';
import 'package:food_truck/utils/app_config.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationBloc(
        authenticationRepository: _authenticationRepository,
        userRepository: _userRepository,
      ),
      child: MaterialApp.router(
        title: R.strings.appName,
        routerConfig: AppRouter.router,
        theme: ThemeData(
          fontFamily: R.fonts.primaryFont,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            child: child,
            listener: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  AppRouter.router.go(R.routes.home);
                  break;
                case AuthenticationStatus.unauthenticated:
                  AppRouter.router.go(R.routes.onboarding);
                  break;
                case AuthenticationStatus.unknown:
                  break;
                default:
                  break;
              }
            },
          );
        },
      ),
    );
  }
}
