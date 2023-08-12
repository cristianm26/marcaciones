import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'usr_usuario';
const _keyToken = 'token';
const _keyUrlApi = 'urlApi';

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

  /* Future<String?> get urlApi async {
    final urlApi = await _secureStorage.read(key: _keyUrlApi);
    return urlApi;
  } */

  Future<void> saveSessionId(String sessionId) {
    return _secureStorage.write(
      key: _key,
      value: sessionId,
    );
  }

  /*  Future<void> saveUrlApi(String urlApi) {
    return _secureStorage.write(
      key: _keyUrlApi,
      value: urlApi,
    );
  } */

  Future<void> saveToken(String token) {
    return _secureStorage.write(
      key: _keyToken,
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
    await _secureStorage.delete(
      key: _keyUrlApi,
    );
    return;
  }
}
