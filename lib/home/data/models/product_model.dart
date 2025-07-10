class ProductModel {
  final int id;
  final String title;
  final double price;
  final double discount;
  final double rate;
  final List<String> images;

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
      id: json['Id'],
      title: json['Title'],
      price: json['Price'],
      discount: json['Discount'],
      rate: json['Rate'],
      images: json['Images'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Title': title,
      'Price': price,
      'Discount': discount,
      'Rate': rate,
      'Images': images,
    };
  }

}
