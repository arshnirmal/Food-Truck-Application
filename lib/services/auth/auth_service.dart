import 'package:dio/dio.dart';
import 'package:food_truck/models/auth/auth_models.dart';
import 'package:food_truck/utils/dio_client.dart';

class AuthenticationService {
  final DioClient dioClient;
  AuthenticationService({required this.dioClient});

  Future<LoginResponse?> login(LoginRequest loginRequest) async {
    try {
      final response = await dioClient.instance.post(
        '/auth/login',
        data: loginRequest.toJson(),
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
    return null;
  }

  Future<RegisterResponse?> register(RegisterRequest registerRequest) async {
    try {
      final response = await dioClient.instance.post(
        '/auth/register',
        data: registerRequest.toJson(),
      );

      if (response.statusCode == 200) {
        return RegisterResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await dioClient.updateDioToken('');
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<ForgotPasswordResponse?> forgotPassword(ForgotPasswordRequest forgotPasswordRequest) async {
    try {
      final response = await dioClient.instance.post(
        '/auth/forgot-password',
        data: forgotPasswordRequest.toJson(),
      );

      if (response.statusCode == 200) {
        return ForgotPasswordResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
    return null;
  }
}
