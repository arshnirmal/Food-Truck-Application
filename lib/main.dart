import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_truck/controllers/authentication_repository.dart';
import 'package:food_truck/controllers/user_repository.dart';
import 'package:food_truck/resources/res.dart';
import 'package:food_truck/screens/auth/bloc/authentication_bloc.dart';
import 'package:food_truck/services/notification_service.dart';
import 'package:food_truck/utils/app_config.dart';
import 'package:food_truck/utils/injection.dart';

import 'firebase_options.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

      configureDependencies(R.strings.test);

      runApp(const App());
    },
    (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _authenticationRepository = getIt<AuthenticationRepository>();
  final _userRepository = getIt<UserRepository>();
  final _notificationService = getIt<NotificationService>();

  @override
  void initState() {
    super.initState();

    _authenticationRepository.verifyAuthStatus();

    _notificationService.requestNotificationPermissions();
    _notificationService.initFirebaseMessaging();
    _notificationService.initLocalNotification();
    _notificationService.tokenRefresh();
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
                  AppRouter.router.goNamed(R.routes.home);
                  break;
                case AuthenticationStatus.unauthenticated:
                  AppRouter.router.goNamed(R.routes.onboarding);
                  break;
                case AuthenticationStatus.unknown:
                default:
                  AppRouter.router.goNamed(R.routes.login);
              }
            },
          );
        },
      ),
    );
  }
}
