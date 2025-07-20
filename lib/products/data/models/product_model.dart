class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discount;
  final double rate;
  final int reviews;
  final String? image;
  final int categoryId;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discount,
    required this.rate,
    required this.reviews,
    required this.image,
    required this.categoryId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      discount: json['discount'],
      rate: json['rate'],
      reviews: json['reviews'],
      image: json['image'], // when it was images not a single image: (json['images'] as List<dynamic>).map((e) => e as String?).toList()
      categoryId: json['categoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'discount': discount,
      'rate': rate,
      'reviews': reviews,
      'image': image,
      'categoryId': categoryId,
    };
  }

}
