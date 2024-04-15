import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck/resources/res.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(
        const Duration(seconds: 2),
        () => context.pushReplacement('/onboarding1'),
      ),
      builder: (context, snapshot) {
        return Scaffold(
          body: Stack(
            children: [
              SvgPicture.asset(
                Resources.images.splashScreen,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Resources.images.logo,
                      height: 139,
                      width: 175,
                    ),
                    SvgPicture.asset(
                      Resources.images.appName,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
