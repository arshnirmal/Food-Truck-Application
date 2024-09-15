import 'dart:convert';

import 'package:food_truck/models/user.dart';
import 'package:food_truck/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUser {
  final SharedPreferencesAsync _sharedPreferencesAsync = SharedPreferencesAsync();

  Future<void> saveUser(User user) async {
    await _sharedPreferencesAsync.setString('user', jsonEncode(user.toJson()));
  }

  Future<User?> getUser() async {
    final user = await _sharedPreferencesAsync.getString('user');
    logE('User: $user');
    if (user != null) {
      return User.fromJson(jsonDecode(user));
    }
    return null;
  }

  Future<void> clearUser() async {
    await _sharedPreferencesAsync.remove('user');
  }
}
