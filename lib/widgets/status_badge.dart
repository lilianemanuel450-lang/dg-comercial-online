import 'package:flutter/material.dart';
import '../models/order.dart';
import '../theme/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final OrderStatus status;

  const StatusBadge({super.key, required this.status});

  Color get _color {
    switch (status) {
      case OrderStatus.delivered:
        return AppColors.success;
      case OrderStatus.cancelled:
        return AppColors.error;
      case OrderStatus.shipped:
        return AppColors.primary;
      default:
        return AppColors.secondaryText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '${status.emoji} ${status.label}',
        style: TextStyle(color: _color, fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }
}
