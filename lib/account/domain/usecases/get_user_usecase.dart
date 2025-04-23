import 'package:drip_out/account/data/models/user.dart';
import 'package:drip_out/account/domain/repository/user_repo.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';

class GetUserUseCase extends UseCase {
  final UserRepo userRepo;

  GetUserUseCase(this.userRepo);

  @override
  Future<ApiResult<UserModel>> call({params}) async {
    return await userRepo.getUser();
  }

}