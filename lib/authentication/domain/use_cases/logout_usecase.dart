import 'package:drip_out/authentication/data/repository/auth.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class LogoutUseCase implements UseCase<ApiResult, dynamic> {
  final AuthRepositoryImpl authRepositoryImpl;
  LogoutUseCase({required this.authRepositoryImpl});

  @override
  Future<ApiResult> call({params}) async {
    return await authRepositoryImpl.logout();
  }

}