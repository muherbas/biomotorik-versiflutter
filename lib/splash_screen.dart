import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // ganti ke halaman utama kamu

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // durasi fade in
    );
    
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    
    _controller.forward(); // mulai fade in
    
    // Total tampil 4 detik, 3.2s diam, 0.8s fade out
    Timer(const Duration(milliseconds: 3200), () {
      _controller.reverse().then((_) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const HomeScreen(),
            transitionDuration: Duration.zero, // langsung tanpa animasi lagi
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ganti sesuai warna brand
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Image.asset('assets/images/splash.png'),
        ),
      ),
    );
  }
}