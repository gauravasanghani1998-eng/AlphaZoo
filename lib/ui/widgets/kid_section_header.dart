import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../utils/responsive.dart';

class KidSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? emoji;

  const KidSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final titleSize = (responsive.width * 0.065).clamp(22.0, 30.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.14),
            AppColors.accent.withValues(alpha: 0.1),
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(responsive.cardRadius),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.28),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (emoji != null) ...[
            Text(emoji!, style: const TextStyle(fontSize: 36)),
            const SizedBox(height: 6),
          ],
          Text(
            title,
            style: AppTextStyles.heading1.copyWith(fontSize: titleSize),
          ),
          if (subtitle != null && subtitle!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              style: AppTextStyles.body.copyWith(
                fontSize: 16,
                height: 1.35,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
