import 'package:dio/dio.dart';
import 'package:food_truck/utils/dio_client.dart';

class AuthenticationService {
  final DioClient dioClient;
  AuthenticationService({required this.dioClient});

  Future<void> login({required String email, required String password}) async {
    try {
      final response = await dioClient.instance.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        await dioClient.updateDioToken(token);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    }
  }
}
