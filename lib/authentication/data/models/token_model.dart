class TokenModel {
  final String accessToken;
  final String refreshToken;

  const TokenModel({required this.accessToken, required this.refreshToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson(TokenModel tokenModel) {
    return {
      'access_token': tokenModel.accessToken,
      'refresh_token': tokenModel.refreshToken,
    };
  }
}
