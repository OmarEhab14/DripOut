import 'package:drip_out/authentication/data/models/token_model.dart';
import 'package:drip_out/authentication/domain/repository/auth.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class RefreshTokenUseCase implements UseCase<ApiResult, dynamic> {
  final AuthRepository authRepository;
  RefreshTokenUseCase(this.authRepository);

  @override
  Future<ApiResult<TokenModel>> call({params}) async {
    return await authRepository.refreshToken();
  }

}