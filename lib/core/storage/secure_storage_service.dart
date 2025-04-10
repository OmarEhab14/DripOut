import 'package:drip_out/core/apis_helper/api_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _secureStorage;
  SecureStorageService(this._secureStorage);
  Future<String?> getAccessToken() async {
    final accessToken = await _secureStorage.read(key: ApiConstants.accessTokenKey);
    return accessToken;
  }
  Future<void> setAccessToken(String accessToken) async {
    await _secureStorage.write(key: ApiConstants.accessTokenKey, value: accessToken);
  }
  Future<String?> getRefreshToken() async {
    final refreshToken = await _secureStorage.read(key: ApiConstants.refreshTokenKey);
    return refreshToken;
  }
  Future<void> setRefreshToken(String refreshToken) async {
    await _secureStorage.write(key: ApiConstants.refreshTokenKey, value: refreshToken);
  }
  Future<void> deleteTokens() async {
    await _secureStorage.delete(key: ApiConstants.accessTokenKey);
    await _secureStorage.delete(key: ApiConstants.refreshTokenKey);
  }
  Future<bool> hasTokens() async {
    final accessToken = await getAccessToken();
    return accessToken != null && accessToken.isNotEmpty;
  }
  Future<void> storeTokens({required String accessToken, required String refreshToken}) async {
    await setAccessToken(accessToken);
    await setRefreshToken(refreshToken);
  }
}