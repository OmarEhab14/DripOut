import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/products/data/models/get_products_params.dart';
import 'package:drip_out/products/data/models/product_model.dart';

abstract class ProductsRepository {
  Future<ApiResult<List<ProductModel>>> getProducts({GetProductsParams? params});
  Future<ApiResult<ProductModel>> getProductById(int id);
}