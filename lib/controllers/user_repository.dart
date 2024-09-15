import 'package:food_truck/models/user.dart';
import 'package:food_truck/utils/shared_preferences.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRepository {
  final SharedPreferencesUser _sharedPreferences = SharedPreferencesUser();

  Future<User?> getUser() async {
    final user = await _sharedPreferences.getUser();
    return user;
  }

  void setUser(User user) async {
    await _sharedPreferences.saveUser(user);
  }

  void updateUser(User user) async {
    await _sharedPreferences.saveUser(user);
  }

  void clearUser() async {
    await _sharedPreferences.clearUser();
  }
}
