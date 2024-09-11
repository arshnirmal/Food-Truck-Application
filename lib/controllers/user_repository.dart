import 'package:food_truck/models/user.dart';
import 'package:food_truck/utils/shared_preferences.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRepository {
  User? _user;
  final SharedPreferencesUser _sharedPreferences = SharedPreferencesUser();

  Future<User?> getUser() async {
    if (_user != null) {
      return _user;
    }

    final user = await _sharedPreferences.getUser();
    if (user != null) {
      _user = user;
    }

    return user;
  }

  void setUser(User user) {
    _user = user;
    _sharedPreferences.saveUser(user);
  }

  void updateUser(User user) {
    _user = user;
    _sharedPreferences.saveUser(user);
  }

  void clearUser() {
    _user = null;
    _sharedPreferences.clearUser();
  }
}
