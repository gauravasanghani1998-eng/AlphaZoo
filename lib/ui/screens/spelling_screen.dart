import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/spelling_data.dart';
import '../../utils/learning_detail_content.dart';
import '../../utils/responsive.dart';
import '../models/learning_detail_page.dart';
import '../widgets/kid_module_scaffold.dart';
import '../widgets/kid_pill_selector.dart';
import '../widgets/kid_section_header.dart';
import 'kid_learning_detail_screen.dart';

class SpellingScreen extends StatefulWidget {
  const SpellingScreen({super.key});

  @override
  State<SpellingScreen> createState() => _SpellingScreenState();
}

class _SpellingScreenState extends State<SpellingScreen> {
  String _selectedCategory = 'animals';

  List<SpellingItem> get _items =>
      SpellingData.byCategory(_selectedCategory.toLowerCase());

  String _wordLabel(SpellingItem item) => item.nameKey.tr();

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;

    final categoryLabels = {
      'animals': '🐾 ${'spelling.categoryLabels.animals'.tr()}',
      'birds': '🐦 ${'spelling.categoryLabels.birds'.tr()}',
      'seaAnimals': '🐠 ${'spelling.categoryLabels.seaAnimals'.tr()}',
      'fruits': '🍎 ${'spelling.categoryLabels.fruits'.tr()}',
      'vegetables': '🥕 ${'spelling.categoryLabels.vegetables'.tr()}',
      'flowers': '🌸 ${'spelling.categoryLabels.flowers'.tr()}',
      'nature': '🌍 ${'spelling.categoryLabels.nature'.tr()}',
    };
    final categories = SpellingData.categories;
    final selectedIndex = categories.indexOf(_selectedCategory);

    return KidModuleScaffold(
      title: 'spelling.title'.tr(),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: '✏️',
              title: 'spelling.header'.tr(),
              subtitle: 'spelling.description'.tr(),
            ),
            const SizedBox(height: 14),
            KidScrollPillSelector(
              labels: categories
                  .map((c) => categoryLabels[c] ?? c)
                  .toList(),
              selectedIndex: selectedIndex < 0 ? 0 : selectedIndex,
              onSelected: (index) =>
                  setState(() => _selectedCategory = categories[index]),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: responsive.moduleGridCrossAxisCount,
                crossAxisSpacing: responsive.gridSpacing,
                mainAxisSpacing: responsive.gridSpacing,
                childAspectRatio: 1.1,
              ),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                final color = AppColors.getLetterColor(index);

                return _SpellingCard(
                  item: item,
                  color: color,
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
    final pages = _items.asMap().entries.map((entry) {
      final item = entry.value;
      final i = entry.key;
      final color = AppColors.getLetterColor(i);
      final label = _wordLabel(item);
      final base = LearningDetailContent.spellingItem(
        emoji: item.emoji,
        nameKey: item.nameKey,
        category: item.category,
      );
      return LearningDetailPage(
        emoji: item.emoji,
        title: base.title,
        speakText: label,
        about: base.about,
        funFact: base.funFact,
        tryThis: base.tryThis.isNotEmpty
            ? base.tryThis
            : 'spelling.spellTogether'.tr(),
        extraSections: LearningDetailContent.spellingLetterSection(
          label,
          color,
        ),
      );
    }).toList();

    final colors = List.generate(
      _items.length,
      (i) => AppColors.getLetterColor(i),
    );

    KidLearningDetailScreen.open(
      context,
      moduleTitle: 'spelling.title'.tr(),
      initialIndex: index,
      pages: pages,
      accentColors: colors,
    );
  }
}

class _SpellingCard extends StatelessWidget {
  final SpellingItem item;
  final Color color;
  final VoidCallback onTap;

  const _SpellingCard({
    required this.item,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                Text(
                  item.nameKey.tr(),
                  style: AppTextStyles.bodyBold,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
