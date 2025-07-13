import 'package:drip_out/core/apis_helper/api_error_model.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/products/data/models/get_products_params.dart';
import 'package:drip_out/products/data/models/product_model.dart';
import 'package:drip_out/products/data/models/products_response_model.dart';
import 'package:drip_out/products/data/source/products_remote_data_source.dart';
import 'package:drip_out/products/domain/repository/products_repository.dart';

class ProductsRepoImpl extends ProductsRepository {
  final ProductsRemoteDataSource remote;

  ProductsRepoImpl({required this.remote});

  @override
  Future<ApiResult<ProductModel>> getProductById(int id) async {
    try {
      final result = await remote.getProductById(id);
      final json = result.data as Map<String, dynamic>;
      return Success(ProductModel.fromJson(json));
    } on ApiErrorModel catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ApiErrorModel(message: 'Unknown error occurred'));
    }
  }

  @override
  Future<ApiResult<ProductsResponseModel>> getProducts({GetProductsParams? params}) async {
    try {
      final result = await remote.getProducts(params: params);
      final json = result.data as Map<String, dynamic>;
      return Success(ProductsResponseModel.fromJson(json));
    } on ApiErrorModel catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(ApiErrorModel(message: e.toString()));
    }
  }

}