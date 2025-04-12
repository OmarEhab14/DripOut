import 'package:drip_out/authentication/data/models/token_model.dart';
import 'package:drip_out/core/storage/secure_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  final SecureStorageService _secureStorageService;

  AuthLocalDatasource(this._secureStorageService);

  Future<bool> hasTokens() async {
    return _secureStorageService.hasTokens();
  }

  Future<void> saveTokens(TokenModel tokenModel) async {
    await _secureStorageService.storeTokens(
      accessToken: tokenModel.accessToken,
      refreshToken: tokenModel.refreshToken,
    );
  }

  Future<TokenModel?> getTokens() async {
    final accessToken = await _secureStorageService.getAccessToken();
    final refreshToken = await _secureStorageService.getRefreshToken();
    if (accessToken != null && refreshToken != null) {
      return TokenModel(accessToken: accessToken, refreshToken: refreshToken);
    }
    return null;
  }

  Future<void> deleteTokens() async {
    await _secureStorageService.deleteTokens();
  }

  Future<bool> isFirstTimeOpen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
    }
    return isFirstTime;
  }
}
