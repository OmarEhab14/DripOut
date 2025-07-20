import 'package:drip_out/products/data/models/product_model.dart';

class ProductsResponseModel {
  final List<ProductModel> items;
  final int currentPage;
  final int pageSize;
  final int count;
  final int totalPages;
  final double minPrice;
  final double maxPrice;
  final List<String> sizes;

  ProductsResponseModel({
    required this.items,
    required this.currentPage,
    required this.pageSize,
    required this.count,
    required this.totalPages,
    required this.minPrice,
    required this.maxPrice,
    required this.sizes,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductsResponseModel(
      items: List<Map<String, dynamic>>.from(json['items'])
          .map((item) => ProductModel.fromJson(item))
          .toList(),
      currentPage: json['currentPage'],
      pageSize: json['pageSize'],
      count: json['count'],
      totalPages: json['totalPages'],
      minPrice: json['minPrice'],
      maxPrice: json['maxPrice'],
      sizes: List<String>.from(json['sizes']),
    );
  }
}
