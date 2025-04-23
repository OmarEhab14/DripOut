class TokenModel {
  final String accessToken;
  final String refreshToken;

  const TokenModel({required this.accessToken, required this.refreshToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['token'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson(TokenModel tokenModel) {
    return {
      'token': tokenModel.accessToken,
      'refreshToken': tokenModel.refreshToken,
    };
  }
}
