import 'package:drip_out/authentication/domain/repository/auth.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class CheckAuthStatusUseCase implements UseCase<bool, dynamic> {
  final AuthRepository authRepository;
  CheckAuthStatusUseCase(this.authRepository);

  @override
  Future<bool> call({params}) async {
    return await authRepository.isLoggedIn();
  }

}