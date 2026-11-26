import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../screens/home/home_screen.dart';
import '../screens/categories/categories_screen.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/orders/orders_screen.dart';
import '../screens/account/account_screen.dart';
import '../theme/app_colors.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  final _screens = const [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    OrdersScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<CartProvider>().totalQuantity;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(
            top: BorderSide(color: AppColors.border, width: 0.5),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              _navItem(0, Icons.home_rounded, Icons.home_outlined, 'Início'),
              _navItem(1, Icons.grid_view_rounded, Icons.grid_view_outlined,
                  'Categorias'),
              _navItem(2, Icons.shopping_bag_rounded,
                  Icons.shopping_bag_outlined, 'Carrinho',
                  badge: cartCount),
              _navItem(3, Icons.inventory_2_rounded,
                  Icons.inventory_2_outlined, 'Pedidos'),
              _navItem(4, Icons.person_rounded, Icons.person_outline_rounded,
                  'Conta'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(
    int index,
    IconData activeIcon,
    IconData icon,
    String label, {
    int badge = 0,
  }) {
    final selected = _index == index;

    return Expanded(
      child: Semantics(
        label: label,
        button: true,
        selected: selected,
        child: GestureDetector(
          onTap: () => setState(() => _index = index),
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            height: 52,
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    selected ? activeIcon : icon,
                    color: selected
                        ? AppColors.darkText
                        : AppColors.secondaryText,
                    size: 28,
                  ),
                  if (badge > 0)
                    Positioned(
                      right: -9,
                      top: -5,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        constraints: const BoxConstraints(
                            minWidth: 16, minHeight: 16),
                        decoration: const BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          badge > 9 ? '9+' : '$badge',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
