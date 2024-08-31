import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_truck/models/user.dart';
import 'package:food_truck/controllers/user_repository.dart';
import 'package:food_truck/controllers/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late final StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationInitial()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onLogoutRequested);

    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(_AuthenticationStatusChanged(status)),
    );
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }

  Future<void> _onAuthenticationStatusChanged(_AuthenticationStatusChanged event, Emitter<AuthenticationState> emit) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        emit(const AuthenticationFailure());
        break;

      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        if (user != null) {
          emit(AuthenticationSuccess(user));
        } else {
          emit(const AuthenticationFailure());
        }
        break;

      case AuthenticationStatus.unknown:
        emit(const AuthenticationInitial());

      default:
        emit(const AuthenticationInitial());
    }
  }

  Future<void> _onLogoutRequested(AuthenticationLogoutRequested event, Emitter<AuthenticationState> emit) async {
    _authenticationRepository.logOut();
  }
}
