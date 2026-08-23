import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final int? reviewsCount;
  final double size;

  const RatingStars({
    super.key,
    required this.rating,
    this.reviewsCount,
    this.size = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: AppColors.primary, size: size),
        const SizedBox(width: 2),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: size * 0.85,
            fontWeight: FontWeight.w600,
            color: AppColors.darkText,
          ),
        ),
        if (reviewsCount != null) ...[
          const SizedBox(width: 4),
          Text(
            '($reviewsCount)',
            style: TextStyle(fontSize: size * 0.8, color: AppColors.secondaryText),
          ),
        ],
      ],
    );
  }
}
