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
import 'math_logic_category_screen.dart';

class MathLogicScreen extends StatelessWidget {
  const MathLogicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;

    return KidModuleScaffold(
      title: 'mathLogic.title'.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: '🧮',
              title: 'mathLogic.header'.tr(),
              subtitle: 'mathLogic.playSubtitle'.tr(),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: responsive.isMobile ? 2 : 3,
                crossAxisSpacing: responsive.gridSpacing + 4,
                mainAxisSpacing: responsive.gridSpacing + 4,
                childAspectRatio: 0.84,
              ),
              itemCount: MathLogicData.categories.length,
              itemBuilder: (context, index) {
                final cat = MathLogicData.categories[index];
                final color = AppColors.getLetterColor(index);
                return KidLearningTile(
                  emoji: cat.emoji,
                  label: cat.titleKey.tr(),
                  subtitle:
                      '${cat.subtitleKey.tr()} · ${'mathLogic.activityCount'.tr(
                    namedArgs: {
                      'count': MathLogicDigits.format(
                        context,
                        cat.activities.length,
                      ),
                    },
                  )}',
                  accentColor: color,
                  onTap: () => _openCategory(context, cat.id),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openCategory(BuildContext context, MathCategoryId id) {
    AppHapticFeedback.medium();
    AppSpeech.stop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MathLogicCategoryScreen(categoryId: id),
      ),
    );
  }
}
