import 'dart:async';

import 'package:dio/dio.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final Dio _dio = Dio();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<bool> signUp({required String email, required String password}) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );

    return false;
  }

  Future<bool> logIn({required String email, required String password}) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );

    return false;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  Future<int> forgotPassword({required String email}) async {
    return -1;
  }

  void dispose() => _controller.close();
}
