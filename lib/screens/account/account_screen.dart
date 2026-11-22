import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_colors.dart';
import '../auth/login_screen.dart';
import '../favorites/favorites_screen.dart';
import '../orders/orders_screen.dart';
import '../support/support_screen.dart';
import 'notifications_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.currentUser;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(title: const Text('Minha conta')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                  child: Text(
                    (user?.name.isNotEmpty ?? false) ? user!.name[0].toUpperCase() : '?',
                    style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user?.name ?? 'Visitante',
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      Text(user?.email ?? 'Entre para gerenciar seus pedidos',
                          style: const TextStyle(color: AppColors.secondaryText, fontSize: 12)),
                    ],
                  ),
                ),
                if (!auth.isLoggedIn)
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    child: const Text('Entrar'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _sectionCard(context, [
            _tile(context, Icons.person_outline_rounded, 'Meu perfil', () {}),
            _tile(context, Icons.inventory_2_outlined, 'Meus pedidos',
                () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrdersScreen()))),
            _tile(context, Icons.location_on_outlined, 'Endereços', () {}),
            _tile(context, Icons.credit_card_outlined, 'Métodos de pagamento', () {}),
            _tile(context, Icons.favorite_border_rounded, 'Favoritos',
                () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesScreen()))),
            _tile(context, Icons.notifications_none_rounded, 'Notificações',
                () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()))),
          ]),
          const SizedBox(height: 12),
          _sectionCard(context, [
            _tile(context, Icons.security_rounded, 'Segurança', () {}),
            _tile(context, Icons.support_agent_rounded, 'Ajuda e suporte',
                () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportScreen()))),
            _tile(context, Icons.description_outlined, 'Termos e condições', () {}),
            _tile(context, Icons.privacy_tip_outlined, 'Política de privacidade', () {}),
          ]),
          const SizedBox(height: 12),
          if (auth.isLoggedIn)
            _sectionCard(context, [
              _tile(context, Icons.logout_rounded, 'Sair', auth.logout, color: AppColors.error),
            ]),
        ],
      ),
    );
  }

  Widget _sectionCard(BuildContext context, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
      child: Column(children: children),
    );
  }

  Widget _tile(BuildContext context, IconData icon, String label, VoidCallback onTap,
      {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.primary),
      title: Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: color)),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.secondaryText),
      onTap: onTap,
    );
  }
}
