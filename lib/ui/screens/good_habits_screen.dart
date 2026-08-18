import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/good_habits_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import 'good_habits_category_screen.dart';

/// Hub for Good Habits & Hygiene — colorful category journey cards
/// (not the standard emoji tile grid used by other modules).
class GoodHabitsScreen extends StatelessWidget {
  const GoodHabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;

    return Scaffold(
      backgroundColor: AppColors.goodHabitsHubBg,
      appBar: AppBar(
        backgroundColor: AppColors.goodHabitsHubAppBar,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('goodHabits.title'.tr()),
      ),
      body: Stack(
        children: [
          Positioned(
            top: -40,
            right: -50,
            child: _SoftBlob(
              color: AppColors.habitsHygiene.withValues(alpha: 0.18),
              size: 180,
            ),
          ),
          Positioned(
            bottom: 80,
            left: -60,
            child: _SoftBlob(
              color: AppColors.habitsSchool.withValues(alpha: 0.14),
              size: 160,
            ),
          ),
          Positioned(
            top: 220,
            right: -30,
            child: _SoftBlob(
              color: AppColors.habitsManners.withValues(alpha: 0.1),
              size: 100,
            ),
          ),
          SafeArea(
            child: ListView(
              padding: EdgeInsets.fromLTRB(pad, top, pad, top + 24),
              children: [
                const _HabitsHeroBanner(),
                const SizedBox(height: 20),
                ...List.generate(GoodHabitsData.categories.length, (index) {
                  final cat = GoodHabitsData.categories[index];
                  final color = AppColors.getGoodHabitsCategoryColor(index);
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == GoodHabitsData.categories.length - 1
                          ? 0
                          : 14,
                    ),
                    child: _CategoryJourneyCard(
                      category: cat,
                      accent: color,
                      onTap: () => _openCategory(context, cat),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openCategory(BuildContext context, GoodHabitCategory category) {
    AppHapticFeedback.medium();
    AppSpeech.stop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GoodHabitsCategoryScreen(category: category),
      ),
    );
  }
}

class _HabitsHeroBanner extends StatelessWidget {
  const _HabitsHeroBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.habitsHygiene,
            AppColors.primary,
            AppColors.accent,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.habitsHygiene.withValues(alpha: 0.28),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'goodHabits.starBadge'.tr(),
              style: AppTextStyles.body.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'goodHabits.header'.tr(),
            style: AppTextStyles.heading1.copyWith(
              color: AppColors.white,
              fontSize: 28,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'goodHabits.description'.tr(),
            style: AppTextStyles.body.copyWith(
              color: AppColors.white.withValues(alpha: 0.95),
              fontSize: 15,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryJourneyCard extends StatelessWidget {
  final GoodHabitCategory category;
  final Color accent;
  final VoidCallback onTap;

  const _CategoryJourneyCard({
    required this.category,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final countLabel = 'goodHabits.habitCount'.tr(
      namedArgs: {'count': '${category.habits.length}'},
    );

    // Flutter: borderRadius + non-uniform Border colors = crash.
    // Left accent strip is painted via Stack (not a Row child).
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.14),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          splashColor: accent.withValues(alpha: 0.12),
          highlightColor: accent.withValues(alpha: 0.06),
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: accent.withValues(alpha: 0.35),
                width: 2,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 10,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(22),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 12, 14),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              accent.withValues(alpha: 0.22),
                              accent.withValues(alpha: 0.08),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          category.emoji,
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.titleKey.tr(),
                              style: AppTextStyles.heading3.copyWith(
                                fontSize: 18,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              category.subtitleKey.tr(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.body.copyWith(
                                fontSize: 13,
                                height: 1.3,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: accent.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                countLabel,
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: accent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: accent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SoftBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _SoftBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
