import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppSearchBar extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextEditingController? controller;

  const AppSearchBar({
    super.key,
    this.hint = 'Buscar produtos...',
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.search_rounded, color: AppColors.secondaryText),
      ),
    );
  }
}
