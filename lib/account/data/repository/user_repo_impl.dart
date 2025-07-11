import 'package:drip_out/account/data/models/user.dart';
import 'package:drip_out/account/data/source/account_remote_datasource.dart';
import 'package:drip_out/account/domain/repository/user_repo.dart';
import 'package:drip_out/core/apis_helper/api_error_model.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';

class UserRepoImpl extends UserRepo {
  final AccountRemoteDataSource remote;

  UserRepoImpl(this.remote);

  @override
  Future<ApiResult<UserModel>> getUser() async {
    try {
      final result = await remote.getUser();
      final json = result.data as Map<String, dynamic>;
      return Success(UserModel.fromJson(json));
    } on ApiErrorModel catch(e) {
      return Failure(e);
    } catch (e) {
      return Failure(ApiErrorModel(message: 'Unknown error occurred'));
    }
  }
}