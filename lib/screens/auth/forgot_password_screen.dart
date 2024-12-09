import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_bites/controllers/authentication_repository.dart';
import 'package:urban_bites/resources/res.dart';
import 'package:urban_bites/screens/auth/bloc/auth_bloc.dart';
import 'package:urban_bites/utils/ticker.dart';
import 'package:urban_bites/utils/utils.dart';
import 'package:urban_bites/widgets/auth_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();
  final TextEditingController _emailController = TextEditingController();
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();

    _authBloc = AuthBloc(_authenticationRepository);
  }

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
              create: (context) => _authBloc,
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return _sendEmailForm();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _sendEmailForm() {
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
                  _authBloc.add(ForgotPasswordSubmitted(_emailController.text));
                }
                context.push(R.routes.optVerification, extra: _emailController.text);
              },
              isSubmitting: _authBloc.state.isSubmitting,
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
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();

    _authBloc = AuthBloc(_authenticationRepository, ticker: _ticker);
  }

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
              create: (context) => _authBloc,
              child: _verifyOtpForm(),
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

  _verifyOtpForm() {
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
                          _authBloc.add(ForgotPasswordSubmitted(widget.email));
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
                          _authBloc.add(OtpTimerStarted(state.otpTimer));
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
                  _authBloc.add(VerifyOtpSubmitted(widget.email, _otp.join()));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
