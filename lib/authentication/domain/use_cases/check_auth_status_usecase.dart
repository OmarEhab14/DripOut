import 'package:drip_out/authentication/data/repository/auth.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class CheckAuthStatusUseCase implements UseCase<bool, dynamic> {
  final AuthRepositoryImpl authRepositoryImpl;
  CheckAuthStatusUseCase({required this.authRepositoryImpl});

  @override
  Future<bool> call({params}) async {
    return await authRepositoryImpl.isLoggedIn();
  }

}