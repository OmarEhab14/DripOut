import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/products/data/models/categories_response_model.dart';
import 'package:drip_out/products/data/models/get_products_params.dart';
import 'package:drip_out/products/data/models/product_model.dart';
import 'package:drip_out/products/data/models/products_response_model.dart';

abstract class ProductsRepository {
  Future<ApiResult<ProductsResponseModel>> getProducts({GetProductsParams? params});
  Future<ApiResult<ProductModel>> getProductById(int id);
  Future<ApiResult<CategoriesResponseModel>> getCategories();
}