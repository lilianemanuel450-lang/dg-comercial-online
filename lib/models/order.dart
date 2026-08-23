import 'cart_item.dart';

enum OrderStatus {
  awaitingPayment,
  paymentConfirmed,
  preparing,
  shipped,
  delivered,
  cancelled,
}

extension OrderStatusX on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.awaitingPayment:
        return 'Aguardando pagamento';
      case OrderStatus.paymentConfirmed:
        return 'Pagamento confirmado';
      case OrderStatus.preparing:
        return 'Preparando pedido';
      case OrderStatus.shipped:
        return 'Enviado';
      case OrderStatus.delivered:
        return 'Entregue';
      case OrderStatus.cancelled:
        return 'Cancelado';
    }
  }

  String get emoji {
    switch (this) {
      case OrderStatus.awaitingPayment:
        return '🟠';
      case OrderStatus.paymentConfirmed:
        return '🔵';
      case OrderStatus.preparing:
        return '🟣';
      case OrderStatus.shipped:
        return '🚚';
      case OrderStatus.delivered:
        return '🟢';
      case OrderStatus.cancelled:
        return '🔴';
    }
  }
}

class DeliveryAddress {
  final String province;
  final String municipality;
  final String neighborhood;
  final String street;
  final String number;
  final String reference;
  final String notes;

  const DeliveryAddress({
    required this.province,
    required this.municipality,
    required this.neighborhood,
    required this.street,
    required this.number,
    this.reference = '',
    this.notes = '',
  });

  String get formatted => '$street, $number - $neighborhood, $municipality, $province';
}

class Order {
  final String id;
  final List<CartItem> items;
  final double subtotal;
  final double shipping;
  final double discount;
  final double total;
  final String paymentMethod;
  final DeliveryAddress address;
  final DateTime createdAt;
  OrderStatus status;

  Order({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
    required this.paymentMethod,
    required this.address,
    required this.createdAt,
    this.status = OrderStatus.awaitingPayment,
  });

  static const List<OrderStatus> trackingSteps = [
    OrderStatus.awaitingPayment,
    OrderStatus.paymentConfirmed,
    OrderStatus.preparing,
    OrderStatus.shipped,
    OrderStatus.delivered,
  ];
}
