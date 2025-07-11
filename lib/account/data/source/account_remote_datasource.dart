import 'package:dio/dio.dart';
import 'package:drip_out/core/apis_helper/api_constants.dart';
import 'package:drip_out/core/apis_helper/dio_client.dart';

class AccountRemoteDataSource {
  final DioClient _dioClient;

  AccountRemoteDataSource(this._dioClient);

  Future<Response> getUser() async {
    return await _dioClient.get(
      ApiConstants.tokenTest,
    );
  }
}
