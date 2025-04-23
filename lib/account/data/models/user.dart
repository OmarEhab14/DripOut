class UserModel {
  final String message;
  UserModel({required this.message});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson(UserModel userModel) {
    return {
      'message': userModel.message,
    };
  }
}