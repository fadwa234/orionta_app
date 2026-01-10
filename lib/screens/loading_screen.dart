import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Simuler le chargement (5 secondes)
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        // Navigation vers la page de recommandations
        Navigator.pushReplacementNamed(context, '/recommendations');
      }
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Animation de chargement personnalisée
              _buildLoadingAnimation(),

              const SizedBox(height: 80),

              // Texte principal
              const Text(
                'Nous vous mettons en relation avec des parcours académiques adaptés...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),

              // Sous-texte
              const Text(
                'Cela ne prendra pas longtemps',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingAnimation() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animation de rotation
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * math.pi,
                child: child,
              );
            },
            child: _buildRotatingArrows(),
          ),

          // Cercle central
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF5B9BF3).withOpacity(0.1),
            ),
            child: const Icon(
              Icons.school,
              size: 40,
              color: Color(0xFF5B9BF3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRotatingArrows() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        children: [
          // Flèche 1 (haut)
          Positioned(
            top: 0,
            left: 85,
            child: _buildArrow(0),
          ),
          // Flèche 2 (droite)
          Positioned(
            top: 85,
            right: 0,
            child: _buildArrow(math.pi / 2),
          ),
          // Flèche 3 (bas)
          Positioned(
            bottom: 0,
            left: 85,
            child: _buildArrow(math.pi),
          ),
          // Flèche 4 (gauche)
          Positioned(
            top: 85,
            left: 0,
            child: _buildArrow(3 * math.pi / 2),
          ),
        ],
      ),
    );
  }

  Widget _buildArrow(double rotation) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFF5B9BF3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.navigation,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}