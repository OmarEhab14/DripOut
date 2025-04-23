import 'package:drip_out/account/data/models/user.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';

abstract class UserRepo {
  Future<ApiResult<UserModel>> getUser();
}