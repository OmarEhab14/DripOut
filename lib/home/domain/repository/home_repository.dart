import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/home/data/models/product_model.dart';

abstract class HomeRepository {
  Future<ApiResult<ProductModel>> getAllProducts();
  Future<ApiResult<ProductModel>> getProductById(int id);
  Future<ApiResult<ProductModel>> getProductsByCategory(String category);
}