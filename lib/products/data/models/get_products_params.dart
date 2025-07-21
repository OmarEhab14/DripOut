class GetProductsParams {
  final String? search;
  final int? categoryId;
  final double? minPrice;
  final double? maxPrice;
  final String? size;
  final String? orderBy;
  final int? page;
  final int? pageSize;

  GetProductsParams({
    this.search,
    this.categoryId,
    this.minPrice,
    this.maxPrice,
    this.size,
    this.orderBy,
    this.page,
    this.pageSize,
  });

  Map<String, dynamic> toQuery() {
    return {
      if (search != null) 'search': search,
      if (categoryId != null) 'CategoryID': categoryId,
      if (minPrice != null) 'MinPrice': minPrice,
      if (maxPrice != null) 'MaxPrice': maxPrice,
      if (size != null) 'Size': size,
      if (orderBy != null) 'OrderBy': orderBy,
      if (page != null) 'Page': page,
      if (pageSize != null) 'PageSize': pageSize,
    };
  }

  GetProductsParams copyWith({
    String? search,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    String? size,
    String? orderBy,
    int? page,
    int? pageSize,
  }) {
    return GetProductsParams(
      search: search ?? this.search,
      categoryId: categoryId ?? this.categoryId,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      size: size ?? this.size,
      orderBy: orderBy ?? this.orderBy,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
