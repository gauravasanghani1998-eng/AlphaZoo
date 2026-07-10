import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/greetings_data.dart';
import '../../utils/learning_detail_content.dart';
import '../../utils/responsive.dart';
import '../models/learning_detail_page.dart';
import '../widgets/kid_learning_tile.dart';
import '../widgets/kid_module_scaffold.dart';
import '../widgets/kid_section_header.dart';
import 'kid_learning_detail_screen.dart';

class GreetingsScreen extends StatelessWidget {
  const GreetingsScreen({super.key});

  String _name(GreetingItem item) => item.nameKey.tr();

  String _subtitle(GreetingItem item) {
    final text = item.subtitleKey.tr();
    return text == item.subtitleKey ? '' : text;
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;

    return KidModuleScaffold(
      title: 'greetings.title'.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: '👋',
              title: 'greetings.header'.tr(),
              subtitle: 'greetings.description'.tr(),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: responsive.moduleGridCrossAxisCount,
                crossAxisSpacing: responsive.gridSpacing,
                mainAxisSpacing: responsive.gridSpacing,
                childAspectRatio: 0.95,
              ),
              itemCount: GreetingsData.items.length,
              itemBuilder: (context, index) {
                final item = GreetingsData.items[index];
                final color = AppColors.getLetterColor(index);
                final name = _name(item);
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
    final pages = GreetingsData.items.map((item) {
      final name = item.nameKey.tr();
      final subtitle = _subtitle(item);
      final base = LearningDetailContent.emojiItem(
        emoji: item.emoji,
        nameKey: item.nameKey,
        module: 'greetings',
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
      GreetingsData.items.length,
      (i) => AppColors.getLetterColor(i),
    );

    KidLearningDetailScreen.open(
      context,
      moduleTitle: 'greetings.title'.tr(),
      initialIndex: index,
      pages: pages,
      accentColors: colors,
    );
  }
}
