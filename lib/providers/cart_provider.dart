import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalQuantity => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get shipping => _items.isEmpty ? 0 : 10.0;

  double get discount => 0.0;

  double get total => subtotal + shipping - discount;

  bool get isEmpty => _items.isEmpty;

  void addProduct(Product product, {int quantity = 1, String? color, String? size}) {
    final key = '${product.id}_${color ?? ''}_${size ?? ''}';
    final existingIndex = _items.indexWhere((i) => i.variantKey == key);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(
        product: product,
        quantity: quantity,
        selectedColor: color,
        selectedSize: size,
      ));
    }
    notifyListeners();
  }

  void increment(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decrement(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      remove(item);
    }
    notifyListeners();
  }

  void remove(CartItem item) {
    _items.removeWhere((i) => i.variantKey == item.variantKey);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
