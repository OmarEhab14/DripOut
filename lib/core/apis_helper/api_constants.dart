class ApiConstants {
  static const String baseUrl = 'https://quick-sawfly-hugely.ngrok-free.app';
  static const String signUpEndpoint = '/api/Account/Register';
  static const String verifyEndpoint = '/api/Account/Verify';
  static const String loginEndpoint = '/api/Account/Login';
  static const String loginWithGoogleEndpoint = '/api/Account/Google-signin';
  static const String resendVerificationCodeEndpoint = '/api/Account/resend-verification';
  static const String refreshTokenEndpoint = '';
  static const String logoutEndpoint = '';
  static const String userProfileEndpoint = '';
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String tokenTest = '/api/Account/TryTokens';
}