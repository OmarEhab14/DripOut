import 'package:drip_out/authentication/data/models/token_model.dart';
import 'package:drip_out/authentication/data/repository/auth.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class RefreshTokenUseCase implements UseCase<ApiResult, dynamic> {
  final AuthRepositoryImpl authRepositoryImpl;
  RefreshTokenUseCase({required this.authRepositoryImpl});

  @override
  Future<ApiResult<TokenModel>> call({params}) async {
    return await authRepositoryImpl.refreshToken();
  }

}