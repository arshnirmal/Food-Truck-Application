import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> writeSecureData({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> deleteSecureData({required String key}) async {
    await _storage.delete(key: key);
  }

  Future<String?> readSecureData({required String key}) async {
    return await _storage.read(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  // ------------------------------------------------------------------------------------------------------------------------------------------------

  Future<void> saveToken(String token) async {
    await writeSecureData(key: 'auth_token', value: token);
  }

  Future<String?> getToken() async {
    return await readSecureData(key: 'auth_token');
  }

  Future<void> deleteToken() async {
    await deleteSecureData(key: 'auth_token');
  }
}
