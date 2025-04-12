import 'package:drip_out/authentication/data/models/login_req_params.dart';
import 'package:drip_out/authentication/data/models/token_model.dart';
import 'package:drip_out/authentication/domain/repository/auth.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class LoginUseCase implements UseCase<ApiResult, LoginReqParams> {
  final AuthRepository authRepository;
  LoginUseCase(this.authRepository);
  @override
  Future<ApiResult<TokenModel>> call({LoginReqParams? params}) async {
    return await authRepository.login(params!);
  }

}