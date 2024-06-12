import 'package:flutter/material.dart';
import 'package:food_truck/resources/res.dart';
import 'package:food_truck/screens/auth/login_screen.dart';
import 'package:food_truck/screens/auth/signup_sceen.dart';
import 'package:food_truck/screens/onboarding/onboarding_screen.dart';
import 'package:food_truck/screens/onboarding/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: R.routes.splashscreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: R.routes.onboarding1,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const OnboardingScreen1(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ), 
      ),
      GoRoute(
        path: R.routes.onboarding2,
        pageBuilder: (context, state) => CustomSlideTransition(
          key: state.pageKey,
          child: const OnboardingScreen2(),
        ),
      ),
      GoRoute(
        path: R.routes.onboarding3,
        pageBuilder: (context, state) => CustomSlideTransition(
          key: state.pageKey,
          child: const OnboardingScreen3(),
        ),
      ),
      GoRoute(
        path: R.routes.signup,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: R.routes.login,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}

class CustomSlideTransition extends CustomTransitionPage<void> {
  CustomSlideTransition({Key? key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                ),
              ),
              child: child,
            );
          },
        );
}
