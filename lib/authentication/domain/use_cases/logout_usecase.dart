import 'package:drip_out/authentication/domain/repository/auth.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class LogoutUseCase implements UseCase<ApiResult, dynamic> {
  final AuthRepository authRepository;
  LogoutUseCase(this.authRepository);

  @override
  Future<ApiResult> call({params}) async {
    return await authRepository.logout();
  }

}