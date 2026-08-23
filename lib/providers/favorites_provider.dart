import 'package:flutter/foundation.dart';
import '../models/product.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favoriteIds = {};
  final List<Product> _favoriteProducts = [];

  List<Product> get favorites => List.unmodifiable(_favoriteProducts);

  bool isFavorite(String productId) => _favoriteIds.contains(productId);

  void toggle(Product product) {
    if (_favoriteIds.contains(product.id)) {
      _favoriteIds.remove(product.id);
      _favoriteProducts.removeWhere((p) => p.id == product.id);
    } else {
      _favoriteIds.add(product.id);
      _favoriteProducts.add(product);
    }
    notifyListeners();
  }
}
