import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/order.dart';
import '../../providers/orders_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/formatters.dart';
import '../../widgets/product_image_placeholder.dart';
import '../../widgets/status_badge.dart';

class OrderTrackingScreen extends StatelessWidget {
  final Order order;
  const OrderTrackingScreen({super.key, required this.order});

  static const _stepLabels = [
    'Pedido realizado',
    'Pagamento confirmado',
    'Pedido preparado',
    'Enviado',
    'Entregue',
  ];

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('dd/MM/yyyy HH:mm');
    final currentIndex = Order.trackingSteps.indexOf(order.status);
    final cancelled = order.status == OrderStatus.cancelled;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(title: Text('Pedido ${order.id}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dateFmt.format(order.createdAt),
                  style: const TextStyle(color: AppColors.secondaryText, fontSize: 12)),
              StatusBadge(status: order.status),
            ],
          ),
          const SizedBox(height: 20),
          if (!cancelled)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: List.generate(_stepLabels.length, (i) {
                  final done = i <= currentIndex;
                  final isLast = i == _stepLabels.length - 1;
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: done ? AppColors.success : AppColors.border,
                                shape: BoxShape.circle,
                              ),
                              child: done
                                  ? const Icon(Icons.check_rounded, color: Colors.white, size: 14)
                                  : null,
                            ),
                            if (!isLast)
                              Expanded(
                                child: Container(
                                  width: 2,
                                  color: i < currentIndex ? AppColors.success : AppColors.border,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              _stepLabels[i],
                              style: TextStyle(
                                fontWeight: done ? FontWeight.w700 : FontWeight.w500,
                                color: done ? AppColors.darkText : AppColors.secondaryText,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(16)),
              child: const Row(
                children: [
                  Icon(Icons.cancel_rounded, color: AppColors.error),
                  SizedBox(width: 10),
                  Expanded(child: Text('Este pedido foi cancelado.')),
                ],
              ),
            ),
          const SizedBox(height: 20),
          const Text('Itens do pedido', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 10),
          ...order.items.map((item) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14)),
                child: Row(
                  children: [
                    ProductImagePlaceholder(iconKey: item.product.icon, size: 48),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          Text('Qtd: ${item.quantity}',
                              style: const TextStyle(color: AppColors.secondaryText, fontSize: 12)),
                        ],
                      ),
                    ),
                    Text(AppFormatters.price(item.totalPrice),
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              )),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Endereço de entrega', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text(order.address.formatted, style: const TextStyle(color: AppColors.secondaryText)),
                const Divider(height: 24),
                _summaryRow('Subtotal', AppFormatters.price(order.subtotal)),
                _summaryRow('Frete', order.shipping == 0 ? 'Grátis' : AppFormatters.price(order.shipping)),
                _summaryRow('Total', AppFormatters.price(order.total), bold: true),
              ],
            ),
          ),
          if (!cancelled && order.status != OrderStatus.delivered) ...[
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.read<OrdersProvider>().advanceStatus(order),
                child: const Text('Simular avanço do status (demo)'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.secondaryText, fontSize: 13)),
          Text(value,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
                  color: bold ? AppColors.primary : AppColors.darkText)),
        ],
      ),
    );
  }
}
