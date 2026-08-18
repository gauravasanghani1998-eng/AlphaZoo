import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/community_helpers_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import 'community_helpers_detail_screen.dart';

/// Neighborhood-style helper list — not the standard module grid.
class CommunityHelpersScreen extends StatelessWidget {
  const CommunityHelpersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;

    return Scaffold(
      backgroundColor: AppColors.helpersHubBg,
      appBar: AppBar(
        backgroundColor: AppColors.helpersHubAppBar,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('communityHelpers.title'.tr()),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(pad, 12, pad, 28),
        children: [
          const _HelpersTownBanner(),
          const SizedBox(height: 22),
          ...List.generate(CommunityHelpersData.items.length, (index) {
            final item = CommunityHelpersData.items[index];
            final accent = AppColors.helpersAccent(index);
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _HelperPathCard(
                emoji: item.emoji,
                name: item.nameKey.tr(),
                subtitle: item.subtitleKey.tr(),
                accent: accent,
                onTap: () => _openDetail(context, index),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _openDetail(BuildContext context, int index) {
    AppHapticFeedback.medium();
    AppSpeech.stop();
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondary) =>
            CommunityHelpersDetailScreen(initialIndex: index),
        transitionsBuilder: (context, animation, secondary, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.08),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 340),
      ),
    );
  }
}

class _HelpersTownBanner extends StatelessWidget {
  const _HelpersTownBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2BAFA6),
            Color(0xFF5BB8C8),
            Color(0xFFFFB74D),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2BAFA6).withValues(alpha: 0.28),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.95),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 3),
                ),
                alignment: Alignment.center,
                child: const Text('🏘️', style: TextStyle(fontSize: 30)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'communityHelpers.header'.tr(),
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.white,
                        fontSize: 22,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'communityHelpers.listHint'.tr(),
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.white.withValues(alpha: 0.95),
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              'communityHelpers.description'.tr(),
              style: AppTextStyles.caption.copyWith(
                color: AppColors.white,
                fontSize: 13,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HelperPathCard extends StatelessWidget {
  final String emoji;
  final String name;
  final String subtitle;
  final Color accent;
  final VoidCallback onTap;

  const _HelperPathCard({
    required this.emoji,
    required this.name,
    required this.subtitle,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          decoration: BoxDecoration(
            color: Color.alphaBlend(
              accent.withValues(alpha: 0.07),
              AppColors.white,
            ),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: accent, width: 1),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.14),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            child: Row(
              children: [
                _HelperAvatar(emoji: emoji, accent: accent),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTextStyles.heading3.copyWith(
                          fontSize: 18,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          subtitle,
                          style: AppTextStyles.caption.copyWith(
                            color: accent,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.chevron_right_rounded, color: accent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HelperAvatar extends StatelessWidget {
  final String emoji;
  final Color accent;

  const _HelperAvatar({
    required this.emoji,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent.withValues(alpha: 0.25),
            accent.withValues(alpha: 0.08),
          ],
        ),
        border: Border.all(
          color: accent.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: Text(emoji, style: const TextStyle(fontSize: 34)),
    );
  }
}
