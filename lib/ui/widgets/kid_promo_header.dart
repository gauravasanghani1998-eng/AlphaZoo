import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import 'kid_marquee_banner.dart';

/// Colorful promo strip with scrolling text and tap-to-listen speaker.
class KidPromoHeader extends StatefulWidget {
  const KidPromoHeader({
    super.key,
    required this.marqueeText,
    required this.onSpeak,
  });

  final String marqueeText;
  final VoidCallback onSpeak;

  @override
  State<KidPromoHeader> createState() => _KidPromoHeaderState();
}

class _KidPromoHeaderState extends State<KidPromoHeader>
    with TickerProviderStateMixin {
  late AnimationController _shineController;
  late AnimationController _twinkleController;

  @override
  void initState() {
    super.initState();
    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat();
    _twinkleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _shineController.dispose();
    _twinkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.28),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onSpeak,
            child: Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF3BBFB6),
                    Color(0xFF5ED4CC),
                    Color(0xFFFFB347),
                    Color(0xFFFF8FB8),
                  ],
                  stops: [0.0, 0.35, 0.72, 1.0],
                ),
              ),
            ),
            Positioned(top: -18, right: 24, child: _bubble(52, 0.14)),
            Positioned(bottom: -14, left: 40, child: _bubble(36, 0.1)),
            _twinkle(top: 6, right: 14, phase: 0.0, size: 13),
            _twinkle(top: 34, right: 42, phase: 0.35, size: 10),
            _twinkle(bottom: 8, left: 88, phase: 0.62, size: 11),
            AnimatedBuilder(
              animation: _shineController,
              builder: (context, _) {
                return Positioned.fill(
                  child: IgnorePointer(
                  child: Transform.translate(
                    offset: Offset(-120 + (_shineController.value * 420), 0),
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.0),
                            Colors.white.withValues(alpha: 0.22),
                            Colors.white.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 12, 8),
              child: Row(
                children: [
                  _SpeakButton(onTap: widget.onSpeak),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.transparent,
                            Colors.white,
                            Colors.white,
                            Colors.transparent,
                          ],
                          stops: [0.0, 0.1, 0.9, 1.0],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: KidMarqueeBanner(
                        text: widget.marqueeText,
                        height: 46,
                        speed: 46,
                        style: AppTextStyles.bodyBold.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.2,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.18),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.45),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bubble(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity),
      ),
    );
  }

  Widget _twinkle({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double phase,
    required double size,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: AnimatedBuilder(
        animation: _twinkleController,
        builder: (context, _) {
          final t = (_twinkleController.value + phase) % 1.0;
          final wave = math.sin(t * math.pi * 2) * 0.5 + 0.5;
          final opacity = 0.25 + wave * 0.75;
          final scale = 0.8 + wave * 0.35;
          return Transform.scale(
            scale: scale,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: size,
              color: Colors.white.withValues(alpha: opacity),
            ),
          );
        },
      ),
    );
  }
}

class _SpeakButton extends StatefulWidget {
  const _SpeakButton({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_SpeakButton> createState() => _SpeakButtonState();
}

class _SpeakButtonState extends State<_SpeakButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(28),
        child: AnimatedBuilder(
          animation: _pulse,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (_pulse.value * 0.06),
              child: child,
            );
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.volume_up_rounded,
              color: AppColors.primary,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
