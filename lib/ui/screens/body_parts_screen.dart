import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../data/body_parts_data.dart';
import '../../utils/learning_detail_content.dart';
import '../../utils/responsive.dart';
import '../widgets/kid_learning_tile.dart';
import '../widgets/kid_module_scaffold.dart';
import '../widgets/kid_section_header.dart';
import 'kid_learning_detail_screen.dart';

class BodyPartsScreen extends StatelessWidget {
  const BodyPartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;

    return KidModuleScaffold(
      title: 'bodyParts.title'.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: '🧒',
              title: 'bodyParts.header'.tr(),
              subtitle: 'bodyParts.description'.tr(),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: responsive.moduleGridCrossAxisCount,
                crossAxisSpacing: responsive.gridSpacing,
                mainAxisSpacing: responsive.gridSpacing,
                childAspectRatio: 0.92,
              ),
              itemCount: BodyPartsData.items.length,
              itemBuilder: (context, index) {
                final item = BodyPartsData.items[index];
                final color = AppColors.getLetterColor(index);
                final name = item.nameKey.tr();

                return KidLearningTile(
                  emoji: item.emoji,
                  imageAsset: item.imageAsset,
                  label: name,
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
    final pages = BodyPartsData.items
        .map(
          (item) => LearningDetailContent.emojiItem(
            emoji: item.emoji,
            imageAsset: item.imageAsset,
            nameKey: item.nameKey,
            module: 'bodyParts',
          ),
        )
        .toList();
    final colors = List.generate(
      BodyPartsData.items.length,
      (i) => AppColors.getLetterColor(i),
    );

    KidLearningDetailScreen.open(
      context,
      moduleTitle: 'bodyParts.title'.tr(),
      initialIndex: index,
      pages: pages,
      accentColors: colors,
    );
  }
}
