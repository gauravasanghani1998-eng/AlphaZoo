import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/math_logic_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/math_logic_digits.dart';
import '../../utils/responsive.dart';
import '../widgets/kid_learning_tile.dart';
import '../widgets/kid_module_scaffold.dart';
import '../widgets/kid_section_header.dart';
import 'math_logic_game_screen.dart';

class MathLogicCategoryScreen extends StatelessWidget {
  final MathCategoryId categoryId;

  const MathLogicCategoryScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final category = MathLogicData.category(categoryId);
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;

    return KidModuleScaffold(
      title: category.titleKey.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: category.emoji,
              title: category.titleKey.tr(),
              subtitle: category.subtitleKey.tr(),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: responsive.isMobile ? 2 : 3,
                crossAxisSpacing: responsive.gridSpacing,
                mainAxisSpacing: responsive.gridSpacing,
                childAspectRatio: 0.95,
              ),
              itemCount: category.activities.length,
              itemBuilder: (context, index) {
                final activityId = category.activities[index];
                final info = MathLogicData.activityInfo(activityId);
                final color = AppColors.getLetterColor(index);
                return KidLearningTile(
                  emoji: info.emoji,
                  label: info.titleKey.tr(),
                  subtitle: 'mathLogic.questionCount'.tr(
                    namedArgs: {
                      'count': MathLogicDigits.format(
                        context,
                        MathLogicData.questionCountFor(activityId),
                      ),
                    },
                  ),
                  accentColor: color,
                  onTap: () => _openActivity(context, activityId, color),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openActivity(
    BuildContext context,
    MathActivityId activityId,
    Color accent,
  ) {
    AppHapticFeedback.medium();
    AppSpeech.stop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MathLogicGameScreen(
          activityId: activityId,
          accentColor: accent,
        ),
      ),
    );
  }
}
