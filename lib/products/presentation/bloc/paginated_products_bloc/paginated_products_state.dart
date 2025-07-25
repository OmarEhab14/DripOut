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
  PaginatedProductsLoaded({required this.products,});
}

class PaginatedProductsError extends PaginatedProductsState {
  final ApiErrorModel error;
  PaginatedProductsError(this.error);
}