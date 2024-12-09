import 'package:injectable/injectable.dart';
import 'package:urban_bites/controllers/user_repository.dart';
import 'package:urban_bites/models/food_items/category.dart';
import 'package:urban_bites/services/home_service.dart';
import 'package:urban_bites/utils/injection.dart';

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
