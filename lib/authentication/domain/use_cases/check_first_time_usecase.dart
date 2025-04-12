import 'package:drip_out/authentication/domain/repository/auth.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class CheckIfFirstTimeUseCase implements UseCase<bool, dynamic> {
  final AuthRepository authRepository;
  CheckIfFirstTimeUseCase(this.authRepository);

  @override
  Future<bool> call({params}) async {
    return await authRepository.checkIfFirstTime();
  }

}