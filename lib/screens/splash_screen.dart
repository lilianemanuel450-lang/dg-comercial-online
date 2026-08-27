import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../navigation/main_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainShell()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.shopping_bag_rounded, color: AppColors.primary, size: 48),
            ),
            const SizedBox(height: 20),
            const Text('DG COMERCIAL',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20)),
            const Text('ONLINE',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14, letterSpacing: 4)),
            const SizedBox(height: 12),
            const Text('Sua loja, na palma da sua mão.',
                style: TextStyle(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 32),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
