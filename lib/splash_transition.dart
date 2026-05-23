import 'dart:async';
import 'package:flutter/material.dart';

class SplashTransitionPage extends StatefulWidget {
  final Widget nextPage;
  const SplashTransitionPage({super.key, required this.nextPage});

  @override
  State<SplashTransitionPage> createState() => _SplashTransitionPageState();
}

class _SplashTransitionPageState extends State<SplashTransitionPage>
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400), // fade in
    );
    
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    
    _controller.forward();
    
    // Total 2 detik: 0.4s fade in + 1.2s diam + 0.4s fade out
    Timer(const Duration(milliseconds: 1600), () {
      _controller.reverse().then((_) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => widget.nextPage,
            transitionDuration: Duration.zero,
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
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Image.asset('assets/images/splash.png'),
        ),
      ),
    );
  }
}