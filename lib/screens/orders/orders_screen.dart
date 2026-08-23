import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/orders_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/formatters.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/status_badge.dart';
import '../../navigation/main_shell.dart';
import 'order_tracking_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrdersProvider>().orders;
    final dateFmt = DateFormat('dd/MM/yyyy');

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(title: const Text('Meus pedidos')),
      body: orders.isEmpty
          ? EmptyState(
              icon: Icons.inventory_2_outlined,
              title: 'Você ainda não fez nenhum pedido.',
              actionLabel: 'Começar a comprar',
              onAction: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const MainShell()),
                (route) => false,
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final order = orders[i];
                final itemsLabel = order.items.map((e) => e.product.name).join(', ');
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => OrderTrackingScreen(order: order)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Pedido ${order.id}',
                                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                            Text(dateFmt.format(order.createdAt),
                                style: const TextStyle(color: AppColors.secondaryText, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(itemsLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: AppColors.secondaryText, fontSize: 12)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatusBadge(status: order.status),
                            Text(AppFormatters.price(order.total),
                                style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
