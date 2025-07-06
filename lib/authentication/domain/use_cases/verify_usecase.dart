import 'package:drip_out/authentication/data/models/verification_req_params.dart';
import 'package:drip_out/authentication/domain/repository/auth.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class VerifyUseCase implements UseCase<ApiResult, VerificationReqParams> {
  final AuthRepository authRepository;
  VerifyUseCase(this.authRepository);
  @override
  Future<ApiResult> call({VerificationReqParams? params}) async {
    return await authRepository.verify(params!);
  }

}