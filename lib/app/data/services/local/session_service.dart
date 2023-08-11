import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'usr_usuario';
const _keyToken = 'token';

class SessionService {
  SessionService(this._secureStorage);
  final FlutterSecureStorage _secureStorage;

  Future<String?> get sessionId async {
    final sessionId = await _secureStorage.read(key: _key);
    return sessionId;
  }

  Future<String?> get token async {
    final token = await _secureStorage.read(key: _keyToken);
    return token;
  }

  Future<void> saveSessionId(String sessionId) {
    return _secureStorage.write(
      key: _key,
      value: sessionId,
    );
  }

  Future<void> saveToken(String token) {
    return _secureStorage.write(
      key: 'token',
      value: token,
    );
  }

  Future<void> signOut() async {
    await _secureStorage.delete(
      key: _key,
    );
    await _secureStorage.delete(
      key: _keyToken,
    );
    return;
  }
}
