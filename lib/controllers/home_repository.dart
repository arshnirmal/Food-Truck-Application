import 'package:food_truck/controllers/user_repository.dart';
import 'package:food_truck/models/food_items/category.dart';
import 'package:food_truck/services/home_service.dart';
import 'package:food_truck/utils/injection.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeRepository {
  final _homeService = getIt<HomeService>();
  final _userRepository = getIt<UserRepository>();

  Future<List<String>> getLocations() async {
    // return await _homeService.getLocations();
    return await Future.delayed(
      const Duration(seconds: 1),
      () => ['Colaba', 'Bandra', 'Andheri', 'Juhu', 'Thane', 'Kandivali', 'Borivali', 'Mira Road'],
    );
  }

  Future<String> getUserName() async {
    final user = await _userRepository.getUser();

    return user?.name ?? 'null';
  }

  Future<List<Category>> getCategories() async {
    return await _homeService.getCategories();
  }
}
