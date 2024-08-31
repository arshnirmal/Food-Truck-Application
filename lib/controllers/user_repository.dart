import 'dart:async';

import 'package:food_truck/models/user.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;

    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = const User(
        id: '-1',
        email: 'abc@gm.com',
        name: 'John Doe',
      ),
    );
  }
}
