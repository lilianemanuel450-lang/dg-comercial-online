import 'package:flutter/material.dart';

/// Paleta oficial da DG Comercial Online.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFF9800);
  static const Color orange = Color(0xFFFF8A00);
  static const Color background = Color(0xFFFFFFFF);
  static const Color lightBackground = Color(0xFFF8F8F8);
  static const Color darkText = Color(0xFF1F2937);
  static const Color secondaryText = Color(0xFF6B7280);
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color border = Color(0xFFE5E7EB);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, orange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
