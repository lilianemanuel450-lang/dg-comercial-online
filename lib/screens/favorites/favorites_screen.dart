import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/favorites_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/product_card.dart';
import '../product/product_details_screen.dart';
import '../../navigation/main_shell.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(title: const Text('Meus favoritos')),
      body: favorites.isEmpty
          ? EmptyState(
              icon: Icons.favorite_border_rounded,
              title: 'Você ainda não adicionou favoritos.',
              actionLabel: 'Explorar produtos',
              onAction: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const MainShell()),
                (route) => false,
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: 258,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, i) {
                final p = favorites[i];
                return ProductCard(
                  product: p,
                  width: double.infinity,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: p)),
                  ),
                );
              },
            ),
    );
  }
}
