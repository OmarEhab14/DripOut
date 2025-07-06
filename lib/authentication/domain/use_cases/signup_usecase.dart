import 'package:drip_out/authentication/data/models/signup_req_params.dart';
import 'package:drip_out/authentication/domain/repository/auth.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class SignUpUseCase implements UseCase<ApiResult, SignupReqParams> {
  final AuthRepository authRepository;
  SignUpUseCase(this.authRepository);
  @override
  Future<ApiResult<String>> call({SignupReqParams? params}) async{
    return await authRepository.signUp(params!);
  }
}