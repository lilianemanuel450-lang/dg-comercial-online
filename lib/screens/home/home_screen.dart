import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../providers/notifications_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/product_post_card.dart';
import '../categories/category_products_screen.dart';
import '../product/product_details_screen.dart';
import '../search/search_screen.dart';
import '../account/notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final unread = context.watch<NotificationsProvider>().unreadCount;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.orange,
          backgroundColor: AppColors.surface,
          onRefresh: () async =>
              Future.delayed(const Duration(milliseconds: 500)),
          child: ListView(
            children: [
              _topBar(context, unread),
              _stories(context),
              Container(height: 0.5, color: AppColors.border),
              const SizedBox(height: 8),
              ...MockData.products.map(
                (product) => ProductPostCard(
                  product: product,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsScreen(product: product),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context, int unread) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 4, 0),
      child: Row(
        children: [
          ShaderMask(
            shaderCallback: (rect) =>
                AppColors.primaryGradient.createShader(rect),
            child: const Text(
              'Angoshopping',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 24,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            ),
            icon: const Icon(Icons.search_rounded,
                color: AppColors.darkText, size: 28),
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const NotificationsScreen()),
            ),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications_none_rounded,
                    color: AppColors.darkText, size: 28),
                if (unread > 0)
                  Positioned(
                    right: 1,
                    top: 1,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openOffers(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryProductsScreen(
          categoryId: null,
          title: 'Ofertas especiais',
          productsOverride:
              MockData.products.where((p) => p.hasPromotion).toList(),
        ),
      ),
    );
  }

  Widget _stories(BuildContext context) {
    final cats = MockData.categories;

    return SizedBox(
      height: 116,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        itemCount: cats.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, i) {
          if (i == 0) {
            return _StoryItem(
              label: 'Ofertas',
              onTap: () => _openOffers(context),
              child: const Icon(Icons.local_offer_rounded,
                  color: AppColors.orange, size: 28),
            );
          }
          final cat = cats[i - 1];
          final initial =
              cat.name.isNotEmpty ? cat.name[0].toUpperCase() : '?';
          return _StoryItem(
            label: cat.name,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CategoryProductsScreen(
                  categoryId: cat.id,
                  title: cat.name,
                ),
              ),
            ),
            child: Text(
              initial,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  final String label;
  final Widget child;
  final VoidCallback onTap;

  const _StoryItem({
    required this.label,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              padding: const EdgeInsets.all(2.5


cat > lib/screens/home/home_screen.dart << 'EOF'
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../providers/notifications_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/product_post_card.dart';
import '../categories/category_products_screen.dart';
import '../product/product_details_screen.dart';
import '../search/search_screen.dart';
import '../account/notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final unread = context.watch<NotificationsProvider>().unreadCount;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.orange,
          backgroundColor: AppColors.surface,
          onRefresh: () async =>
              Future.delayed(const Duration(milliseconds: 500)),
          child: ListView(
            children: [
              _topBar(context, unread),
              _stories(context),
              Container(height: 0.5, color: AppColors.border),
              const SizedBox(height: 8),
              ...MockData.products.map(
                (product) => ProductPostCard(
                  product: product,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsScreen(product: product),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context, int unread) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 4, 0),
      child: Row(
        children: [
          ShaderMask(
            shaderCallback: (rect) =>
                AppColors.primaryGradient.createShader(rect),
            child: const Text(
              'Angoshopping',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 24,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            ),
            icon: const Icon(Icons.search_rounded,
                color: AppColors.darkText, size: 28),
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const NotificationsScreen()),
            ),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications_none_rounded,
                    color: AppColors.darkText, size: 28),
                if (unread > 0)
                  Positioned(
                    right: 1,
                    top: 1,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openOffers(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryProductsScreen(
          categoryId: null,
          title: 'Ofertas especiais',
          productsOverride:
              MockData.products.where((p) => p.hasPromotion).toList(),
        ),
      ),
    );
  }

  Widget _stories(BuildContext context) {
    final cats = MockData.categories;

    return SizedBox(
      height: 116,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        itemCount: cats.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, i) {
          if (i == 0) {
            return _StoryItem(
              label: 'Ofertas',
              onTap: () => _openOffers(context),
              child: const Icon(Icons.local_offer_rounded,
                  color: AppColors.orange, size: 28),
            );
          }
          final cat = cats[i - 1];
          final initial =
              cat.name.isNotEmpty ? cat.name[0].toUpperCase() : '?';
          return _StoryItem(
            label: cat.name,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CategoryProductsScreen(
                  categoryId: cat.id,
                  title: cat.name,
                ),
              ),
            ),
            child: Text(
              initial,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        },
      ),
    );
  }
}

  Widget _topBar(BuildContext context, int unread) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 4, 0),
      child: Row(
        children: [
          ShaderMask(
            shaderCallback: (rect) =>
                AppColors.primaryGradient.createShader(rect),
            child: const Text(
              'Angoshopping',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 24,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            ),
            icon: const Icon(Icons.search_rounded,
                color: AppColors.darkText, size: 28),
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const NotificationsScreen()),
            ),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications_none_rounded,
                    color: AppColors.darkText, size: 28),
                if (unread > 0)
                  Positioned(
                    right: 1,
                    top: 1,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openOffers(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryProductsScreen(
          categoryId: null,
          title: 'Ofertas especiais',
          productsOverride:
              MockData.products.where((p) => p.hasPromotion).toList(),
        ),
      ),
    );
  }

class _StoryItem extends StatelessWidget {
  final String label;
  final Widget child;
  final VoidCallback onTap;

  const _StoryItem({
    required this.label,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              padding: const EdgeInsets.all(2.5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.heroGradient,
              ),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.background,
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.surface,
                  ),
                  child: child,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.darkText,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
