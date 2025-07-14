import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/usecase/usecase.dart';
import 'package:drip_out/products/data/models/categories_response_model.dart';
import 'package:drip_out/products/domain/repository/products_repository.dart';

class GetCategoriesUseCase implements UseCase<ApiResult, dynamic> {
  final ProductsRepository productsRepository;
  GetCategoriesUseCase(this.productsRepository);

  @override
  Future<ApiResult<CategoriesResponseModel>> call({params}) async {
    return await productsRepository.getCategories();
  }

}