import 'package:drip_out/products/data/models/product_model.dart';

class CategoryPaginatedState {
  final List<ProductModel> products;
  final int pageNumber;
  final bool isLastPage;
  final double minPrice;
  final double maxPrice;
  final List<String> sizes;

  CategoryPaginatedState({
    required this.products,
    required this.pageNumber,
    required this.isLastPage,
    required this.minPrice,
    required this.maxPrice,
    required this.sizes,
  });
}
