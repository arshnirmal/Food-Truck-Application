import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_bites/models/user.dart';

class SharedPreferencesUser {
  final SharedPreferencesAsync _sharedPreferencesAsync = SharedPreferencesAsync();

  Future<void> saveUser(User user) async {
    await _sharedPreferencesAsync.setString('user', jsonEncode(user.toJson()));
  }

  Future<User?> getUser() async {
    final user = await _sharedPreferencesAsync.getString('user');
    log('User: $user');
    if (user != null) {
      return User.fromJson(jsonDecode(user));
    }
    return null;
  }

  Future<void> clearUser() async {
    await _sharedPreferencesAsync.remove('user');
  }
}
