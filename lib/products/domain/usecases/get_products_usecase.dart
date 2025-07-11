import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';
import 'package:drip_out/products/data/models/get_products_params.dart';
import 'package:drip_out/products/data/models/product_model.dart';
import 'package:drip_out/products/domain/repository/products_repository.dart';

class GetProductsUseCase implements UseCase<ApiResult, GetProductsParams> {
  ProductsRepository productsRepository;
  GetProductsUseCase(this.productsRepository);
  @override
  Future<ApiResult<List<ProductModel>>> call({GetProductsParams? params}) async {
    return await productsRepository.getProducts(params: params);
  }
}