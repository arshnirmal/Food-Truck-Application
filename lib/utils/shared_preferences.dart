import 'dart:convert';

import 'package:food_truck/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUser {
  static SharedPreferencesUser? _instance;
  static SharedPreferences? _preferences;

  static Future<SharedPreferencesUser> getInstance() async {
    _instance ??= SharedPreferencesUser();
    _preferences ??= await SharedPreferences.getInstance();

    return _instance!;
  }

  Future<void> saveUser(User user) async {
    await _preferences!.setString('user', jsonEncode(user.toJson()));
  }

  Future<User?> getUser() async {
    final user = _preferences!.getString('user');
    if (user != null) {
      return User.fromJson(jsonDecode(user));
    }
    return null;
  }

  Future<void> clearUser() async {
    await _preferences!.remove('user');
  }
}
