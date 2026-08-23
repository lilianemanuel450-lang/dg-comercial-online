import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/favorites_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/formatters.dart';
import '../../widgets/product_image_placeholder.dart';
import '../../widgets/quantity_selector.dart';
import '../../widgets/rating_stars.dart';
import '../cart/cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;
  String? _selectedColor;
  String? _selectedSize;

  @override
  void initState() {
    super.initState();
    if (widget.product.colors.isNotEmpty) _selectedColor = widget.product.colors.first;
    if (widget.product.sizes.isNotEmpty) _selectedSize = widget.product.sizes.first;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final favorites = context.watch<FavoritesProvider>();
    final isFav = favorites.isFavorite(product.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text('Detalhes do produto',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  IconButton(
                    icon: const Icon(Icons.ios_share_rounded),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Link do produto copiado.')),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: [
                  Center(
                    child: Stack(
                      children: [
                        ProductImagePlaceholder(
                          iconKey: product.icon,
                          size: 220,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: GestureDetector(
                            onTap: () => favorites.toggle(product),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              child: Icon(
                                isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                color: isFav ? AppColors.error : AppColors.secondaryText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(product.name,
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
                  const SizedBox(height: 8),
                  RatingStars(rating: product.rating, reviewsCount: product.reviewsCount, size: 16),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(AppFormatters.price(product.finalPrice),
                          style: const TextStyle(
                              color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 22)),
                      if (product.hasPromotion) ...[
                        const SizedBox(width: 10),
                        Text(AppFormatters.price(product.price),
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: AppColors.secondaryText)),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                              color: AppColors.error, borderRadius: BorderRadius.circular(6)),
                          child: Text('-${product.discountPercent}%',
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(product.description,
                      style: const TextStyle(color: AppColors.secondaryText, height: 1.5)),
                  const SizedBox(height: 20),
                  if (product.colors.isNotEmpty) ...[
                    const Text('Cor:', style: TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: product.colors.map((c) {
                        final selected = _selectedColor == c;
                        return ChoiceChip(
                          label: Text(c),
                          selected: selected,
                          selectedColor: AppColors.primary.withValues(alpha: 0.15),
                          labelStyle: TextStyle(
                              color: selected ? AppColors.primary : AppColors.darkText,
                              fontWeight: FontWeight.w600),
                          onSelected: (_) => setState(() => _selectedColor = c),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (product.sizes.isNotEmpty) ...[
                    const Text('Tamanho:', style: TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: product.sizes.map((s) {
                        final selected = _selectedSize == s;
                        return ChoiceChip(
                          label: Text(s),
                          selected: selected,
                          selectedColor: AppColors.primary.withValues(alpha: 0.15),
                          labelStyle: TextStyle(
                              color: selected ? AppColors.primary : AppColors.darkText,
                              fontWeight: FontWeight.w600),
                          onSelected: (_) => setState(() => _selectedSize = s),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Quantidade', style: TextStyle(fontWeight: FontWeight.w700)),
                      QuantitySelector(
                        quantity: _quantity,
                        onIncrement: () => setState(() => _quantity++),
                        onDecrement: () => setState(() {
                          if (_quantity > 1) _quantity--;
                        }),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  _infoTile(Icons.inventory_2_outlined, 'Disponibilidade',
                      product.inStock ? '${product.stock} unidades em estoque' : 'Produto esgotado'),
                  _infoTile(Icons.local_shipping_outlined, 'Entrega',
                      'Entrega em 3 a 7 dias úteis para todo o país'),
                  _infoTile(Icons.verified_user_outlined, 'Garantia',
                      'Compra protegida com garantia de 90 dias'),
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.shopping_cart_rounded, size: 18),
                    label: Text(product.inStock ? 'Adicionar ao carrinho' : 'Produto esgotado'),
                    onPressed: product.inStock
                        ? () {
                            context.read<CartProvider>().addProduct(
                                  product,
                                  quantity: _quantity,
                                  color: _selectedColor,
                                  size: _selectedSize,
                                );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('✓ Produto adicionado ao carrinho'),
                                backgroundColor: AppColors.success,
                                behavior: SnackBarBehavior.floating,
                                action: SnackBarAction(
                                  label: 'Ver carrinho',
                                  textColor: Colors.white,
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const CartScreen()),
                                  ),
                                ),
                              ),
                            );
                          }
                        : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: AppColors.secondaryText, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
