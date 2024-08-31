import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_truck/controllers/authentication_repository.dart';
import 'package:food_truck/utils/ticker.dart' as ticker;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authenticationRepository;
  final ticker.Ticker? _ticker;
  StreamSubscription<int>? _tickerSubscription;

  AuthBloc(
    AuthenticationRepository authenticationRepository, {
    ticker.Ticker? ticker,
  })  : _authenticationRepository = authenticationRepository,
        _ticker = ticker,
        super(const AuthInitial()) {
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<ForgotPasswordSubmitted>(_onForgotPasswordSubmitted);
    on<VerifyOtpSubmitted>(_onVerifyOtpSubmitted);
    on<OtpTimerStarted>(_onOtpTimerStarted);
    on<OtpTimerTicked>(_onOtpTimerTicked);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onTogglePasswordVisibility(TogglePasswordVisibility event, Emitter<AuthState> emit) {
    emit(PasswordVisibilityToggled(!state.isPasswordVisible));
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<AuthState> emit) async {
    String email = event.email;
    String password = event.password;

    if (email.isEmpty || password.isEmpty) {
      emit(const AuthFailure());
      return;
    }

    emit(const AuthSubmitting());

    final res = await _authenticationRepository.logIn(email: email, password: password);
    if (res) {
      emit(const AuthSuccess());
    } else {
      emit(const AuthFailure());
    }
  }

  void _onSignUpSubmitted(SignUpSubmitted event, Emitter<AuthState> emit) async {
    String name = event.name;
    String email = event.email;
    String password = event.password;

    emit(const AuthSubmitting());

    final res = await _authenticationRepository.signUp(name: name, email: email, password: password);
    if (res) {
      emit(const AuthSuccess());
    } else {
      emit(const AuthFailure());
    }
  }

  void _onForgotPasswordSubmitted(ForgotPasswordSubmitted event, Emitter<AuthState> emit) async {
    String email = event.email;

    emit(const AuthSubmitting());

    await Future.delayed(const Duration(seconds: 2));

    await _authenticationRepository.forgotPassword(email: email);
  }

  void _onVerifyOtpSubmitted(VerifyOtpSubmitted event, Emitter<AuthState> emit) async {
    String email = event.email;
    String otp = event.otp;

    emit(const AuthSubmitting());

    await _authenticationRepository.verifyOtp(email: email, otp: otp);
    
  }

  void _onOtpTimerStarted(OtpTimerStarted event, Emitter<AuthState> emit) {
    emit(OtpTimerInProgress(event.duration));

    _tickerSubscription?.cancel();

    _tickerSubscription = _ticker?.tick(ticks: event.duration).listen((duration) {
      add(OtpTimerTicked(duration));
    });
  }

  void _onOtpTimerTicked(OtpTimerTicked event, Emitter<AuthState> emit) {
    emit(event.duration > 0 ? OtpTimerInProgress(event.duration) : const OtpTimerComplete());
  }
}
