import 'package:flutter/material.dart';
import 'package:food_truck/resources/res.dart';
import 'package:food_truck/widgets/auth_widgets.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenWidget(
      index: 0,
      image: R.images.onboarding1,
      title: 'Welcome to Urban Bites!',
      subtitle: 'Discover delicious street food nearby with Urban Bites app.',
      onPressed: () {
        context.push(R.routes.onboarding2);
      },
    );
  }
}

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenWidget(
      index: 1,
      image: R.images.onboarding2,
      title: 'Explore Diverse Menus',
      subtitle: 'Find your next favorite dish from a variety of food trucks.',
      onPressed: () {
        context.push(R.routes.onboarding3);
      },
    );
  }
}

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenWidget(
      index: 2,
      image: R.images.onboarding3,
      title: 'Let\'s Get Started',
      subtitle: 'Start your street food adventure with Urban Bites today.',
      onPressed: () {
        context.push(R.routes.login);
      },
    );
  }
}
