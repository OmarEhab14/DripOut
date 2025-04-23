import 'package:drip_out/account/data/models/user.dart';
import 'package:drip_out/core/apis_helper/api_constants.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/apis_helper/dio_client.dart';

class AccountRemoteDataSource {
  final DioClient _dioClient;

  AccountRemoteDataSource(this._dioClient);

  Future<ApiResult<UserModel>> getUser() async {
    return await _dioClient.get(
      ApiConstants.tokenTest,
      converter: (data) => UserModel.fromJson(data),
    );
  }
}
