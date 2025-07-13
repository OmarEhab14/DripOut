class ProductModel {
  final int id;
  final String title;
  final double price;
  final double discount;
  final double rate;
  final List<String?> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.discount,
    required this.rate,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      discount: json['discount'],
      rate: json['rate'],
      images: (json['images'] as List<dynamic>).map((e) => e as String?).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'discount': discount,
      'rate': rate,
      'images': images,
    };
  }

}
