import 'package:food_truck/controllers/user_repository.dart';
import 'package:food_truck/services/home_service.dart';
import 'package:food_truck/utils/injection.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeRepository {
  final _homeService = getIt<HomeService>();
  final _userRepository = getIt<UserRepository>();

  Future<List<String>> fetchLocations() async {
    return await _homeService.fetchLocations();
  }

  Future<String> getUserName() async {
    final user = await _userRepository.getUser();

    return user?.name ?? 'null';
  }
}
