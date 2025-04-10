import 'package:drip_out/authentication/data/models/login_req_params.dart';
import 'package:drip_out/authentication/data/models/signup_req_params.dart';
import 'package:drip_out/authentication/data/models/token_model.dart';
import 'package:drip_out/authentication/data/models/user.dart';
import 'package:drip_out/authentication/data/source/auth_local_datasource.dart';
import 'package:drip_out/authentication/data/source/auth_remote_datasource.dart';
import 'package:drip_out/authentication/domain/repository/auth.dart';
import 'package:drip_out/core/apis_helper/api_error_model.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthLocalDatasource local;
  final AuthRemoteDatasource remote;

  AuthRepositoryImpl({required this.local, required this.remote});

  @override
  Future<ApiResult<TokenModel>> signUp(SignupReqParams params) async {
    final result = await remote.signUp(params);
    if (result is Success<TokenModel>) {
      local.saveTokens(result.data);
    }
    return result;
  }

  @override
  Future<bool> isLoggedIn() async {
    return await local.hasTokens();
  }

  @override
  Future<ApiResult<TokenModel>> login(LoginReqParams params) async {
    final result = await remote.login(params);
    if (result is Success<TokenModel>) {
      local.saveTokens(result.data);
    }
    return result;
  }

  @override
  Future<ApiResult<TokenModel>> refreshToken() async {
    final tokens = await local.getTokens();
    if (tokens == null) {
      return Failure(
        ApiErrorModel(
          message: 'No refresh token available',
          statusCode: 401,
        ),
      );
    }
    final result = await remote.refreshToken(tokens.refreshToken);
    if (result is Success<TokenModel>) {
      await local.saveTokens(result.data);
    }
    return result;
  }

  @override
  Future<ApiResult<bool>> logout() async {
    final result = await remote.logout();
    await local.deleteTokens();
    return result;
  }

  @override
  Future<ApiResult<User>> getUserProfile() async {
    final result = await remote.getUserProfile();
    return result;
  }
}
