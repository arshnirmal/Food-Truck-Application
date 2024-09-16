import 'dart:async';
import 'dart:developer';

import 'package:food_truck/controllers/user_repository.dart';
import 'package:food_truck/models/auth/auth_models.dart';
import 'package:food_truck/services/auth_service.dart';
import 'package:food_truck/utils/injection.dart';
import 'package:food_truck/utils/logger.dart';
import 'package:food_truck/utils/secure_storage.dart';
import 'package:injectable/injectable.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

@lazySingleton
class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _authService = getIt<AuthenticationService>();
  final _userRepository = getIt<UserRepository>();

  Stream<AuthenticationStatus> get status async* {
    yield* _controller.stream;
  }

  Future<void> verifyAuthStatus() async {
    final token = await SecureStorage().getAuthToken();
    log('Token: $token');
    if (token != null && token.isNotEmpty) {
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<bool> signUp({required String name, required String email, required String password}) async {
    final fcmToken = await SecureStorage().getFCMToken() ?? '';
    final registerReq = RegisterRequest(name: name, email: email, password: password, fcmToken: fcmToken);

    final response = await _authService.register(registerReq);

    if (response != null && response.token.isNotEmpty) {
      await SecureStorage().saveAuthToken(response.token);
      _controller.add(AuthenticationStatus.authenticated);
      if (response.user != null) {
        _userRepository.setUser(response.user!);
      }

      return true;
    }
    _controller.add(AuthenticationStatus.unauthenticated);
    return false;
  }

  Future<bool> logIn({required String email, required String password}) async {
    final fcmToken = await SecureStorage().getFCMToken() ?? '';
    final loginReq = LoginRequest(email: email, password: password, fcmToken: fcmToken);

    final response = await _authService.login(loginReq);

    if (response != null && response.token.isNotEmpty) {
      await SecureStorage().saveAuthToken(response.token);
      _controller.add(AuthenticationStatus.authenticated);
      if (response.user != null) {
        logD('User: ${response.user}');
        _userRepository.setUser(response.user!);
      }

      return true;
    }
    _controller.add(AuthenticationStatus.unauthenticated);
    return false;
  }

  void logOut() async {
    await _authService.logout();
    await SecureStorage().deleteAuthToken();
    _userRepository.clearUser();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  Future<bool> forgotPassword({required String email}) async {
    final forgotPasswordReq = ForgotPasswordRequest(email: email);

    final response = await _authService.forgotPassword(forgotPasswordReq);

    if (response != null && response.verificationCode.isNotEmpty) {
      await SecureStorage().saveOtp(response.verificationCode);
      return true;
    }
    return false;
  }

  Future<bool> verifyOtp({required String email, required String otp}) async {
    final savedOtp = await SecureStorage().getOtp();
    if (savedOtp == otp) {
      await SecureStorage().deleteOtp();
      return true;
    }
    return false;
  }

  void dispose() => _controller.close();
}
