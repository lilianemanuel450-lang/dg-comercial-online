import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Como ainda não há upload de imagens reais, cada produto usa um
/// ícone representativo dentro de um card com fundo suave — mantém a
/// identidade visual limpa e é fácil de trocar por Image.network depois.
class ProductImagePlaceholder extends StatelessWidget {
  final String iconKey;
  final double size;
  final BorderRadius? borderRadius;

  const ProductImagePlaceholder({
    super.key,
    required this.iconKey,
    this.size = 80,
    this.borderRadius,
  });

  static const Map<String, IconData> _icons = {
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
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
      ),
      child: Icon(
        _icons[iconKey] ?? Icons.shopping_bag_rounded,
        size: size * 0.45,
        color: AppColors.primary,
      ),
    );
  }
}
