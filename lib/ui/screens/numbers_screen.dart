import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/numbers_data.dart';
import '../../utils/app_speech.dart';
import '../../utils/learning_detail_content.dart';
import '../../utils/number_detail_content.dart';
import '../../utils/responsive.dart';
import '../widgets/kid_alphabet_style_detail.dart';
import '../widgets/kid_module_scaffold.dart';
import 'kid_learning_detail_screen.dart';
import '../widgets/kid_pill_selector.dart';
import '../widgets/kid_section_header.dart';

class NumbersScreen extends StatefulWidget {
  const NumbersScreen({super.key});

  @override
  State<NumbersScreen> createState() => _NumbersScreenState();
}

class _NumberRange {
  final int start;
  final int end;

  const _NumberRange(this.start, this.end);
}

class _NumbersScreenState extends State<NumbersScreen> {
  static const _ranges = <_NumberRange>[
    _NumberRange(1, 26),
    _NumberRange(27, 52),
    _NumberRange(53, 78),
    _NumberRange(79, 100),
  ];

  int _selectedRangeIndex = 0;

  List<NumberItem> get _currentItems {
    final range = _ranges[_selectedRangeIndex];
    return NumbersData.range(range.start, range.end);
  }

  String get _glyphs => NumbersData.glyphsKey.tr();

  String get _fullRangeLabel =>
      NumbersData.formatDigitRange(1, 100, _glyphs);

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.horizontalPadding;
    final top = responsive.verticalPadding;
    final rangeLabel = _fullRangeLabel;

    return KidModuleScaffold(
      title: 'numbers.title'.tr(namedArgs: {'range': rangeLabel}),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(pad, top, pad, top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KidSectionHeader(
              emoji: '🔢',
              title: 'numbers.header'.tr(namedArgs: {'range': rangeLabel}),
              subtitle: 'numbers.description'.tr(),
            ),
            const SizedBox(height: 16),
            KidPillSelector(
              labels: _ranges
                  .map((r) =>
                      NumbersData.formatDigitRange(r.start, r.end, _glyphs))
                  .toList(),
              selectedIndex: _selectedRangeIndex,
              onSelected: (index) =>
                  setState(() => _selectedRangeIndex = index),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: responsive.gridCrossAxisCount,
                crossAxisSpacing: responsive.gridSpacing,
                mainAxisSpacing: responsive.gridSpacing,
                childAspectRatio: 1.0,
              ),
              itemCount: _currentItems.length,
              itemBuilder: (context, index) {
                final item = _currentItems[index];
                final color = AppColors.getLetterColor((item.value - 1) % 26);

                return _NumberCard(
                  item: item,
                  color: color,
                  onTap: () => _showNumberDetail(context, index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showNumberDetail(BuildContext context, int itemIndex) {
    final items = _currentItems;
    if (itemIndex < 0 || itemIndex >= items.length) return;

    final glyphs = _glyphs;
    final letterSize = (context.responsive.width * 0.2).clamp(52.0, 76.0);

    final pages = items.map((item) {
      final color = AppColors.getLetterColor((item.value - 1) % 26);
      final digit = NumbersData.formatDigits(item.value, glyphs);
      final word = item.nameKey.tr();
      return LearningDetailContent.numberItem(
        value: item.value,
        digitText: digit,
        word: word,
        accentColor: color,
        heroFontSize: letterSize,
        extraSections: [_numberTraitRow(item.value, color)],
      );
    }).toList();

    final colors = items
        .map((item) => AppColors.getLetterColor((item.value - 1) % 26))
        .toList();

    KidLearningDetailScreen.open(
      context,
      moduleTitle: 'numbers.title'.tr(namedArgs: {'range': _fullRangeLabel}),
      initialIndex: itemIndex,
      pages: pages,
      accentColors: colors,
    );
  }

  Widget _numberTraitRow(int value, Color color) {
    final even = NumberDetailContent.isEven(value);
    final isRound = NumberDetailContent.isRoundTen(value);
    final oddEvenLabel =
        even ? 'numbers.detail.even'.tr() : 'numbers.detail.odd'.tr();
    final roundLabel = 'numbers.detail.roundTenBadge'.tr();

    return Column(
      children: [
        KidAlphabetStyleDetail.infoChip(
          accentColor: color,
          label: oddEvenLabel,
          expandWidth: true,
          onSpeak: () => AppSpeech.speak(context, oddEvenLabel),
        ),
        if (isRound) ...[
          const SizedBox(height: 8),
          KidAlphabetStyleDetail.infoChip(
            accentColor: color,
            icon: Icons.star_rounded,
            label: roundLabel,
            expandWidth: true,
            onSpeak: () => AppSpeech.speak(context, roundLabel),
          ),
        ],
      ],
    );
  }
}

class _NumberCard extends StatelessWidget {
  final NumberItem item;
  final Color color;
  final VoidCallback onTap;

  const _NumberCard({
    required this.item,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                color.withValues(alpha: 0.12),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: color.withValues(alpha: 0.45),
              width: 2.5,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.22),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  NumbersData.formatDigits(
                    item.value,
                    NumbersData.glyphsKey.tr(),
                  ),
                  style: AppTextStyles.heading2.copyWith(
                    color: color,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.nameKey.tr(),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
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
