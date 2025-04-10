import 'package:drip_out/authentication/data/models/token_model.dart';
import 'package:drip_out/core/storage/secure_storage_service.dart';

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
}
