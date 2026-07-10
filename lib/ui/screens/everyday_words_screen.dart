import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/everyday_words_data.dart';
import '../../utils/learning_detail_content.dart';
import '../../utils/responsive.dart';
import '../widgets/kid_module_scaffold.dart';
import 'kid_learning_detail_screen.dart';
import '../widgets/kid_pill_selector.dart';
import '../widgets/kid_section_header.dart';

class EverydayWordsScreen extends StatefulWidget {
  const EverydayWordsScreen({
    super.key,
    this.initialTab = 'days',
    this.showTabs = true,
  });

  final String initialTab;
  final bool showTabs;

  @override
  State<EverydayWordsScreen> createState() => _EverydayWordsScreenState();
}

class _EverydayWordsScreenState extends State<EverydayWordsScreen> {
  late String _tab;

  String _wordLabel(WordItem item) => item.nameKey?.tr() ?? item.text;

  @override
  void initState() {
    super.initState();
    const allowed = ['days', 'months'];
    _tab = allowed.contains(widget.initialTab) ? widget.initialTab : 'days';
  }

  List<WordItem> _itemsFor(BuildContext context) {
    switch (_tab) {
      case 'months':
        return EverydayWordsData.monthsForLocale(context.locale.languageCode);
      case 'days':
      default:
        return EverydayWordsData.days;
    }
  }

  String _sectionKey(String field) => '$_tab.$field'.tr();

  String _title(BuildContext context) => _sectionKey('title');

  String _description(BuildContext context) => _sectionKey('description');

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;
    final titleText = _title(context);
    final items = _itemsFor(context);

    return KidModuleScaffold(
      title: titleText,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: _tab == 'days' ? '📅' : '🗓️',
              title: titleText,
              subtitle: _description(context),
            ),
            if (widget.showTabs) ...[
              const SizedBox(height: 14),
              KidPillSelector(
                labels: [
                  '📅 ${'days.title'.tr()}',
                  '🗓️ ${'months.title'.tr()}',
                ],
                selectedIndex: _tab == 'days' ? 0 : 1,
                onSelected: (index) =>
                    setState(() => _tab = index == 0 ? 'days' : 'months'),
              ),
            ],
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: responsive.moduleGridCrossAxisCount,
                crossAxisSpacing: responsive.gridSpacing,
                mainAxisSpacing: responsive.gridSpacing,
                childAspectRatio: 1.2,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final color = AppColors.getLetterColor(index);

                return GestureDetector(
                  onTap: () => _openDetail(context, index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(responsive.cardRadius),
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
                            if (item.imageAsset != null) ...[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  item.imageAsset!,
                                  width: 52,
                                  height: 52,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const SizedBox.shrink(),
                                ),
                              ),
                              const SizedBox(height: 6),
                            ],
                            Text(
                              _wordLabel(item),
                              style: AppTextStyles.bodyBold.copyWith(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
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

  void _openDetail(BuildContext context, int index) {
    final fallbackEmoji = _tab == 'days' ? '📅' : '🗓️';
    final items = _itemsFor(context);
    final pages = items.map((item) {
      final label = _wordLabel(item);
      final id = item.nameKey != null
          ? item.nameKey!.split('.').last
          : label.toLowerCase();
      return LearningDetailContent.wordLabel(
        label: label,
        module: _tab,
        itemId: id,
        emoji: fallbackEmoji,
        imageAsset: item.imageAsset,
      );
    }).toList();

    final colors = List.generate(
      items.length,
      (i) => AppColors.getLetterColor(i),
    );

    KidLearningDetailScreen.open(
      context,
      moduleTitle: _title(context),
      initialIndex: index,
      pages: pages,
      accentColors: colors,
    );
  }
}
