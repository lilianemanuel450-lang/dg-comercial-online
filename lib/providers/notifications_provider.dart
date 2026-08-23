import 'package:flutter/foundation.dart';
import '../models/user.dart';

class NotificationsProvider extends ChangeNotifier {
  final List<AppNotification> _notifications = [
    AppNotification(
      id: 'n1',
      title: 'Bem-vindo(a)!',
      message: 'Obrigado por instalar a DG Comercial Online. Aproveite as ofertas especiais.',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    AppNotification(
      id: 'n2',
      title: 'Nova oferta disponível',
      message: 'Fone Bluetooth Premium com até 50% OFF por tempo limitado.',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  List<AppNotification> get notifications => List.unmodifiable(_notifications.reversed);

  int get unreadCount => _notifications.where((n) => !n.read).length;

  void add(String title, String message) {
    _notifications.add(AppNotification(
      id: 'n${_notifications.length + 1}',
      title: title,
      message: message,
      createdAt: DateTime.now(),
    ));
    notifyListeners();
  }

  void markAllRead() {
    for (final n in _notifications) {
      n.read = true;
    }
    notifyListeners();
  }
}
