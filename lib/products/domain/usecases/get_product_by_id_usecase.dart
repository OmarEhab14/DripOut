import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';
import 'package:drip_out/products/data/models/product_model.dart';
import 'package:drip_out/products/domain/repository/products_repository.dart';

class GetProductByIdUseCase implements UseCase<ApiResult, int> {
  ProductsRepository productsRepository;
  GetProductByIdUseCase(this.productsRepository);

  @override
  Future<ApiResult<ProductModel>> call({int? params}) async {
    return await productsRepository.getProductById(params!);
  }
}