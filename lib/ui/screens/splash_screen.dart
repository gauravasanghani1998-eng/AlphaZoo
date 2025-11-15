import 'package:flutter/material.dart';
import 'dart:async' as async;
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import '../../core/app_colors.dart';
import '../../core/app_assets.dart';
import 'home_screen.dart';

/// Animated splash screen with app logo and optional Flame effects
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Setup animations
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    // Start animation
    _controller.forward();

    // Navigate to home after delay
    async.Timer(const Duration(milliseconds: 1600), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
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
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // Optional Flame background animation
          Positioned.fill(
            child: _buildFlameBackground(),
          ),
          
          // Logo animation
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: child,
                  ),
                );
              },
              child: _buildLogo(),
            ),
          ),
        ],
      ),
    );
  }

  /// Build the app logo
  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Image.asset(
        AppAssets.appLogo,
        width: 150,
        height: 150,
        errorBuilder: (context, error, stackTrace) {
          // Fallback if logo not found
          return const Icon(
            Icons.menu_book_rounded,
            size: 150,
            color: AppColors.primary,
          );
        },
      ),
    );
  }

  /// Build optional Flame animation background
  Widget _buildFlameBackground() {
    try {
      return GameWidget(game: SplashFlameGame());
    } catch (e) {
      // If Flame fails or assets missing, show gradient background
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.secondary.withOpacity(0.3),
            ],
          ),
        ),
      );
    }
  }
}

/// Simple Flame game for splash screen animation
class SplashFlameGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Add floating particles/stars
    try {
      for (int i = 0; i < 20; i++) {
        add(FloatingParticle(index: i));
      }
    } catch (e) {
      // Fail silently if Flame assets not available
    }
  }
}

/// Floating particle component for splash animation
class FloatingParticle extends PositionComponent with HasGameRef {
  final int index;
  late Vector2 velocity;
  late double opacity;

  FloatingParticle({required this.index});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Random position
    final random = DateTime.now().millisecondsSinceEpoch + index;
    position = Vector2(
      (random % gameRef.size.x.toInt()).toDouble(),
      (random % gameRef.size.y.toInt()).toDouble(),
    );

    // Random velocity
    velocity = Vector2(
      ((random % 100) - 50) / 50,
      ((random % 100) - 50) / 50 - 1, // Upward bias
    );

    opacity = ((random % 70) + 30) / 100;
    size = Vector2.all(4 + (random % 8).toDouble());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += velocity;

    // Wrap around screen
    if (position.y < 0) position.y = gameRef.size.y;
    if (position.y > gameRef.size.y) position.y = 0;
    if (position.x < 0) position.x = gameRef.size.x;
    if (position.x > gameRef.size.x) position.x = 0;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      paint,
    );
  }
}

