class AppUser {
  final String name;
  final String email;
  final String phone;

  const AppUser({required this.name, required this.email, required this.phone});
}

class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime createdAt;
  bool read;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    this.read = false,
  });
}
