import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/good_habits_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import 'good_habits_detail_screen.dart';

class GoodHabitsCategoryScreen extends StatelessWidget {
  final GoodHabitCategory category;

  const GoodHabitsCategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final catIndex = GoodHabitsData.categories.indexOf(category);
    final accent = AppColors.getGoodHabitsCategoryColor(catIndex);
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;

    return Scaffold(
      backgroundColor: Color.lerp(AppColors.white, accent, 0.06),
      appBar: AppBar(
        backgroundColor: Color.lerp(AppColors.white, accent, 0.12),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(category.titleKey.tr()),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(pad, 16, pad, 28),
        children: [
          _CategoryIntro(
            emoji: category.emoji,
            title: category.titleKey.tr(),
            subtitle: category.subtitleKey.tr(),
            hint: 'goodHabits.listHint'.tr(),
            accent: accent,
            count: category.habits.length,
          ),
          const SizedBox(height: 18),
          ...List.generate(category.habits.length, (index) {
            final habit = category.habits[index];
            final itemAccent = AppColors.goodHabitsPageAccent(
              categoryAccent: accent,
              habitIndex: index,
            );
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _HabitListRow(
                number: index + 1,
                title: habit.nameKey.tr(),
                accent: itemAccent,
                onTap: () => _openDetail(context, category, index, accent),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _openDetail(
    BuildContext context,
    GoodHabitCategory category,
    int index,
    Color accent,
  ) {
    AppHapticFeedback.medium();
    AppSpeech.stop();
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondary) => GoodHabitsDetailScreen(
          category: category,
          initialIndex: index,
          accentColor: accent,
        ),
        transitionsBuilder: (context, animation, secondary, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 320),
      ),
    );
  }
}

class _CategoryIntro extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String hint;
  final Color accent;
  final int count;

  const _CategoryIntro({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.hint,
    required this.accent,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent.withValues(alpha: 0.18),
            accent.withValues(alpha: 0.05),
            AppColors.white,
          ],
        ),
        border: Border.all(color: accent.withValues(alpha: 0.3), width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.heading3.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 14,
                    height: 1.35,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  hint,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'goodHabits.habitCount'.tr(
                    namedArgs: {'count': '$count'},
                  ),
                  style: AppTextStyles.body.copyWith(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HabitListRow extends StatelessWidget {
  final int number;
  final String title;
  final Color accent;
  final VoidCallback onTap;

  const _HabitListRow({
    required this.number,
    required this.title,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: accent.withValues(alpha: 0.22),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [accent, accent.withValues(alpha: 0.75)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$number',
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.25,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: accent.withValues(alpha: 0.85),
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
