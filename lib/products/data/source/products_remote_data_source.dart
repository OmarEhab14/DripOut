import 'package:dio/dio.dart';
import 'package:drip_out/core/apis_helper/api_constants.dart';
import 'package:drip_out/core/apis_helper/dio_client.dart';
import 'package:drip_out/products/data/models/get_products_params.dart';

class ProductsRemoteDataSource {
  final DioClient _dioClient;

  ProductsRemoteDataSource(this._dioClient);

  Future<Response> getProducts({GetProductsParams? params}) async {
    return await _dioClient.get(
      ApiConstants.productsEndpoint,
      queryParameters: params?.toQuery(),
    );
  }

  Future<Response> getProductById(int id) async {
    return await _dioClient.get(
      '${ApiConstants.productsEndpoint}/$id',
    );
  }
}
