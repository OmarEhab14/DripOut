import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:drip_out/core/apis_helper/api_error_model.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/products/data/models/get_products_params.dart';
import 'package:drip_out/products/data/models/product_model.dart';
import 'package:drip_out/products/data/models/products_response_model.dart';
import 'package:drip_out/products/domain/usecases/get_products_usecase.dart';
import 'package:drip_out/products/presentation/bloc/paginated_products_bloc/cached_states/category_paginated_state.dart';
import 'package:meta/meta.dart';

part 'paginated_products_state.dart';

class PaginatedProductsCubit extends Cubit<PaginatedProductsState> {
  final GetProductsUseCase getProductsUseCase;

  PaginatedProductsCubit(this.getProductsUseCase)
      : super(PaginatedProductsInitial());

  // bool isLastPage = false;
  // int pageNumber = 1;
  final int pageSize = 8;
  final int nextPageTrigger = 1;
  bool loadingNextPage = false;
  int _currentCategoryId = 0;

  final Map<int, CategoryPaginatedState> _categoryStates = {};
  final Map<int, double> _scrollOffsets = {};

  GetProductsParams _currentParams = GetProductsParams();

  Future<void> loadPage({GetProductsParams? params, bool reset = false}) async {
    if (reset) {
      _categoryStates[_currentCategoryId] = CategoryPaginatedState(
        products: [],
        pageNumber: 1,
        isLastPage: false,
        minPrice: 0,
        maxPrice: 0,
        sizes: [],
      );
      emit(PaginatedProductsLoaded(products: [], minPrice: 0, maxPrice: 0, sizes: []));
    }

    final cachedState = _categoryStates[_currentCategoryId];
    final pageNumber = cachedState?.pageNumber ?? 1;

    if (cachedState?.isLastPage ?? false || loadingNextPage) return;

    print('loadPage called with: $params');

    if (params != null) {
      _currentParams = params;
    }

    final List<ProductModel> currentProducts = state is PaginatedProductsLoaded
        ? (state as PaginatedProductsLoaded).products
        : [];

    loadingNextPage = true;
    emit(PaginatedProductsLoading(currentProducts));

    final effectiveParams = _currentParams.copyWith(
      categoryId: _currentCategoryId,
      page: pageNumber,
      pageSize: pageSize,
    );

    final result = await getProductsUseCase(params: effectiveParams);

    loadingNextPage = false;

    if (result is Success<ProductsResponseModel>) {
      final newProducts = result.data.items;
      final minPrice = result.data.minPrice;
      final maxPrice = result.data.maxPrice;
      final sizes = result.data.sizes;
      final isLastPage = result.data.currentPage >= result.data.totalPages;
      final updatedProducts = [...currentProducts, ...newProducts];
      _categoryStates[_currentCategoryId] = CategoryPaginatedState(
        products: updatedProducts,
        pageNumber: pageNumber + 1,
        isLastPage: isLastPage,
        minPrice: minPrice,
        maxPrice: maxPrice,
        sizes: sizes,
      );
      emit(PaginatedProductsLoaded(products: updatedProducts, minPrice: minPrice, maxPrice: maxPrice, sizes: sizes));
    } else if (result is Failure<ProductsResponseModel>) {
      emit(PaginatedProductsError(result.apiErrorModel));
    }
  }

  void checkIfNeedMoreData(int index) {
    final List<ProductModel> currentProducts = state is PaginatedProductsLoaded
        ? (state as PaginatedProductsLoaded).products
        : [];

    if (index == currentProducts.length - nextPageTrigger) {
      loadPage();
    }
  }

  void reloadCachedProducts(int categoryId) {
    _currentCategoryId = categoryId;
    final CategoryPaginatedState? cached = _categoryStates[categoryId];
    if (cached != null) {
      final products = _categoryStates[categoryId]!.products;
      final minPrice = _categoryStates[categoryId]!.minPrice;
      final maxPrice = _categoryStates[categoryId]!.maxPrice;
      final sizes = _categoryStates[categoryId]!.sizes;
      emit(PaginatedProductsLoaded(products: products, minPrice: minPrice, maxPrice: maxPrice, sizes: sizes));
    } else {
      loadPage(params: GetProductsParams(categoryId: categoryId), reset: true);
    }
  }

  Future<void> refresh() async {
    // _categoryStates[_currentCategoryId] = CategoryPaginatedState(
    //   products: [],
    //   pageNumber: 1,
    //   isLastPage: false,
    // );
    emit(PaginatedProductsLoaded(products: [], minPrice: 0, maxPrice: 0, sizes: []));
    await loadPage(reset: true);
  }

  void saveScrollOffset(double scrollOffset) {
    _scrollOffsets[_currentCategoryId] = scrollOffset;
  }

  double getScrollOffset(int categoryId) {
    return _scrollOffsets[categoryId] ?? 0;
  }

}
