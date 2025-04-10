import 'package:drip_out/authentication/data/repository/auth.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class GetUserProfileUseCase implements UseCase<ApiResult, dynamic> {
  final AuthRepositoryImpl authRepositoryImpl;

  GetUserProfileUseCase({required this.authRepositoryImpl});

  @override
  Future<ApiResult> call({params}) async {
    return await authRepositoryImpl.getUserProfile();
  }
}
