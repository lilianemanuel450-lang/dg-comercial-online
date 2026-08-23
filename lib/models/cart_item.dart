import 'product.dart';

class CartItem {
  final Product product;
  int quantity;
  String? selectedColor;
  String? selectedSize;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedColor,
    this.selectedSize,
  });

  double get totalPrice => product.finalPrice * quantity;

  String get variantKey => '${product.id}_${selectedColor ?? ''}_${selectedSize ?? ''}';
}
