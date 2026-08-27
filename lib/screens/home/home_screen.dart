import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../providers/auth_provider.dart';
import '../../providers/notifications_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_search_bar.dart';
import '../../widgets/category_card.dart';
import '../../widgets/product_card.dart';
import '../categories/category_products_screen.dart';
import '../product/product_details_screen.dart';
import '../search/search_screen.dart';
import '../account/notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final unread = context.watch<NotificationsProvider>().unreadCount;
    final firstName = auth.currentUser?.name.split(' ').first ?? 'Visitante';

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => Future.delayed(const Duration(milliseconds: 500)),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              // Cabeçalho
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.shopping_bag_rounded, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('DG COMERCIAL ONLINE',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: 0.1)),
                        Text('Olá, $firstName 👋',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: AppColors.secondaryText, fontSize: 12)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.notifications_none_rounded),
                        ),
                        if (unread > 0)
                          Positioned(
                            right: 4,
                            top: 4,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                  color: AppColors.error, shape: BoxShape.circle),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AppSearchBar(
                readOnly: true,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SearchScreen()),
                ),
              ),
              const SizedBox(height: 16),

              // Banner de ofertas
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('OFERTAS ESPECIAIS',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                  letterSpacing: 0.5)),
                          const SizedBox(height: 6),
                          const Text('Até 50% OFF',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22)),
                          const Text('Aproveite agora!',
                              style: TextStyle(color: Colors.white, fontSize: 13)),
                          const SizedBox(height: 14),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CategoryProductsScreen(
                                  categoryId: null,
                                  title: 'Ofertas especiais',
                                  productsOverride:
                                      MockData.products.where((p) => p.hasPromotion).toList(),
                                ),
                              ),
                            ),
                            child: const Text('Ver ofertas'),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.local_offer_rounded, color: Colors.white, size: 56),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Categorias
              _sectionHeader(context, 'Categorias', hideSeeAll: true),
              const SizedBox(height: 10),
              SizedBox(
                height: 96,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: MockData.categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, i) {
                    final cat = MockData.categories[i];
                    return CategoryChip(
                      category: cat,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryProductsScreen(
                            categoryId: cat.id,
                            title: cat.name,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Destaques
              _sectionHeader(context, 'Destaques para você', onSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryProductsScreen(
                      categoryId: null,
                      title: 'Destaques para você',
                      productsOverride: MockData.products,
                    ),
                  ),
                );
              }),
              const SizedBox(height: 10),
              SizedBox(
                height: 258,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: MockData.featured.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, i) {
                    final product = MockData.featured[i];
                    return ProductCard(
                      product: product,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(product: product),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Benefícios
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _BenefitItem(icon: Icons.local_shipping_rounded, label: 'Frete rápido'),
                    _BenefitItem(icon: Icons.lock_rounded, label: 'Pagamento seguro'),
                    _BenefitItem(icon: Icons.support_agent_rounded, label: 'Suporte dedicado'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title,
      {VoidCallback? onSeeAll, bool hideSeeAll = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        if (!hideSeeAll)
          GestureDetector(
            onTap: onSeeAll,
            child: const Text('Ver mais',
                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13)),
          ),
      ],
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _BenefitItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
      ],
    );
  }
}
