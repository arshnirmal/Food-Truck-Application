import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck/resources/res.dart';
import 'package:go_router/go_router.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isBackButton;
  final String? verificationEmail;
  final Function? backButtonOnPressed;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.isBackButton = false,
    this.verificationEmail,
    this.backButtonOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.25,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                R.images.loginTop2,
                height: height * 0.15,
              ),
              SvgPicture.asset(
                R.images.loginTop,
                height: height * 0.25,
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
              verificationEmail != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        '$verificationEmail',
                        style: R.textStyles.fz16.merge(R.textStyles.fw700.merge(R.textStyles.fcWhite)),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          isBackButton
              ? Positioned(
                  top: height * 0.04,
                  left: 12,
                  child: IconButton(
                    icon: SvgPicture.asset(
                      R.icons.roundedBackButton,
                      width: 45,
                      height: 45,
                    ),
                    onPressed: () {
                      backButtonOnPressed ?? context.pop();
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class AuthBody extends StatelessWidget {
  final Widget child;
  const AuthBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: R.colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: child,
      ),
    );
  }
}

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget({
    super.key,
    required this.height,
    required this.text,
    required this.onPressed,
    this.isSubmitting = false,
  });

  final double height;
  final String text;
  final Function onPressed;
  final bool isSubmitting;

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
        child: isSubmitting
            ? const SizedBox.square(
                dimension: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: R.textStyles.fz16.merge(R.textStyles.fw700.merge(R.textStyles.fcWhite)),
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
              AuthButtonWidget(
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
                        context.goNamed(R.routes.login);
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
  final FocusNode? focusNode;

  const AuthTextFormFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
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
        obscureText: obscureText,
        validator: (value) => validator!(value),
      ),
    );
  }
}

class AuthTextFormFeildTitleWidget extends StatelessWidget {
  final String title;

  const AuthTextFormFeildTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 2),
      child: Text(
        title,
        style: R.textStyles.fz13.merge(R.textStyles.fw400.merge(R.textStyles.fcBlack2)),
      ),
    );
  }
}
