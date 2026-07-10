import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/shapes_colors_data.dart';
import '../../utils/learning_detail_content.dart';
import '../../utils/responsive.dart';
import '../models/learning_detail_page.dart';
import '../widgets/kid_module_scaffold.dart';
import '../widgets/kid_pill_selector.dart';
import '../widgets/kid_section_header.dart';
import 'kid_learning_detail_screen.dart';

class ShapesColorsScreen extends StatefulWidget {
  const ShapesColorsScreen({super.key});

  @override
  State<ShapesColorsScreen> createState() => _ShapesColorsScreenState();
}

class _ShapesColorsScreenState extends State<ShapesColorsScreen> {
  String _tab = 'shapes';

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;

    final crossAxisCount = responsive.moduleGridCrossAxisCount;
    final isShapes = _tab == 'shapes';
    final itemCount = isShapes
        ? ShapesColorsData.shapes.length
        : ShapesColorsData.colors.length;

    return KidModuleScaffold(
      title: 'shapes.header'.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: isShapes ? '⬛' : '🎨',
              title: 'shapes.header'.tr(),
              subtitle: isShapes
                  ? 'shapes.tapShape'.tr()
                  : 'shapes.tapColor'.tr(),
            ),
            const SizedBox(height: 14),
            KidPillSelector(
              labels: [
                '⬛ ${'shapes.tabShapes'.tr()}',
                '🎨 ${'shapes.tabColors'.tr()}',
              ],
              selectedIndex: isShapes ? 0 : 1,
              onSelected: (index) =>
                  setState(() => _tab = index == 0 ? 'shapes' : 'colors'),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: responsive.gridSpacing,
                mainAxisSpacing: responsive.gridSpacing,
                childAspectRatio: 1.0,
              ),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (isShapes) {
                  final item = ShapesColorsData.shapes[index];
                  final color = AppColors.getLetterColor(index);
                  final localizedName = item.nameKey.tr();

                  return GestureDetector(
                    onTap: () => _openShapeDetail(context, index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: color.withValues(alpha: 0.4),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.emoji,
                                style: const TextStyle(fontSize: 55),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                localizedName,
                                style: AppTextStyles.bodyBold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                final item = ShapesColorsData.colors[index];
                final localizedName = item.nameKey.tr();
                final accentColor = AppColors.getLetterColor(index);

                return GestureDetector(
                  onTap: () => _openColorDetail(context, index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: accentColor.withValues(alpha: 0.4),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withValues(alpha: 0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: item.color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: item.color.computeLuminance() > 0.85
                                      ? Colors.grey.shade400
                                      : Colors.white,
                                  width: 3,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              localizedName,
                              style: AppTextStyles.bodyBold,
                            ),
                          ],
                        ),
                      ),
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

  void _openShapeDetail(BuildContext context, int index) {
    final pages = ShapesColorsData.shapes.map((item) {
      final name = item.nameKey.tr();
      final id = item.nameKey.split('.').last;
      final base = LearningDetailContent.wordLabel(
        label: name,
        module: 'shapes',
        itemId: id,
        emoji: item.emoji,
      );
      final fallbackAbout =
          'shapes.shapeMessage'.tr(namedArgs: {'name': name});
      return LearningDetailPage(
        emoji: item.emoji,
        title: base.title,
        speakText: name,
        about: base.about.isNotEmpty ? base.about : fallbackAbout,
        funFact: base.funFact,
        tryThis: base.tryThis,
      );
    }).toList();

    final colors = List.generate(
      ShapesColorsData.shapes.length,
      (i) => AppColors.getLetterColor(i),
    );

    KidLearningDetailScreen.open(
      context,
      moduleTitle: 'shapes.header'.tr(),
      initialIndex: index,
      pages: pages,
      accentColors: colors,
    );
  }

  void _openColorDetail(BuildContext context, int index) {
    final pages = ShapesColorsData.colors.map((item) {
      final name = item.nameKey.tr();
      final id = item.nameKey.split('.').last;
      final base = LearningDetailContent.wordLabel(
        label: name,
        module: 'shapes',
        itemId: id,
        emoji: '🎨',
      );
      final fallbackAbout =
          'shapes.colorMessage'.tr(namedArgs: {'name': name});
      return LearningDetailPage(
        title: base.title,
        speakText: name,
        about: base.about.isNotEmpty ? base.about : fallbackAbout,
        funFact: base.funFact,
        tryThis: base.tryThis,
        hero: LearningDetailContent.colorHero(item.color),
      );
    }).toList();

    final colors = List.generate(
      ShapesColorsData.colors.length,
      (i) => AppColors.getLetterColor(i),
    );

    KidLearningDetailScreen.open(
      context,
      moduleTitle: 'shapes.header'.tr(),
      initialIndex: index,
      pages: pages,
      accentColors: colors,
    );
  }
}
