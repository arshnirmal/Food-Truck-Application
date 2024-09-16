import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_truck/controllers/authentication_repository.dart';
import 'package:food_truck/resources/res.dart';
import 'package:food_truck/screens/auth/bloc/auth_bloc.dart';
import 'package:food_truck/utils/ticker.dart';
import 'package:food_truck/utils/utils.dart';
import 'package:food_truck/widgets/auth_widgets.dart';
import 'package:go_router/go_router.dart';

// TODO: Implement Forgot Password Screen
class ForgotPassowordScreen extends StatefulWidget {
  const ForgotPassowordScreen({super.key});

  @override
  State<ForgotPassowordScreen> createState() => _ForgotPassowordScreenState();
}

class _ForgotPassowordScreenState extends State<ForgotPassowordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.darkblue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const AuthHeader(
            title: 'Forgot Password',
            subtitle: 'Please sign in to your existing account',
            isBackButton: true,
          ),
          AuthBody(
            child: BlocProvider(
              create: (context) => AuthBloc(_authenticationRepository),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return _sendEmailForm(context, state);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _sendEmailForm(BuildContext context, AuthState state) {
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
            const SizedBox(height: 24),
            AuthButtonWidget(
              height: 62,
              text: 'Send Email',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<AuthBloc>().add(ForgotPasswordSubmitted(_emailController.text));
                }
                context.push(R.routes.optVerification, extra: _emailController.text);
              },
              isSubmitting: state.isSubmitting,
            ),
          ],
        ),
      ),
    );
  }
}

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();

  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();
  final Ticker _ticker = const Ticker();

  final List<String> _otp = List.generate(4, (index) => '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.darkblue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AuthHeader(
            title: 'Forgot Password',
            subtitle: 'Please sign in to your existing account',
            isBackButton: true,
            verificationEmail: widget.email,
          ),
          AuthBody(
            child: BlocProvider(
              create: (context) => AuthBloc(_authenticationRepository, ticker: _ticker),
              child: _verifyOtpForm(context),
            ),
          )
        ],
      ),
    );
  }

  _buildOtpDigitField(int index) {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        color: R.colors.lightblue,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      child: TextFormField(
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: R.textStyles.fz16.merge(R.textStyles.fw700).merge(R.textStyles.fcTextBlack2),
        decoration: const InputDecoration(
          counter: Offstage(),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        cursorHeight: 24,
        cursorColor: R.colors.textBlack2,
        onChanged: (value) {
          if (value.length == 1) {
            _otp[index] = value;
            FocusScope.of(context).nextFocus();
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
      ),
    );
  }

  _verifyOtpForm(BuildContext context) {
    return Form(
      key: _otpFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AuthTextFormFeildTitleWidget(title: 'CODE'),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<AuthBloc>().add(ForgotPasswordSubmitted(widget.email));
                        },
                        child: Text(
                          'Resend',
                          style: R.textStyles.fz14.merge(R.textStyles.fw700).merge(R.textStyles.fcTextBlack2).merge(R.textStyles.underline),
                        ),
                      ),
                      Text(
                        ' in ',
                        style: R.textStyles.fz14.merge(R.textStyles.fw400).merge(R.textStyles.fcTextBlack2),
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          context.read<AuthBloc>().add(OtpTimerStarted(state.otpTimer));
                          return Text(
                            '${state.otpTimer}sec',
                            style: R.textStyles.fz14.merge(R.textStyles.fw700).merge(R.textStyles.fcTextBlack2),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return _buildOtpDigitField(index);
              }),
            ),
            const SizedBox(height: 24),
            AuthButtonWidget(
              height: 62,
              text: 'VERIFY',
              onPressed: () {
                if (_otpFormKey.currentState!.validate()) {
                  context.read<AuthBloc>().add(VerifyOtpSubmitted(widget.email, _otp.join()));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
