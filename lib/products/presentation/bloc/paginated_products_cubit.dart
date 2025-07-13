import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:drip_out/core/apis_helper/api_error_model.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/products/data/models/get_products_params.dart';
import 'package:drip_out/products/data/models/product_model.dart';
import 'package:drip_out/products/data/models/products_response_model.dart';
import 'package:drip_out/products/domain/usecases/get_products_usecase.dart';
import 'package:meta/meta.dart';

part 'paginated_products_state.dart';

class PaginatedProductsCubit extends Cubit<PaginatedProductsState> {
  final GetProductsUseCase getProductsUseCase;

  PaginatedProductsCubit(this.getProductsUseCase)
      : super(PaginatedProductsInitial());

  bool isLastPage = false;
  int pageNumber = 1;
  final int pageSize = 8;
  final int nextPageTrigger = 3;
  bool loadingNextPage = false;

  Future<void> loadPage() async {
    if (isLastPage || loadingNextPage) return;

    final List<ProductModel> currentProducts = state is PaginatedProductsLoaded
        ? (state as PaginatedProductsLoaded).products
        : [];

    loadingNextPage = true;
    emit(PaginatedProductsLoading(currentProducts));

    final result = await getProductsUseCase(
      params: GetProductsParams(
        page: pageNumber,
        pageSize: pageSize,
      ),
    );

    loadingNextPage = false;

    if (result is Success<ProductsResponseModel>) {
      final newProducts = result.data.items;
      isLastPage = result.data.currentPage >= result.data.totalPages;
      pageNumber++;
      final updatedProducts = [...currentProducts, ...newProducts];
      emit(PaginatedProductsLoaded(updatedProducts));
    } else if (result is Failure<ProductsResponseModel>) {
      final apiError = result.apiErrorModel;
      emit(PaginatedProductsError(apiError));
    }
  }

  void checkIfNeedMoreData(int index) {
    final List<ProductModel> currentProducts = state is PaginatedProductsLoaded
        ? (state as PaginatedProductsLoaded).products
        : [];
    if (index == currentProducts.length - 1) {
      log('getting more products');
      loadPage();
    }
  }
}
