part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  final String name;
  final String email;
  final String password;
  final bool isPasswordVisible;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final int otpTimer;

  const AuthState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.otpTimer = 30,
  });

  // AuthState copyWith({
  //   String? name,
  //   String? email,
  //   String? password,
  //   bool? isPasswordVisible,
  //   bool? isSubmitting,
  //   bool? isSuccess,
  //   bool? isFailure,
  // }) {
  //   return AuthState(
  //     name: name ?? this.name,
  //     email: email ?? this.email,
  //     password: password ?? this.password,
  //     isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
  //     isSubmitting: isSubmitting ?? this.isSubmitting,
  //     isSuccess: isSuccess ?? this.isSuccess,
  //     isFailure: isFailure ?? this.isFailure,
  //   );
  // }

  @override
  List<Object> get props => [name, email, password, isPasswordVisible, isSubmitting, isSuccess, isFailure, otpTimer];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class PasswordVisibilityToggled extends AuthState {
  const PasswordVisibilityToggled(isPasswordVisible) : super(isPasswordVisible: isPasswordVisible);
}

final class AuthSubmitting extends AuthState {
  const AuthSubmitting()
      : super(
          isSubmitting: true,
          isSuccess: false,
          isFailure: false,
        );
}

final class AuthSuccess extends AuthState {
  const AuthSuccess()
      : super(
          isSuccess: true,
          isFailure: false,
          isSubmitting: false,
        );
}

final class AuthFailure extends AuthState {
  const AuthFailure()
      : super(
          isFailure: true,
          isSubmitting: false,
          isSuccess: false,
        );
}

final class OtpTimerInitial extends AuthState {
  const OtpTimerInitial(otpTimer) : super(otpTimer: otpTimer);
}

final class OtpTimerInProgress extends AuthState {
  const OtpTimerInProgress(otpTimer) : super(otpTimer: otpTimer);
}

final class OtpTimerComplete extends AuthState {
  const OtpTimerComplete() : super(otpTimer: 0);
}
