class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? promotionalPrice;
  final int stock;
  final String categoryId;
  final String icon; // ícone material representando o produto (placeholder visual)
  final double rating;
  final int reviewsCount;
  final List<String> colors;
  final List<String> sizes;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.promotionalPrice,
    required this.stock,
    required this.categoryId,
    required this.icon,
    required this.rating,
    required this.reviewsCount,
    this.colors = const [],
    this.sizes = const [],
  });

  bool get hasPromotion => promotionalPrice != null && promotionalPrice! < price;

  double get finalPrice => hasPromotion ? promotionalPrice! : price;

  int get discountPercent {
    if (!hasPromotion) return 0;
    return (((price - promotionalPrice!) / price) * 100).round();
  }

  bool get inStock => stock > 0;
}
