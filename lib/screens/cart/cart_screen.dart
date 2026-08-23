import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/formatters.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/product_image_placeholder.dart';
import '../../widgets/quantity_selector.dart';
import '../checkout/checkout_screen.dart';
import '../../navigation/main_shell.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text('Carrinho'),
        actions: [
          if (!cart.isEmpty)
            TextButton(
              onPressed: cart.clear,
              child: const Text('Editar', style: TextStyle(color: AppColors.error)),
            ),
        ],
      ),
      body: cart.isEmpty
          ? EmptyState(
              icon: Icons.shopping_cart_outlined,
              title: 'Seu carrinho está vazio.',
              actionLabel: 'Começar a comprar',
              onAction: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const MainShell()),
                (route) => false,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final item = cart.items[i];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProductImagePlaceholder(iconKey: item.product.icon, size: 64),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.product.name,
                                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                                  if (item.selectedColor != null || item.selectedSize != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        [item.selectedColor, item.selectedSize]
                                            .where((e) => e != null)
                                            .join(' • '),
                                        style: const TextStyle(color: AppColors.secondaryText, fontSize: 12),
                                      ),
                                    ),
                                  const SizedBox(height: 6),
                                  Text(AppFormatters.price(item.product.finalPrice),
                                      style: const TextStyle(
                                          color: AppColors.primary, fontWeight: FontWeight.w800)),
                                  const SizedBox(height: 8),
                                  QuantitySelector(
                                    quantity: item.quantity,
                                    onIncrement: () => cart.increment(item),
                                    onDecrement: () => cart.decrement(item),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
                              onPressed: () => cart.remove(item),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, -2)),
                    ],
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        Text('Resumo do pedido',
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                        const SizedBox(height: 12),
                        _summaryRow('Subtotal', AppFormatters.price(cart.subtotal)),
                        _summaryRow('Frete', AppFormatters.price(cart.shipping)),
                        _summaryRow('Desconto', '- ${AppFormatters.price(cart.discount)}'),
                        const Divider(height: 20),
                        _summaryRow('Total', AppFormatters.price(cart.total), bold: true),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.shopping_bag_rounded, size: 18),
                            label: const Text('Finalizar compra'),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
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
          Text(label,
              style: TextStyle(
                  color: bold ? AppColors.darkText : AppColors.secondaryText,
                  fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
                  fontSize: bold ? 16 : 13)),
          Text(value,
              style: TextStyle(
                  color: bold ? AppColors.primary : AppColors.darkText,
                  fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
                  fontSize: bold ? 16 : 13)),
        ],
      ),
    );
  }
}
