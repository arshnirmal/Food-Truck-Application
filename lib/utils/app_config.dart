import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_bites/resources/res.dart';
import 'package:urban_bites/screens/auth/forgot_password_screen.dart';
import 'package:urban_bites/screens/auth/login_screen.dart';
import 'package:urban_bites/screens/auth/signup_screen.dart';
import 'package:urban_bites/screens/home/home_screen.dart';
import 'package:urban_bites/screens/onboarding/onboarding_screen.dart';
import 'package:urban_bites/screens/onboarding/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'splashscreen',
        path: R.routes.splashscreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: R.routes.onboarding,
        path: '/${R.routes.onboarding}',
        builder: (context, state) => const OnboardingScreen(),
        routes: [
          GoRoute(
            name: R.routes.signup,
            path: R.routes.signup,
            builder: (context, state) => const SignUpScreen(),
          ),
          GoRoute(
            name: R.routes.login,
            path: R.routes.login,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            name: R.routes.forgotPassword,
            path: R.routes.forgotPassword,
            builder: (context, state) => const ForgotPasswordScreen(),
          ),
          GoRoute(
            name: R.routes.optVerification,
            path: R.routes.optVerification,
            builder: (context, state) {
              final String email = state.extra as String;
              return OtpVerificationScreen(email: email);
            },
          ),
        ],
      ),
      GoRoute(
        name: R.routes.home,
        path: '/${R.routes.home}',
        builder: (context, state) => const HomeScreen(),
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
