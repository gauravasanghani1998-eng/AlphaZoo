import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/indian_festivals_data.dart';
import '../../utils/learning_detail_content.dart';
import '../../utils/responsive.dart';
import '../models/learning_detail_page.dart';
import '../widgets/kid_learning_tile.dart';
import '../widgets/kid_module_scaffold.dart';
import '../widgets/kid_section_header.dart';
import 'kid_learning_detail_screen.dart';

/// Indian festivals — tap to hear and learn about each celebration.
class IndianFestivalsScreen extends StatelessWidget {
  const IndianFestivalsScreen({super.key});

  String _subtitle(IndianFestivalItem item) {
    final text = item.subtitleKey.tr();
    return text == item.subtitleKey ? '' : text;
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;
    final items = IndianFestivalsData.items;

    return KidModuleScaffold(
      title: 'indianFestivals.title'.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: '🪔',
              title: 'indianFestivals.header'.tr(),
              subtitle: 'indianFestivals.description'.tr(),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: responsive.moduleGridCrossAxisCount,
                crossAxisSpacing: responsive.gridSpacing,
                mainAxisSpacing: responsive.gridSpacing,
                childAspectRatio: 0.88,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final color = AppColors.getLetterColor(index);
                final name = item.nameKey.tr();
                final subtitle = _subtitle(item);

                return KidLearningTile(
                  emoji: item.emoji,
                  label: name,
                  subtitle: subtitle.isNotEmpty ? subtitle : null,
                  accentColor: color,
                  onTap: () => _openDetail(context, index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, int index) {
    final items = IndianFestivalsData.items;
    final pages = items.map((item) {
      final name = item.nameKey.tr();
      final subtitle = _subtitle(item);
      final base = LearningDetailContent.emojiItem(
        emoji: item.emoji,
        nameKey: item.nameKey,
        module: 'indianFestivals',
        subtitleKey: item.subtitleKey,
      );
      return LearningDetailPage(
        emoji: base.emoji,
        title: base.title,
        subtitle: subtitle.isNotEmpty ? subtitle : base.subtitle,
        speakText: name,
        about: base.about,
        funFact: base.funFact,
        tryThis: base.tryThis,
      );
    }).toList();

    final colors = List.generate(
      items.length,
      (i) => AppColors.getLetterColor(i),
    );

    KidLearningDetailScreen.open(
      context,
      moduleTitle: 'indianFestivals.title'.tr(),
      initialIndex: index,
      pages: pages,
      accentColors: colors,
    );
  }
}
