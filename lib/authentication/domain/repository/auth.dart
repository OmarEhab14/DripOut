import 'package:drip_out/authentication/data/models/login_req_params.dart';
import 'package:drip_out/authentication/data/models/signup_req_params.dart';
import 'package:drip_out/authentication/data/models/token_model.dart';
import 'package:drip_out/authentication/data/models/verification_req_params.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';

abstract class AuthRepository {
  Future<ApiResult<String>> signUp(SignupReqParams params);
  Future<ApiResult<TokenModel>> verify(VerificationReqParams params);
  Future<ApiResult<String>> resendVerificationCode(String email);
  Future<ApiResult<TokenModel>> login(LoginReqParams params);
  Future<ApiResult<TokenModel>> loginWithGoogle();
  Future<ApiResult<bool>> logout();
  Future<bool> isLoggedIn();
  Future<ApiResult<TokenModel>> refreshToken();
  Future<bool> checkIfFirstTime();
}