import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/numbers_data.dart';
import '../../utils/responsive.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/app_speech.dart';

/// Screen for learning numbers 1–100 with range filters.
class NumbersScreen extends StatefulWidget {
  const NumbersScreen({super.key});

  @override
  State<NumbersScreen> createState() => _NumbersScreenState();
}

class _NumbersScreenState extends State<NumbersScreen> {
  String _selectedRange = '1-26';

  List<NumberItem> get _currentItems {
    switch (_selectedRange) {
      case '27-52':
        return NumbersData.range(27, 52);
      case '53-78':
        return NumbersData.range(53, 78);
      case '79-100':
        return NumbersData.range(79, 100);
      case '1-26':
      default:
        return NumbersData.range(1, 26);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF3D0).withValues(alpha: 0.95),
        elevation: 4,
        shadowColor: Colors.orange.withValues(alpha: 0.2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'numbersTitle'.tr(),
          style: AppTextStyles.heading3.copyWith(color: AppColors.primary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.horizontalPadding,
            vertical: responsive.verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildRangeChips(),
              const SizedBox(height: 20),
              Expanded(child: _buildGrid(responsive)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final responsive = context.responsive;
    final titleSize = (responsive.width * 0.07).clamp(22.0, 30.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'numbersHeader'.tr(),
          style: AppTextStyles.heading1.copyWith(fontSize: titleSize),
        ),
        const SizedBox(height: 8),
        Text(
          'numbersDescription'.tr(),
          style: AppTextStyles.body,
        ),
      ],
    );
  }

  Widget _buildRangeChips() {
    const ranges = ['1-26', '27-52', '53-78', '79-100'];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ranges.map((range) {
        final isSelected = _selectedRange == range;
        return ChoiceChip(
          label: Text(
            range,
            style: AppTextStyles.bodyBold.copyWith(
              color: isSelected ? Colors.white : AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          selected: isSelected,
          selectedColor: AppColors.primary,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected
                  ? AppColors.primary
                  : Colors.orange.withValues(alpha: 0.2),
              width: 2,
            ),
          ),
          onSelected: (_) {
            AppHapticFeedback.light();
            setState(() => _selectedRange = range);
          },
        );
      }).toList(),
    );
  }

  Widget _buildGrid(Responsive responsive) {
    final crossAxisCount = responsive.gridCrossAxisCount;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
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
    );
  }

  void _showNumberDetail(
    BuildContext parentContext,
    int itemIndex,
  ) {
    AppHapticFeedback.medium();

    final items = _currentItems;
    if (itemIndex < 0 || itemIndex >= items.length) return;

    final item = items[itemIndex];
    final color = AppColors.getLetterColor((item.value - 1) % 26);

    final canPrev = itemIndex > 0;
    final canNext = itemIndex < items.length - 1;

    final responsive = parentContext.responsive;
    final bigNumberSize = (responsive.width * 0.18).clamp(40.0, 72.0);
    final wordSize = (responsive.width * 0.09).clamp(20.0, 34.0);

    // Speak the number word when opened.
    AppSpeech.speak(parentContext, item.word);

    showDialog<void>(
      context: parentContext,
      builder: (dialogContext) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withValues(alpha: 0.1),
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: color.withValues(alpha: 0.4),
                    width: 3,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              // Title above circle
                              'numbersTitle'.tr(),
                              style: AppTextStyles.heading3
                                  .copyWith(color: color),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            color: AppColors.textSecondary,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: responsive.width * 0.35,
                        height: responsive.width * 0.35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              color,
                              color.withValues(alpha: 0.7),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: color.withValues(alpha: 0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '${item.value}',
                            style: AppTextStyles.detailLetter.copyWith(
                              fontSize: bigNumberSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        item.word,
                        style: AppTextStyles.word.copyWith(
                          color: color,
                          fontSize: wordSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'numbersDialogExplain'
                            .tr(namedArgs: {'value': '${item.value}'}),
                        style: AppTextStyles.body.copyWith(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'numbersDialogHint'.tr(),
                        style: AppTextStyles.bodyBold.copyWith(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (canPrev)
                            TextButton.icon(
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                                _showNumberDetail(
                                  parentContext,
                                  itemIndex - 1,
                                );
                              },
                              icon: const Icon(Icons.arrow_back_ios_new_rounded),
                              label: Text('nav.previous'.tr()),
                            )
                          else
                            const SizedBox.shrink(),
                          if (canNext)
                            TextButton.icon(
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                                _showNumberDetail(
                                  parentContext,
                                  itemIndex + 1,
                                );
                              },
                              icon:
                                  const Icon(Icons.arrow_forward_ios_rounded),
                              label: Text('nav.next'.tr()),
                            )
                          else
                            const SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
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
                  '${item.value}',
                  style: AppTextStyles.heading2.copyWith(
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.word,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

