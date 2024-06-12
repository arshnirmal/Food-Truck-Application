import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck/resources/res.dart';
import 'package:food_truck/screens/auth/authentication_repository.dart';
import 'package:food_truck/screens/auth/bloc/login_bloc.dart';
import 'package:food_truck/utils/utils.dart';
import 'package:food_truck/widgets/auth_widgets.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

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
                'Log In',
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
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                height: height * 0.72,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: R.colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: BlocProvider(
                    create: (context) => LoginBloc(authenticationRepository: _authenticationRepository),
                    child: Form(
                      key: _formKey,
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
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return AuthTextFormFieldWidget(
                                controller: _emailController,
                                hintText: 'example@gmail.com',
                                onChanged: (value) {
                                  context.read<LoginBloc>().add(LoginEmailChanged(value));
                                },
                                validator: (value) {
                                  return validateEmail(value);
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8, left: 2),
                            child: Text(
                              'PASSWORD',
                              style: R.textStyles.fz13.merge(R.textStyles.fw400.merge(R.textStyles.fcBlack2)),
                            ),
                          ),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return AuthTextFormFieldWidget(
                                controller: _passwordController,
                                hintText: '**********',
                                onChanged: (value) {
                                  context.read<LoginBloc>().add(LoginPasswordChanged(value));
                                },
                                validator: (value) {
                                  return validatePassword(value ?? '');
                                },
                                obscureText: !state.isPasswordVisible,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    context.read<LoginBloc>().add(const TogglePasswordVisibility());
                                  },
                                  icon: Icon(
                                    state.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: R.colors.textGrey,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                context.push(R.routes.forgotPassword);
                              },
                              child: Text(
                                'Forgot Password?',
                                style: R.textStyles.fz14.merge(R.textStyles.fw400.merge(R.textStyles.fcPrimary)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return AuthButton(
                                height: 62,
                                text: 'LOG IN',
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                                      showSnackBar(context, 'Please fill in all fields');
                                      return;
                                    }

                                    context.read<LoginBloc>().add(const LoginSubmitted());
                                  }
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account? ',
                                style: R.textStyles.fz14.merge(R.textStyles.fw400.merge(R.textStyles.fcBlack2)),
                              ),
                              InkWell(
                                onTap: () {
                                  context.push(R.routes.signup);
                                },
                                child: Text(
                                  'Sign Up',
                                  style: R.textStyles.fz14.merge(R.textStyles.fw500.merge(R.textStyles.fcPrimary)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Align(
                            child: Text(
                              'Or',
                              style: R.textStyles.fz16.merge(R.textStyles.fw400.merge(R.textStyles.fcOnboardingSubtitle)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                padding: const EdgeInsets.all(14),
                                icon: SvgPicture.asset(
                                  R.icons.google,
                                  width: 56,
                                  height: 56,
                                ),
                              ),
                              // const SizedBox(width: 28),
                              IconButton(
                                onPressed: () {},
                                padding: const EdgeInsets.all(14),
                                icon: SvgPicture.asset(
                                  R.icons.facebook,
                                  width: 62,
                                  height: 62,
                                ),
                              ),
                              // const SizedBox(width: 28),
                              IconButton(
                                onPressed: () {},
                                padding: const EdgeInsets.all(14),
                                icon: SvgPicture.asset(
                                  R.icons.apple,
                                  width: 62,
                                  height: 62,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
