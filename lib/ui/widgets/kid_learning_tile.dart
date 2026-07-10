import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';

/// Large tap target: emoji + label on a soft gradient card.
class KidLearningTile extends StatelessWidget {
  final String emoji;
  final String label;
  final String? subtitle;
  final String? imageAsset;
  final Color accentColor;
  final VoidCallback onTap;

  const KidLearningTile({
    super.key,
    required this.emoji,
    required this.label,
    this.subtitle,
    this.imageAsset,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final hasSubtitle = subtitle != null && subtitle!.isNotEmpty;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          AppHapticFeedback.light();
          onTap();
        },
        borderRadius: BorderRadius.circular(responsive.cardRadius),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                accentColor.withValues(alpha: 0.08),
              ],
            ),
            borderRadius: BorderRadius.circular(responsive.cardRadius),
            border: Border.all(
              color: accentColor.withValues(alpha: 0.45),
              width: 2.5,
            ),
            boxShadow: [
              BoxShadow(
                color: accentColor.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxH = constraints.maxHeight;
                final emojiSize = hasSubtitle
                    ? (maxH * 0.30).clamp(32.0, 42.0)
                    : (maxH * 0.45).clamp(44.0, 55.0);
                final labelSize = (maxH * 0.10).clamp(13.0, 15.0);
                final subtitleSize = (maxH * 0.075).clamp(9.5, 11.0);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildVisual(emojiSize),
                    SizedBox(height: hasSubtitle ? 6 : 8),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            label,
                            style: AppTextStyles.bodyBold.copyWith(
                              fontSize: labelSize,
                              color: AppColors.textPrimary,
                              height: 1.15,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (hasSubtitle) ...[
                            const SizedBox(height: 4),
                            Text(
                              subtitle!,
                              style: AppTextStyles.caption.copyWith(
                                fontSize: subtitleSize,
                                color: AppColors.textSecondary,
                                height: 1.15,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVisual(double emojiSize) {
    final asset = imageAsset;
    if (asset == null || asset.isEmpty) {
      return Text(emoji, style: TextStyle(fontSize: emojiSize));
    }

    final imageSize = emojiSize * 1.35;
    return SizedBox(
      width: imageSize,
      height: imageSize,
      child: Image.asset(
        asset,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        gaplessPlayback: true,
        errorBuilder: (_, __, ___) =>
            Text(emoji, style: TextStyle(fontSize: emojiSize)),
      ),
    );
  }
}
