import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/order.dart';

class OrdersProvider extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders.reversed);

  Order createOrder({
    required List<CartItem> items,
    required double subtotal,
    required double shipping,
    required double discount,
    required double total,
    required String paymentMethod,
    required DeliveryAddress address,
  }) {
    final order = Order(
      id: 'DG${100000 + _orders.length + 1}',
      items: items,
      subtotal: subtotal,
      shipping: shipping,
      discount: discount,
      total: total,
      paymentMethod: paymentMethod,
      address: address,
      createdAt: DateTime.now(),
    );
    _orders.add(order);
    notifyListeners();
    return order;
  }

  void advanceStatus(Order order) {
    final currentIndex = Order.trackingSteps.indexOf(order.status);
    if (currentIndex >= 0 && currentIndex < Order.trackingSteps.length - 1) {
      order.status = Order.trackingSteps[currentIndex + 1];
      notifyListeners();
    }
  }

  void cancelOrder(Order order) {
    order.status = OrderStatus.cancelled;
    notifyListeners();
  }
}
