import 'package:injectable/injectable.dart';
import 'package:urban_bites/models/user.dart';
import 'package:urban_bites/utils/shared_preferences.dart';

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
