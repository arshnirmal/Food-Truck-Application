import 'package:dio/dio.dart';
import 'package:food_truck/utils/logger.dart';
import 'package:food_truck/utils/secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class DioClient {
  late final Dio _dio;

  DioClient(@Named('baseUrl') String baseUrl) {
    _initializeDio(baseUrl);
  }

  _initializeDio(String baseUrl) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Authorization': 'Bearer ${SecureStorage().getAuthToken()}',
        },
        contentType: 'application/json',
      ),
    );

    addInterceptors();
  }

  void addInterceptors() {
    _dio.interceptors.clear();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          logger.d('Request: ${options.method} ${options.baseUrl}${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          logger.d('Response: ${response.statusCode} ${response.statusMessage}');
          return handler.next(response);
        },
        onError: (error, handler) {
          logger.e('Error: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  Future<void> updateDioToken(String token) async {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void updateDioContentType(String contentType) {
    _dio.options.contentType = contentType;
  }

  Future<Response> get(String endPoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(endPoint, queryParameters: queryParameters);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        await unauthorized();
      }
      throw Exception(e.message);
    }
  }

  Future<Response> post(
    String endPoint, {
    Map<String, dynamic>? body,
    FormData? formData,
    List<MultipartFile>? files,
    Map<String, dynamic>? queryParameters,
    bool isMultiPartFile = false,
  }) async {
    _dio.options.contentType = isMultiPartFile ? 'multipart/form-data' : 'application/json';

    try {
      return await _dio.post(
        endPoint,
        data: isMultiPartFile ? formData : body,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        await unauthorized();
      }
      throw Exception(e.message);
    }
  }

  Future<Response> put(
    String endPoint, {
    Map<String, dynamic>? body,
    FormData? formData,
    List<MultipartFile>? files,
    Map<String, dynamic>? queryParameters,
    bool isMultiPartFile = false,
  }) async {
    _dio.options.contentType = isMultiPartFile ? 'multipart/form-data' : 'application/json';

    try {
      return await _dio.put(
        endPoint,
        data: isMultiPartFile ? formData : body,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        await unauthorized();
      }
      throw Exception(e.message);
    }
  }

  Future<Response> delete(String endPoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.delete(endPoint, queryParameters: queryParameters);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        await unauthorized();
      }
      throw Exception(e.message);
    }
  }

  Future<void> unauthorized() async {
    await SecureStorage().deleteAuthToken();
  }

  void dispose() {
    _dio.close(force: true);
  }
}
