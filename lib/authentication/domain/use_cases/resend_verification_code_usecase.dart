import 'package:drip_out/authentication/domain/repository/auth.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class ResendVerificationCodeUseCase implements UseCase<ApiResult, dynamic> {
  final AuthRepository authRepository;
  ResendVerificationCodeUseCase(this.authRepository);

  @override
  Future<ApiResult<String>> call({params}) async {
    return await authRepository.resendVerificationCode(params!);
  }

}