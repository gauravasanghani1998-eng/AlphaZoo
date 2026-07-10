import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/family_data.dart';
import '../../utils/learning_detail_content.dart';
import '../../utils/responsive.dart';
import '../models/learning_detail_page.dart';
import '../widgets/kid_learning_tile.dart';
import '../widgets/kid_module_scaffold.dart';
import '../widgets/kid_section_header.dart';
import 'kid_learning_detail_screen.dart';

class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});

  String _name(FamilyItem item) => item.nameKey.tr();

  String _subtitle(FamilyItem item) {
    final text = item.subtitleKey.tr();
    return text == item.subtitleKey ? '' : text;
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;

    return KidModuleScaffold(
      title: 'family.title'.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: '👨‍👩‍👧',
              title: 'family.header'.tr(),
              subtitle: 'family.description'.tr(),
            ),
            const SizedBox(height: 16),
            Builder(
              builder: (context) {
                final items = FamilyData.items;
                final gridCount = items.length - 2;
                final spacing = responsive.gridSpacing;

                Widget tile(int index) {
                  final item = items[index];
                  return KidLearningTile(
                    emoji: item.emoji,
                    label: _name(item),
                    subtitle: _subtitle(item).isNotEmpty
                        ? _subtitle(item)
                        : null,
                    accentColor: AppColors.getLetterColor(index),
                    onTap: () => _openDetail(context, index),
                  );
                }

                return Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: responsive.moduleGridCrossAxisCount,
                        crossAxisSpacing: spacing,
                        mainAxisSpacing: spacing,
                        childAspectRatio: 0.78,
                      ),
                      itemCount: gridCount,
                      itemBuilder: (context, index) => tile(index),
                    ),
                    SizedBox(height: spacing),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 0.78,
                            child: tile(gridCount),
                          ),
                        ),
                        SizedBox(width: spacing),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 0.78,
                            child: tile(gridCount + 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, int index) {
    final pages = FamilyData.items.map((familyItem) {
      final name = familyItem.nameKey.tr();
      final subtitle = _subtitle(familyItem);
      final page = LearningDetailContent.emojiItem(
        emoji: familyItem.emoji,
        nameKey: familyItem.nameKey,
        module: 'family',
        subtitleKey: familyItem.subtitleKey,
      );
      return LearningDetailPage(
        emoji: page.emoji,
        title: page.title,
        subtitle: subtitle.isNotEmpty ? subtitle : page.subtitle,
        speakText: subtitle.isNotEmpty ? '$name. $subtitle' : name,
        about: page.about,
        funFact: page.funFact,
        tryThis: page.tryThis.isNotEmpty
            ? page.tryThis
            : 'family.readTogether'.tr(),
      );
    }).toList();

    final colors = List.generate(
      FamilyData.items.length,
      (i) => AppColors.getLetterColor(i),
    );

    KidLearningDetailScreen.open(
      context,
      moduleTitle: 'family.title'.tr(),
      initialIndex: index,
      pages: pages,
      accentColors: colors,
    );
  }
}
