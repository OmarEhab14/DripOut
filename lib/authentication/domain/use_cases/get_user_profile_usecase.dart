import 'package:drip_out/authentication/domain/repository/auth.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class GetUserProfileUseCase implements UseCase<ApiResult, dynamic> {
  final AuthRepository authRepository;

  GetUserProfileUseCase(this.authRepository);

  @override
  Future<ApiResult> call({params}) async {
    return await authRepository.getUserProfile();
  }
}
