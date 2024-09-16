import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck/controllers/authentication_repository.dart';
import 'package:food_truck/resources/res.dart';
import 'package:food_truck/screens/auth/bloc/auth_bloc.dart';
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
    return Scaffold(
      backgroundColor: R.colors.darkblue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _loginHeader(),
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
              child: BlocProvider(
                create: (context) => AuthBloc(_authenticationRepository),
                child: BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      popUntilPath(context, '');
                      context.goNamed(R.routes.home);
                    } else if (state is AuthFailure) {
                      showSnackBar(context, 'Invalid email or password');
                    }
                  },
                  child: _loginForm(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _loginHeader() {
    return const AuthHeader(
      title: 'Log In',
      subtitle: 'Please sign in to your existing account',
    );
  }

  _loginForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthTextFormFeildTitleWidget(title: 'EMAIL'),
            AuthTextFormFieldWidget(
              controller: _emailController,
              hintText: 'example@gmail.com',
              validator: (value) {
                return validateEmail(value);
              },
            ),
            const SizedBox(height: 8),
            const AuthTextFormFeildTitleWidget(title: 'PASSWORD'),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return AuthTextFormFieldWidget(
                  controller: _passwordController,
                  hintText: '**********',
                  validator: (value) {
                    return validatePassword(value ?? '');
                  },
                  obscureText: !state.isPasswordVisible,
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(const TogglePasswordVisibility());
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
                  context.pushNamed(R.routes.forgotPassword);
                },
                child: Text(
                  'Forgot Password?',
                  style: R.textStyles.fz14.merge(R.textStyles.fw400.merge(R.textStyles.fcPrimary)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            _loginButton(),
            const SizedBox(height: 32),
            _signUpButton(),
            const SizedBox(height: 32),
            Align(
              child: Text(
                'Or',
                style: R.textStyles.fz16.merge(R.textStyles.fw400.merge(R.textStyles.fcOnboardingSubtitle)),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            _socialMediaIcons(),
          ],
        ),
      ),
    );
  }

  _loginButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AuthButtonWidget(
          height: 62,
          text: 'LOG IN',
          isSubmitting: state.isSubmitting,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              context.read<AuthBloc>().add(
                    LoginSubmitted(
                      email: _emailController.text,
                      password: _passwordController.text,
                    ),
                  );
            }
          },
        );
      },
    );
  }

  _signUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: R.textStyles.fz14.merge(R.textStyles.fw400.merge(R.textStyles.fcTextBlack2)),
        ),
        InkWell(
          onTap: () {
            context.pushNamed(R.routes.signup);
          },
          child: Text(
            'Sign Up',
            style: R.textStyles.fz14.merge(R.textStyles.fw500.merge(R.textStyles.fcPrimary)),
          ),
        ),
      ],
    );
  }

  _socialMediaIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(14),
          icon: SvgPicture.asset(
            R.icons.google,
            width: 66,
            height: 66,
          ),
        ),
        IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(14),
          icon: SvgPicture.asset(
            R.icons.facebook,
            width: 62,
            height: 62,
          ),
        ),
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
    );
  }
}
