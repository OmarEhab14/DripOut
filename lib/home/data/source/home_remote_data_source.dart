import 'package:drip_out/core/apis_helper/api_constants.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/apis_helper/dio_client.dart';
import 'package:drip_out/home/data/models/product_model.dart';

class HomeRemoteDataSource {
  final DioClient _dioClient;

  HomeRemoteDataSource(this._dioClient);

  Future<ApiResult<ProductModel>> getAllProducts() async {
    return await _dioClient.get(
      ApiConstants.productsEndpoint,
      converter: (data) => ProductModel.fromJson(data),
    );
  }
}
