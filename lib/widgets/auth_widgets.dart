import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck/resources/res.dart';
import 'package:go_router/go_router.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget authFooter;
  const AuthHeader({super.key, required this.title, required this.subtitle, required this.authFooter});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: R.colors.darkblue,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                R.images.loginTop2,
                height: 96,
              ),
              SvgPicture.asset(
                R.images.loginTop,
                height: height * 0.4,
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: height * 0.13),
              Text(
                title,
                style: R.textStyles.fz30.merge(R.textStyles.fw700.merge(R.textStyles.fcWhite)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: R.textStyles.fz16.merge(R.textStyles.fw400.merge(R.textStyles.fcWhite)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.74,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: R.colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: authFooter,
            ),
          ),
        ],
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.height,
    required this.text,
    required this.onPressed,
  });

  final double height;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: () async {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: R.colors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: R.textStyles.fz14.merge(R.textStyles.fw700.merge(R.textStyles.fcWhite)),
        ),
      ),
    );
  }
}

class OnboardingScreenWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final Function onPressed;
  final int index;

  const OnboardingScreenWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: height * 0.18),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SvgPicture.asset(
                  image,
                  height: height * 0.3,
                ),
              ),
              SizedBox(height: height * 0.064),
              Text(
                title,
                style: R.textStyles.fz24.merge(R.textStyles.fw900.merge(R.textStyles.fcOnboardingTitle)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                subtitle,
                style: R.textStyles.fz16.merge(R.textStyles.fw400.merge(R.textStyles.fcOnboardingSubtitle)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 3; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: i == index ? R.colors.primaryColor : R.colors.secondaryColor,
                      ),
                    ),
                ],
              ),
              const Spacer(),
              AuthButton(
                height: 62,
                text: index == 2 ? 'GET STARTED' : 'NEXT',
                onPressed: onPressed,
              ),
              index == 2
                  ? const SizedBox(
                      height: 48,
                    )
                  : TextButton(
                      onPressed: () {
                        context.pushReplacement(R.routes.login);
                      },
                      child: Text(
                        'Skip',
                        style: R.textStyles.fz16.merge(R.textStyles.fw500.merge(R.textStyles.fcOnboardingSubtitle)),
                      ),
                    ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthTextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool obscureText;

  const AuthTextFormFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: R.textStyles.fz14.merge(R.textStyles.fw400.merge(R.textStyles.fcHintText)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: R.colors.lightblue,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: suffixIcon,
        ),
        onChanged: (value) => onChanged!(value),
        obscureText: obscureText,
        validator: (value) => validator!(value),
      ),
    );
  }
}
