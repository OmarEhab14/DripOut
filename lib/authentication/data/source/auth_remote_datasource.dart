import 'package:drip_out/authentication/data/models/login_req_params.dart';
import 'package:drip_out/authentication/data/models/signup_req_params.dart';
import 'package:drip_out/authentication/data/models/token_model.dart';
import 'package:drip_out/authentication/data/models/user.dart';
import 'package:drip_out/core/apis_helper/api_constants.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/apis_helper/dio_client.dart';

class AuthRemoteDatasource {
  final DioClient _dioClient;

  AuthRemoteDatasource(this._dioClient);

  Future<ApiResult<TokenModel>> signUp(SignupReqParams params) async {
    return await _dioClient.post(
      ApiConstants.signUpEndpoint,
      data: {
        'firstName': params.firstName,
        'lastName': params.lastName,
        'email': params.email,
        'password': params.password,
      },
      converter: (data) => TokenModel.fromJson(data),
    );
  }

  Future<ApiResult<TokenModel>> login(LoginReqParams params) async {
    return await _dioClient.post(
      ApiConstants.loginEndpoint,
      data: {
        'email': params.email,
        'password': params.password,
      },
      converter: (data) => TokenModel.fromJson(data),
    );
  }

  Future<ApiResult<bool>> logout() async {
    return await _dioClient.post(
      ApiConstants.logoutEndpoint,
      converter: (data) => data['success'] ?? false,
    );
  }

  Future<ApiResult<TokenModel>> refreshToken(String refreshToken) async {
    return await _dioClient.post(
      ApiConstants.refreshTokenEndpoint,
      data: {
        'refreshToken': refreshToken,
      },
      converter: (data) => TokenModel.fromJson(data),
    );
  }

  Future<ApiResult<User>> getUserProfile() async {
    return await _dioClient.get(
      ApiConstants.userProfileEndpoint,
      converter: (data) => User.fromJson(data),
    );
  }
}
