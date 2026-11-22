import 'package:flutter/material.dart';

/// Paleta oficial do Angoshopping (dark mode).
class AppColors {
  AppColors._();

  // Marca
  static const Color primary = Color(0xFFFF8A00);
  static const Color orange = Color(0xFFFF8A00);
  static const Color red = Color(0xFFFF3D4A);
  static const Color magenta = Color(0xFFE91E8C);
  static const Color purple = Color(0xFF8E2DE2);

  // Fundos
  static const Color background = Color(0xFF0A0A0F);
  static const Color surface = Color(0xFF16161D);
  static const Color lightBackground = surface;

  // Textos (darkText agora é o texto principal, em branco)
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFF9CA3AF);

  // Estados e contornos
  static const Color success = Color(0xFF4ADE80);
  static const Color error = Color(0xFFEF4444);
  static const Color border = Color(0xFF2A2A33);

  // Gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [orange, magenta, purple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [orange, red, magenta, purple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
