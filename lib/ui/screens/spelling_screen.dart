import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/spelling_data.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../../utils/app_speech.dart';

/// Screen for learning spelling with simple categories.
class SpellingScreen extends StatefulWidget {
  const SpellingScreen({super.key});

  @override
  State<SpellingScreen> createState() => _SpellingScreenState();
}

class _SpellingScreenState extends State<SpellingScreen> {
  String _selectedCategory = 'animals';

  List<SpellingItem> get _items =>
      SpellingData.byCategory(_selectedCategory.toLowerCase());

  String _localizedWord(SpellingItem item) {
    final baseKey =
        'spelling.word.${item.word.toLowerCase().replaceAll(' ', '_')}';
    final translated = baseKey.tr();
    return translated == baseKey ? item.word : translated;
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
          'spellingTitle'.tr(),
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
              Text(
                'spellingHeader'.tr(),
                style: AppTextStyles.heading1.copyWith(
                  fontSize:
                      (responsive.width * 0.07).clamp(22.0, 30.0),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'spellingDescription'.tr(),
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 16),
              _buildCategoryChips(),
              const SizedBox(height: 20),
              Expanded(child: _buildGrid(responsive)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    final labels = {
      'animals': '🐾 ${'spelling.animals'.tr()}',
      'fruits': '🍎 ${'spelling.fruits'.tr()}',
      'colors': '🎨 ${'spelling.colors'.tr()}',
      'body': '👋 ${'spelling.body'.tr()}',
      'nature': '🌳 ${'spelling.nature'.tr()}',
    };

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: SpellingData.categories.map((category) {
        final isSelected = _selectedCategory == category;
        final label = labels[category] ?? category;
        return ChoiceChip(
          label: Text(
            label,
            style: AppTextStyles.bodyBold.copyWith(
              color: isSelected ? Colors.white : AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          selected: isSelected,
          selectedColor: AppColors.secondary,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected
                  ? AppColors.secondary
                  : Colors.purple.withValues(alpha: 0.2),
              width: 2,
            ),
          ),
          onSelected: (_) {
            AppHapticFeedback.light();
            setState(() => _selectedCategory = category);
          },
        );
      }).toList(),
    );
  }

  Widget _buildGrid(Responsive responsive) {
    final crossAxisCount = responsive.gridCrossAxisCount.clamp(2, 4);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
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
          onTap: () => _showDetail(item, color),
        );
      },
    );
  }

  void _showDetail(SpellingItem item, Color color) {
    AppHapticFeedback.medium();

    final letters = item.word.toUpperCase().split('');

    // Speak the word when the detail opens.
    AppSpeech.speak(context, item.word);

    showDialog<void>(
      context: context,
      builder: (context) {
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
                      color.withValues(alpha: 0.15),
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
                              _localizedWord(item),
                              style:
                                  AppTextStyles.heading3.copyWith(color: color),
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
                      const SizedBox(height: 12),
                      Text(
                        item.emoji,
                        style: TextStyle(
                          fontSize:
                              (context.responsive.width * 0.14).clamp(36.0, 64.0),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: letters
                            .map(
                              (letter) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: color.withValues(alpha: 0.7),
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  letter,
                                  style: AppTextStyles.heading2.copyWith(
                                    color: color,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'spellingSpellTogether'.tr(),
                        style: AppTextStyles.body.copyWith(fontSize: 16),
                        textAlign: TextAlign.center,
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
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(height: 8),
                Text(
                  item.word,
                  style: AppTextStyles.bodyBold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

