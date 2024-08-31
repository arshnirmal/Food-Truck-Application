part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class TogglePasswordVisibility extends AuthEvent {
  const TogglePasswordVisibility();
}

final class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmitted({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

final class SignUpSubmitted extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpSubmitted({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}

final class ForgotPasswordSubmitted extends AuthEvent {
  final String email;

  const ForgotPasswordSubmitted(this.email);

  @override
  List<Object> get props => [email];
}

final class VerifyOtpSubmitted extends AuthEvent {
  final String email;
  final String otp;

  const VerifyOtpSubmitted(this.email, this.otp);

  @override
  List<Object> get props => [email, otp];
}

final class ResetPasswordSubmitted extends AuthEvent {
  final String email;
  final String password;

  const ResetPasswordSubmitted({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

final class LogoutSubmitted extends AuthEvent {}

final class OtpTimerStarted extends AuthEvent {
  final int duration;

  const OtpTimerStarted(this.duration);
}

final class OtpTimerTicked extends AuthEvent {
  final int duration;

  const OtpTimerTicked(this.duration);

  @override
  List<Object> get props => [duration];
}
