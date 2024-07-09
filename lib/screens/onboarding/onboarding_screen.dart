import 'package:flutter/material.dart';
import 'package:food_truck/resources/res.dart';
import 'package:food_truck/widgets/auth_widgets.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;
  final int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = TabController(
      length: 3,
      vsync: this,
      initialIndex: _selectedIndex,
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _controller,
        children: [
          OnboardingScreenWidget(
            index: 0,
            image: R.images.onboarding1,
            title: 'Welcome to Urban Bites!',
            subtitle: 'Discover delicious street food nearby with Urban Bites app.',
            onPressed: () {
              _controller.animateTo(1);
            },
          ),
          OnboardingScreenWidget(
            index: 1,
            image: R.images.onboarding2,
            title: 'Explore Diverse Menus',
            subtitle: 'Find your next favorite dish from a variety of food trucks.',
            onPressed: () {
              _controller.animateTo(2);
            },
          ),
          OnboardingScreenWidget(
            index: 2,
            image: R.images.onboarding3,
            title: 'Let\'s Get Started',
            subtitle: 'Start your street food adventure with Urban Bites today.',
            onPressed: () {
              context.pushReplacement(R.routes.login);
            },
          ),
        ],
      ),
    );
  }
}
