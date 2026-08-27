import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Área de imagem do produto. Usa uma ilustração PNG gerada para o produto
/// (assets/images/products/<iconKey>.png). Se o asset não existir por algum
/// motivo, cai para um ícone simples — nunca quebra a tela.
class ProductImagePlaceholder extends StatelessWidget {
  final String iconKey;
  final double? size;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ProductImagePlaceholder({
    super.key,
    required this.iconKey,
    this.size,
    this.width,
    this.height,
    this.borderRadius,
  });

  static const Map<String, IconData> _fallbackIcons = {
    'headphones': Icons.headphones_rounded,
    'sneaker': Icons.directions_run_rounded,
    'watch': Icons.watch_rounded,
    'speaker': Icons.speaker_rounded,
    'phone': Icons.smartphone_rounded,
    'laptop': Icons.laptop_mac_rounded,
    'bag': Icons.shopping_bag_rounded,
    'perfume': Icons.spa_rounded,
    'shirt': Icons.checkroom_rounded,
    'blender': Icons.blender_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final w = width ?? size ?? 80;
    final h = height ?? size ?? 80;
    final radius = borderRadius ?? BorderRadius.circular(16);

    return Container(
      width: w,
      height: h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: radius,
      ),
      padding: EdgeInsets.all(h * 0.10),
      child: Image.asset(
        'assets/images/products/$iconKey.png',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Center(
          child: Icon(
            _fallbackIcons[iconKey] ?? Icons.shopping_bag_rounded,
            size: (w < h ? w : h) * 0.45,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
