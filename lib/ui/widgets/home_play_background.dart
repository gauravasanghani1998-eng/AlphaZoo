import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

/// Calm sky-style home background — soft gradient, blurred color glows.
class HomePlayBackground extends StatelessWidget {
  final Widget child;

  const HomePlayBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const _HomeSkyGradient(),
        const _HomeSoftHills(),
        const _HomeGlowOrbs(),
        child,
      ],
    );
  }
}

/// Warm cream → mint wash (matches app theme, not flat beige).
class _HomeSkyGradient extends StatelessWidget {
  const _HomeSkyGradient();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFFCF7),
            Color(0xFFEEF9F8),
            Color(0xFFFFF6EE),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}

/// Gentle hills at the bottom — playful but not busy.
class _HomeSoftHills extends StatelessWidget {
  const _HomeSoftHills();

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 140,
      child: CustomPaint(painter: _HillsPainter()),
    );
  }
}

class _HillsPainter extends CustomPainter {
  const _HillsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final back = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    final front = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;

    final backPath = Path()
      ..moveTo(0, size.height * 0.55)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.2,
        size.width * 0.55,
        size.height * 0.45,
      )
      ..quadraticBezierTo(
        size.width * 0.85,
        size.height * 0.7,
        size.width,
        size.height * 0.4,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final frontPath = Path()
      ..moveTo(0, size.height * 0.72)
      ..quadraticBezierTo(
        size.width * 0.35,
        size.height * 0.45,
        size.width * 0.7,
        size.height * 0.62,
      )
      ..quadraticBezierTo(
        size.width * 0.95,
        size.height * 0.78,
        size.width,
        size.height * 0.58,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(backPath, back);
    canvas.drawPath(frontPath, front);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Blurred color spots — soft depth without emoji clutter.
class _HomeGlowOrbs extends StatelessWidget {
  const _HomeGlowOrbs();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -60,
            right: -40,
            child: _glowOrb(AppColors.accent.withValues(alpha: 0.35), 160),
          ),
          Positioned(
            top: 100,
            left: -70,
            child: _glowOrb(AppColors.secondary.withValues(alpha: 0.22), 140),
          ),
          Positioned(
            top: 280,
            right: -50,
            child: _glowOrb(AppColors.primary.withValues(alpha: 0.28), 130),
          ),
          Positioned(
            bottom: 100,
            left: 20,
            child: _glowOrb(AppColors.accent.withValues(alpha: 0.18), 100),
          ),
        ],
      ),
    );
  }

  Widget _glowOrb(Color color, double size) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 48, sigmaY: 48),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
