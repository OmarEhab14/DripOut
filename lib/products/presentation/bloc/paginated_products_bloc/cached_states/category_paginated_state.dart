import 'package:drip_out/products/data/models/product_model.dart';

class CategoryPaginatedState {
  final List<ProductModel> products;
  final int pageNumber;
  final bool isLastPage;

  CategoryPaginatedState({
    required this.products,
    required this.pageNumber,
    required this.isLastPage,
  });
}
