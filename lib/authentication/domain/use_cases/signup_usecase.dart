import 'package:drip_out/authentication/data/models/signup_req_params.dart';
import 'package:drip_out/authentication/data/models/token_model.dart';
import 'package:drip_out/authentication/data/repository/auth.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class SignUpUseCase extends UseCase<ApiResult, SignupReqParams> {
  final AuthRepositoryImpl authRepositoryImpl;
  SignUpUseCase({required this.authRepositoryImpl});
  @override
  Future<ApiResult<TokenModel>> call({SignupReqParams? params}) async{
    return await authRepositoryImpl.signUp(params!);
  }
}