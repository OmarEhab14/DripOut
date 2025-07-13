import 'package:drip_out/products/data/models/product_model.dart';

class ProductsResponseModel {
  final List<ProductModel> items;
  final int currentPage;
  final int pageSize;
  final int count;
  final int totalPages;

  ProductsResponseModel({
    required this.items,
    required this.currentPage,
    required this.pageSize,
    required this.count,
    required this.totalPages,
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
    );
  }
}
