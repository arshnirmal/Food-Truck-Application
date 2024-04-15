import 'package:flutter/material.dart';
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
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding1',
        builder: (context, state) => const OnboardingScreen1(),
      ),
      GoRoute(
        path: '/onboarding2',
        pageBuilder: (context, state) {
          return CustomSlideTransition(
            child: const OnboardingScreen2(),
          );
        },
        // builder: (context, state) => const OnboardingScreen2(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}

class CustomSlideTransition extends CustomTransitionPage<void> {
  CustomSlideTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1.5, 0),
                  end: Offset.zero,
                ).chain(
                  CurveTween(curve: Curves.ease),
                ),
              ),
              child: child,
            );
          },
        );
}
