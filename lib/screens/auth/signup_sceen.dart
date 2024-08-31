import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_truck/controllers/authentication_repository.dart';
import 'package:food_truck/resources/res.dart';
import 'package:food_truck/screens/auth/bloc/auth_bloc.dart';
import 'package:food_truck/utils/utils.dart';
import 'package:food_truck/widgets/auth_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.darkblue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _signUpHeader(),
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
                child: _signUpForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _signUpHeader() {
    return const AuthHeader(
      title: 'Sign Up',
      subtitle: 'Please sign up to get started',
      isBackButton: true,
    );
  }

  _signUpForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthTextFormFeildTitleWidget(title: 'NAME'),
            AuthTextFormFieldWidget(
              controller: _nameController,
              hintText: 'John Doe',
              validator: (value) {
                return validateName(value ?? '');
              },
            ),
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
            const SizedBox(height: 8),
            const AuthTextFormFeildTitleWidget(title: 'RE-TYPE PASSWORD'),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return AuthTextFormFieldWidget(
                  controller: _confirmPasswordController,
                  hintText: '**********',
                  validator: (value) {
                    return validateConfirmPassword(_passwordController.text, value ?? '');
                  },
                  obscureText: true,
                );
              },
            ),
            const SizedBox(height: 30),
            _signUpButton(),
          ],
        ),
      ),
    );
  }

  _signUpButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AuthButtonWidget(
          text: 'SIGN UP',
          height: 62,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<AuthBloc>().add(
                    SignUpSubmitted(name: _nameController.text, email: _emailController.text, password: _passwordController.text),
                  );
            }
          },
        );
      },
    );
  }
}
