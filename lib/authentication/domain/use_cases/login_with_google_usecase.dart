import 'package:drip_out/authentication/data/models/token_model.dart';
import 'package:drip_out/authentication/domain/repository/auth.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class LoginWithGoogleUseCase implements UseCase<ApiResult<TokenModel>, void> {
  final AuthRepository authRepository;

  LoginWithGoogleUseCase(this.authRepository);

  @override
  Future<ApiResult<TokenModel>> call({void params}) async {
    return await authRepository.loginWithGoogle();
  }
}