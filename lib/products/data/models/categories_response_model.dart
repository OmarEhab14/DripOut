import 'package:drip_out/products/data/models/category_model.dart';

class CategoriesResponseModel {
  final List<CategoryModel> categories;
  final int minPrice;
  final int maxPrice;
  final List<String>? sizes;

  CategoriesResponseModel({
    required this.categories,
    required this.minPrice,
    required this.maxPrice,
    required this.sizes,
  });

  factory CategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoriesResponseModel(
      categories: List<Map<String, dynamic>>.from(json['categories'])
          .map((item) => CategoryModel.fromJson(item))
          .toList(),
      minPrice: json['minPrice'],
      maxPrice: json['maxPrice'],
      sizes: json['sizes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories.map((item) => item.toJson()).toList(),
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'sizes': sizes,
    };
  }
}
