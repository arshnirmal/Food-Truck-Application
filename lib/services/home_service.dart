import 'package:dio/dio.dart';
import 'package:food_truck/models/food_items/category.dart';
import 'package:food_truck/utils/dio_client.dart';
import 'package:food_truck/utils/injection.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeService {
  final _dioClient = getIt<DioClient>();
  final endpoint = '/home';

  Future<List<String>> getLocations() async {
    try {
      final res = await _dioClient.get('$endpoint/locations');

      if (res.statusCode == 200) {
        return List<String>.from(res.data);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
    return [];
  }

  Future<List<Category>> getCategories() async {
    try {
      final res = await _dioClient.get('$endpoint/categories');

      if (res.statusCode == 200) {
        return List<Category>.from(res.data);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
    return [];
  }
}
