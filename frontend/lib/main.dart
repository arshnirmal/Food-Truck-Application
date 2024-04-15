import 'package:flutter/material.dart';
import 'package:food_truck/resources/res.dart';
import 'package:food_truck/utils/app_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Resources.strings.appName,
      routerConfig: AppRouter.router,
      theme: ThemeData(
        fontFamily: Resources.fonts.primaryFont,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
