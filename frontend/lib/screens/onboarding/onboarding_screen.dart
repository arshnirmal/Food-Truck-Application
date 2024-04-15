import 'package:flutter/material.dart';
import 'package:food_truck/resources/res.dart';
import 'package:food_truck/widgets/onboarding_widget.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenWidget(
      image: Resources.images.onboarding1,
      title: 'Find your comfort food here',
      subtitle: 'Here You Can find a chef or dish for every taste and color. Enjoy!',
      onPressed: () {
        context.push('/onboarding2');
      },
    );
  }
}

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenWidget(
      image: Resources.images.onboarding2,
      title: 'Food Ninja is Where Your Comfort Food Lives',
      subtitle: 'Enjoy a fast and smooth food delivery at your doorstep',
      onPressed: () {
        context.push('/signup');
      },
    );
  }
}
