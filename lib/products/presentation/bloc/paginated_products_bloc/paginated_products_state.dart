part of 'paginated_products_cubit.dart';

@immutable
sealed class PaginatedProductsState {}

final class PaginatedProductsInitial extends PaginatedProductsState {}

class PaginatedProductsLoading extends PaginatedProductsState {
  final List<ProductModel> oldProducts;
  PaginatedProductsLoading(this.oldProducts);
}

class PaginatedProductsLoaded extends PaginatedProductsState {
  final List<ProductModel> products;
  final double minPrice;
  final double maxPrice;
  final List<String> sizes;
  PaginatedProductsLoaded({required this.products, required this.minPrice, required this.maxPrice, required this.sizes});
}

class PaginatedProductsError extends PaginatedProductsState {
  final ApiErrorModel error;
  PaginatedProductsError(this.error);
}