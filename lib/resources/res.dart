import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class R {
  static Images images = Images();
  static Iconx icons = Iconx();
  static Fonts fonts = Fonts();
  static Strings strings = Strings();
  static Routes routes = Routes();
  static Colorx colors = Colorx();
  static TextStyles textStyles = TextStyles();
}

class Images {
  String splashScreenBottom = 'assets/images/splashscreen_bottom.svg';
  String splashScreenTop = 'assets/images/splashscreen_top.svg';
  String appName = 'assets/images/app_name.svg';
  String onboarding1 = 'assets/images/onboarding_1.svg';
  String onboarding2 = 'assets/images/onboarding_2.svg';
  String onboarding3 = 'assets/images/onboarding_3.svg';
  String loginTop = 'assets/images/login_top.svg';
  String loginTop2 = 'assets/images/login_top_2.svg';
}

class Iconx {
  String google = 'assets/icons/google.svg';
  String facebook = 'assets/icons/facebook.svg';
  String apple = 'assets/icons/apple.svg';
  String x = 'assets/icons/x.svg';
  String roundedBackButton = 'assets/icons/rounded_back_button.svg';
}

class Fonts {
  String primaryFont = 'Sen';
  String secondaryFont = 'Roboto';
}

class Strings {
  String appName = 'Urban Bites';
  String devAPI = 'http://192.168.1.21:8080/api';
  String prodAPI = 'https://food-truck-latest.onrender.com/api';
}

class Routes {
  String splashscreen = '/';
  String onboarding = '/onboarding';
  String signup = '/signup';
  String login = '/login';
  String forgotPassword = '/forgot-password';
  String optVerification = '/otp-verification';
  String home = '/home';
  String profile = '/profile';
  String settings = '/settings';
}

class Colorx {
  Color primaryColor = const Color(0xFFFF7622);
  Color secondaryColor = const Color(0xFFFFE1CE);
  Color emptyState = const Color(0xFF98A8B8);
  Color onboardingTitle = const Color(0xFF32343E);
  Color onboardingSubtitle = const Color(0xFF646982);
  Color white = const Color(0xFFFFFFFF);
  Color darkblue = const Color(0xFF121223);
  Color black2 = const Color(0xFF32343E);
  Color lightblue = const Color(0xFFF0F5FA);
  Color hintText = const Color(0xFFA0A5BA);
  Color checkBoxOutline = const Color(0xFFE3EBF2);
  Color textGrey = const Color(0xFF7E8A97);
}

class TextStyles {
  final TextStyle fz12 = const TextStyle(fontSize: 12);
  final TextStyle fz13 = const TextStyle(fontSize: 13);
  final TextStyle fz14 = const TextStyle(fontSize: 14);
  final TextStyle fz16 = const TextStyle(fontSize: 16);
  final TextStyle fz18 = const TextStyle(fontSize: 18);
  final TextStyle fz20 = const TextStyle(fontSize: 20);
  final TextStyle fz24 = const TextStyle(fontSize: 24);
  final TextStyle fz30 = const TextStyle(fontSize: 30);

  final TextStyle fw400 = const TextStyle(fontWeight: FontWeight.w400);
  final TextStyle fw500 = const TextStyle(fontWeight: FontWeight.w500);
  final TextStyle fw600 = const TextStyle(fontWeight: FontWeight.w600);
  final TextStyle fw700 = const TextStyle(fontWeight: FontWeight.w700);
  final TextStyle fw800 = const TextStyle(fontWeight: FontWeight.w800);
  final TextStyle fw900 = const TextStyle(fontWeight: FontWeight.w900);

  final TextStyle fcPrimary = TextStyle(color: R.colors.primaryColor);
  final TextStyle fcSecondary = TextStyle(color: R.colors.secondaryColor);
  final TextStyle fcEmptyState = TextStyle(color: R.colors.emptyState);
  final TextStyle fcOnboardingTitle = TextStyle(color: R.colors.onboardingTitle);
  final TextStyle fcOnboardingSubtitle = TextStyle(color: R.colors.onboardingSubtitle);
  final TextStyle fcWhite = TextStyle(color: R.colors.white);
  final TextStyle fcDarkblue = TextStyle(color: R.colors.darkblue);
  final TextStyle fcBlack2 = TextStyle(color: R.colors.black2);
  final TextStyle fcLightblue = TextStyle(color: R.colors.lightblue);
  final TextStyle fcHintText = TextStyle(color: R.colors.hintText);
  final TextStyle fcCheckBoxOutline = TextStyle(color: R.colors.checkBoxOutline);
  final TextStyle fcTextGrey = TextStyle(color: R.colors.textGrey);

  final TextStyle underline = const TextStyle(decoration: TextDecoration.underline);
}
