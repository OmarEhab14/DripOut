import 'package:drip_out/authentication/data/models/login_req_params.dart';
import 'package:drip_out/authentication/data/models/token_model.dart';
import 'package:drip_out/authentication/data/repository/auth.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class LoginUseCase extends UseCase<ApiResult, LoginReqParams> {
  final AuthRepositoryImpl authRepositoryImpl;
  LoginUseCase({required this.authRepositoryImpl});
  @override
  Future<ApiResult<TokenModel>> call({LoginReqParams? params}) async {
    return await authRepositoryImpl.login(params!);
  }

}