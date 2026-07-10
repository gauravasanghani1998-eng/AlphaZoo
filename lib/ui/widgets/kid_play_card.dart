import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';

class KidPlayCard extends StatelessWidget {
  final String emoji;
  final String? imageAsset;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const KidPlayCard({
    super.key,
    required this.emoji,
    this.imageAsset,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final radius = responsive.cardRadius;

    return SizedBox.expand(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            AppHapticFeedback.medium();
            onTap();
          },
          borderRadius: BorderRadius.circular(radius),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: color.withValues(alpha: 0.42),
                width: 1.7,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius - 1),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _CardVisual(emoji: emoji, imageAsset: imageAsset),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.08),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.22),
                        ],
                        stops: const [0.0, 0.58, 1.0],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyBold.copyWith(
                          fontSize: 15,
                          color: AppColors.textPrimary,
                          height: 1.15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardVisual extends StatelessWidget {
  final String emoji;
  final String? imageAsset;

  const _CardVisual({required this.emoji, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    if (imageAsset == null || imageAsset!.isEmpty) {
      return ColoredBox(
        color: Colors.white,
        child: Center(child: Text(emoji, style: const TextStyle(fontSize: 52))),
      );
    }

    return Image.asset(
      imageAsset!,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      errorBuilder: (_, __, ___) {
        return ColoredBox(
          color: Colors.white,
          child: Center(child: Text(emoji, style: const TextStyle(fontSize: 48))),
        );
      },
    );
  }
}
