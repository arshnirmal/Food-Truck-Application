import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck/resources/res.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SafeArea(
      //   child: Stack(
      //     alignment: Alignment.center,
      //     children: [
      //       SvgPicture.asset(
      //         Resources.images.appName,
      //         height: 60,
      //       ),
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Align(
      //             alignment: Alignment.centerLeft,
      //             child: SvgPicture.asset(
      //               Resources.images.splashScreenTop,
      //               height: 100,
      //             ),
      //           ),
      //           Align(
      //             alignment: Alignment.centerRight,
      //             child: SvgPicture.asset(
      //               Resources.images.splashScreenBottom,
      //               height: 300,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
