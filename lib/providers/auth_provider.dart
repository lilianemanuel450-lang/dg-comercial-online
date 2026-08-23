import 'package:flutter/foundation.dart';
import '../models/user.dart';

/// Autenticação simulada localmente. Preparada para futura integração
/// com um serviço real (ex.: Firebase Auth, API própria etc.).
class AuthProvider extends ChangeNotifier {
  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _currentUser = AppUser(
      name: email.split('@').first.isNotEmpty ? _capitalize(email.split('@').first) : 'Cliente',
      email: email,
      phone: '',
    );
    notifyListeners();
    return true;
  }

  Future<bool> register(String name, String email, String phone, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _currentUser = AppUser(name: name, email: email, phone: phone);
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  String _capitalize(String s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
}
