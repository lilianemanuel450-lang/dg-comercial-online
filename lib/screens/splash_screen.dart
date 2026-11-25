import 'package:flutter/material.dart';
import '../navigation/main_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF7A18),
      Color(0xFFFF3D3D),
      Color(0xFFE91E8C),
      Color(0xFF7B2FF7),
    ],
  );

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
      backgroundColor: const Color(0xFF0B0B0F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                gradient: _gradient,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x66E91E8C),
                    blurRadius: 32,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(Icons.shopping_bag_rounded,
                  color: Colors.white, size: 48),
            ),
            const SizedBox(height: 24),
            ShaderMask(
              shaderCallback: (rect) => _gradient.createShader(rect),
              child: const Text(
                'ANGOSHOPPING',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 26,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Compra. Descobre. Vive melhor.',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 36),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Color(0xFFFF7A18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
