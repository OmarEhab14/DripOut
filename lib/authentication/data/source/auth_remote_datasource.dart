import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:drip_out/authentication/data/models/login_req_params.dart';
import 'package:drip_out/authentication/data/models/signup_req_params.dart';
import 'package:drip_out/authentication/data/models/token_model.dart';
import 'package:drip_out/authentication/domain/services/google_sign_in_service.dart';
import 'package:drip_out/core/apis_helper/api_constants.dart';
import 'package:drip_out/core/apis_helper/api_error_model.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/apis_helper/dio_client.dart';

class AuthRemoteDatasource {
  final DioClient _dioClient;
  final GoogleSignInService _googleSignInService;

  AuthRemoteDatasource(this._dioClient, this._googleSignInService);

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

  Future<ApiResult<TokenModel>> loginWithGoogle() async {
    final idToken = await _googleSignInService.signInAndGetIdToken();
    if (idToken == null) {
      return Failure(
          ApiErrorModel(statusCode: 404, message: 'Google sign in failed.'));
    }
    return await _dioClient.post(
      ApiConstants.loginWithGoogleEndpoint,
      data: {
        'idToken': idToken
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
}
