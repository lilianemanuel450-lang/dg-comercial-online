import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import 'product_image_placeholder.dart';
import 'rating_stars.dart';

/// Produto em formato de post, para feed vertical.
/// A largura vem do pai e a imagem é quadrada.
/// Não usar em listas horizontais (largura ilimitada).
class ProductPostCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductPostCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    final isFav = favorites.isFavorite(product.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          onDoubleTap: () {
            if (!isFav) favorites.toggle(product);
          },
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, c) => ProductImagePlaceholder(
                  iconKey: product.icon,
                  width: c.maxWidth,
                  height: c.maxWidth,
                  borderRadius: BorderRadius.zero,
                ),
              ),
              if (product.hasPromotion)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '-${product.discountPercent}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 4, 12, 0),
          child: Row(
            children: [
              IconButton(
                onPressed: () => favorites.toggle(product),
                icon: Icon(
                  isFav
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: isFav ? AppColors.error : AppColors.darkText,
                  size: 28,
                ),
              ),
              IconButton(
                onPressed: product.inStock
                    ? () {
                        context.read<CartProvider>().addProduct(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                const Text('✓ Produto adicionado ao carrinho'),
                            backgroundColor: AppColors.success,
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    : null,
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: product.inStock
                      ? AppColors.darkText
                      : AppColors.border,
                  size: 27,
                ),
              ),
              const Spacer(),
              if (!product.inStock)
                const Text(
                  'Esgotado',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    AppFormatters.price(product.finalPrice),
                    style: const TextStyle(
                      color: AppColors.darkText,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                  if (product.hasPromotion) ...[
                    const SizedBox(width: 8),
                    Text(
                      AppFormatters.price(product.price),
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.secondaryText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.darkText,
                  fontSize: 14,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 6),
              RatingStars(rating: product.rating, size: 14),
            ],
          ),
        ),
      ],
    );
  }
}
