import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck/resources/res.dart';
import 'package:food_truck/utils/utils.dart';
import 'package:food_truck/widgets/auth_widgets.dart';
import 'package:go_router/go_router.dart';

class ForgotPassowrdScreen extends StatefulWidget {
  const ForgotPassowrdScreen({super.key});

  @override
  State<ForgotPassowrdScreen> createState() => _ForgotPassowrdScreenState();
}

class _ForgotPassowrdScreenState extends State<ForgotPassowrdScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: R.colors.darkblue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
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
                      'Forgot Password',
                      style: R.textStyles.fz30.merge(R.textStyles.fw700.merge(R.textStyles.fcWhite)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Please sign in to your existing account',
                      style: R.textStyles.fz16.merge(R.textStyles.fw400.merge(R.textStyles.fcWhite)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Positioned(
                  top: height * 0.04,
                  left: 12,
                  child: IconButton(
                    icon: SvgPicture.asset(
                      R.icons.roundedBackButton,
                      width: 45,
                      height: 45,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
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
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8, left: 2),
                        child: Text(
                          'EMAIL',
                          style: R.textStyles.fz13.merge(R.textStyles.fw400.merge(R.textStyles.fcBlack2)),
                        ),
                      ),
                      AuthTextFormFieldWidget(
                        controller: _emailController,
                        hintText: 'example@gmail.com',
                        onChanged: (value) {
                          // context.read<LoginBloc>().add(LoginEmailChanged(value));
                        },
                        validator: (value) {
                          return validateEmail(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
