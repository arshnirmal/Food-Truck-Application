import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_truck/models/auth/auth_models.dart';
import 'package:food_truck/services/firebase/notification_service.dart';
import 'package:food_truck/utils/dio_client.dart';
import 'package:food_truck/utils/injection.dart';
import 'package:food_truck/utils/logger.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthenticationService {
  final _dioClient = getIt<DioClient>();
  final _notificationService = getIt<NotificationService>();
  final endpoint = '/auth';

  Future<bool> helloworld() async {
    try {
      final res = await _dioClient.get('$endpoint/');

      if (res.statusCode == 200) {
        logD(res.data);
        return true;
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
    return false;
  }

  Future<AuthResponse?> login(LoginRequest loginRequest) async {
    try {
      final response = await _dioClient.post(
        '$endpoint/login',
        body: loginRequest.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AuthResponse.fromJson(response.data);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        return AuthResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
    return null;
  }

  Future<AuthResponse?> register(RegisterRequest registerRequest) async {
    try {
      final response = await _dioClient.post(
        '$endpoint/register',
        body: registerRequest.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AuthResponse.fromJson(response.data);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        return AuthResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
    return null;
  }

  Future<bool?> logout() async {
    try {
      await _dioClient.updateDioToken('');
      await _notificationService.killNotification();

      return true;
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<ForgotPasswordResponse?> forgotPassword(ForgotPasswordRequest forgotPasswordRequest) async {
    try {
      final response = await _dioClient.post(
        '$endpoint/forgot-password',
        body: forgotPasswordRequest.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ForgotPasswordResponse.fromJson(response.data);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        return ForgotPasswordResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
    return null;
  }
}
