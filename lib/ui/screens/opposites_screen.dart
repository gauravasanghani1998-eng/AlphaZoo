import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/opposites_data.dart';
import '../../utils/learning_detail_content.dart';
import '../../utils/responsive.dart';
import '../models/learning_detail_page.dart';
import '../widgets/kid_module_scaffold.dart';
import '../widgets/kid_section_header.dart';
import 'kid_learning_detail_screen.dart';

class OppositesScreen extends StatelessWidget {
  const OppositesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;

    final crossAxisCount = responsive.isMobile ? 1 : 2;

    return KidModuleScaffold(
      title: 'opposites.title'.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: '↔️',
              title: 'opposites.header'.tr(),
              subtitle: 'opposites.description'.tr(),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: responsive.gridSpacing,
                mainAxisSpacing: responsive.gridSpacing,
                childAspectRatio: crossAxisCount == 1 ? 1.55 : 1.35,
              ),
              itemCount: OppositesData.pairs.length,
              itemBuilder: (context, index) {
                final pair = OppositesData.pairs[index];
                final color = AppColors.getLetterColor(index);
                final left = pair.leftKey.tr();
                final right = pair.rightKey.tr();

                return GestureDetector(
                  onTap: () => _openDetail(context, index, responsive),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(responsive.cardRadius),
                      border: Border.all(
                        color: color.withValues(alpha: 0.45),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _sideColumn(
                            emoji: pair.leftEmoji,
                            label: left,
                            emojiSize: 67,
                            color: color,
                            alignEnd: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'opposites.vs'.tr(),
                              style: AppTextStyles.caption.copyWith(
                                fontWeight: FontWeight.bold,
                                color: color,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: _sideColumn(
                            emoji: pair.rightEmoji,
                            label: right,
                            emojiSize: 67,
                            color: color,
                            alignEnd: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _sideColumn({
    required String emoji,
    required String label,
    required double emojiSize,
    required Color color,
    required bool alignEnd,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:CrossAxisAlignment.center,
      children: [
        Text(emoji, style: TextStyle(fontSize: emojiSize)),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: AppTextStyles.bodyBold.copyWith(
              fontSize: 16,
              color: AppColors.textPrimary,
              height: 1.15,
            ),
            textAlign: alignEnd ? TextAlign.right : TextAlign.left,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  void _openDetail(BuildContext context, int index, Responsive responsive) {
    final lang = Localizations.localeOf(context).languageCode;
    final compact = LearningDetailContent.compactOppositesLayout(lang);
    final bigEmoji = LearningDetailContent.oppositeHeroEmojiSize(
      responsive.width,
      lang,
    );
    final pages = OppositesData.pairs.asMap().entries.map((entry) {
      final pair = entry.value;
      final i = entry.key;
      final keys = OppositePairKeys(pair.leftKey, pair.rightKey);
      final color = AppColors.getLetterColor(i);
      final base = LearningDetailContent.oppositePair(
        leftEmoji: pair.leftEmoji,
        rightEmoji: pair.rightEmoji,
        leftKey: pair.leftKey,
        rightKey: pair.rightKey,
        pairId: keys.id,
      );
      return LearningDetailPage(
        title: base.title,
        subtitle: base.subtitle,
        speakText: base.speakText,
        about: base.about,
        funFact: base.funFact,
        tryThis: base.tryThis,
        heroInCircle: base.heroInCircle,
        oppositePairLayout: base.oppositePairLayout,
        hero: LearningDetailContent.oppositeHero(
          leftEmoji: pair.leftEmoji,
          rightEmoji: pair.rightEmoji,
          color: color,
          emojiSize: bigEmoji,
          compact: compact,
        ),
      );
    }).toList();

    final colors = List.generate(
      OppositesData.pairs.length,
      (i) => AppColors.getLetterColor(i),
    );

    KidLearningDetailScreen.open(
      context,
      moduleTitle: 'opposites.title'.tr(),
      initialIndex: index,
      pages: pages,
      accentColors: colors,
    );
  }
}
