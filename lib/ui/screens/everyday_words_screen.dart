import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/everyday_words_data.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/responsive.dart';
import '../../utils/app_speech.dart';

/// Screen for Days, Months, Family and Greetings.
class EverydayWordsScreen extends StatefulWidget {
  const EverydayWordsScreen({
    super.key,
    this.initialTab = 'days',
    this.showTabs = true,
  });

  /// Which section to show first: 'days', 'months', 'family', or 'greetings'.
  final String initialTab;
  /// Whether to show the tabs to switch between sections.
  final bool showTabs;

  @override
  State<EverydayWordsScreen> createState() => _EverydayWordsScreenState();
}

class _EverydayWordsScreenState extends State<EverydayWordsScreen> {
  late String _tab; // days, months, family, greetings

  @override
  void initState() {
    super.initState();
    // Ensure initial tab is one of the supported keys.
    const allowed = ['days', 'months', 'family', 'greetings'];
    _tab = allowed.contains(widget.initialTab) ? widget.initialTab : 'days';
  }

  List<WordItem> get _items {
    switch (_tab) {
      case 'months':
        return EverydayWordsData.months;
      case 'family':
        return EverydayWordsData.family;
      case 'greetings':
        return EverydayWordsData.greetings;
      case 'days':
      default:
        return EverydayWordsData.days;
    }
  }

  String _title(BuildContext context) {
    switch (_tab) {
      case 'months':
        return 'monthsOfYear'.tr();
      case 'family':
        return 'familyMembers'.tr();
      case 'greetings':
        return 'greetingsPolite'.tr();
      case 'days':
      default:
        return 'daysOfWeek'.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    final titleText = _title(context);

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
          titleText,
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
                titleText,
                style: AppTextStyles.heading1.copyWith(
                  fontSize:
                      (responsive.width * 0.07).clamp(22.0, 30.0),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'everydayDescription'.tr(),
                style: AppTextStyles.body,
              ),
              if (widget.showTabs) ...[
                const SizedBox(height: 16),
                _buildTabs(),
                const SizedBox(height: 20),
              ] else
                const SizedBox(height: 16),
              Expanded(child: _buildGrid(responsive)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    Widget tab(String key, String label, IconData icon) {
      final isSelected = _tab == key;
      final color = AppColors.getLetterColor(key.hashCode);

      return GestureDetector(
        onTap: () {
          if (_tab == key) return;
          AppHapticFeedback.light();
          setState(() => _tab = key);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: color.withValues(alpha: 0.7),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : color,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.bodyBold.copyWith(
                  color: isSelected ? Colors.white : color,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        tab('days', 'daysOfWeek'.tr(), Icons.calendar_today_rounded),
        tab('months', 'monthsOfYear'.tr(), Icons.date_range_rounded),
        tab('family', 'familyMembers'.tr(), Icons.family_restroom_rounded),
        tab('greetings', 'greetingsPolite'.tr(),
            Icons.emoji_people_rounded),
      ],
    );
  }

  Widget _buildGrid(Responsive responsive) {
    // Use at most 3 columns so tiles stay large and readable.
    final crossAxisCount = responsive.gridCrossAxisCount.clamp(2, 3);

    final wordFontSize =
        (responsive.width * 0.045).clamp(16.0, 20.0); // bigger main text
    final subtitleFontSize =
        (responsive.width * 0.035).clamp(13.0, 16.0); // subtitle size

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: responsive.gridSpacing,
        mainAxisSpacing: responsive.gridSpacing,
        childAspectRatio: 1.2,
      ),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        final color = AppColors.getLetterColor(index);

        return GestureDetector(
          onTap: () => _showWordDetail(item, color),
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
                    if (item.emoji != null) ...[
                      Text(
                        item.emoji!,
                        style: TextStyle(
                          fontSize:
                              (responsive.width * 0.08).clamp(22.0, 32.0),
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    Text(
                      item.text,
                      style: AppTextStyles.bodyBold.copyWith(
                        fontSize: wordFontSize,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (item.subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle!,
                        style: AppTextStyles.caption.copyWith(
                          fontSize: subtitleFontSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showWordDetail(WordItem item, Color color) {
    AppHapticFeedback.medium();

    final responsive = context.responsive;
    final titleSize = (responsive.width * 0.09).clamp(20.0, 30.0);

    // Speak localized word (and English helper if available).
    final spoken = item.subtitle == null
        ? item.text
        : '${item.text}. ${item.subtitle!}';
    AppSpeech.speak(context, spoken);

    showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
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
                              item.text,
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
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (item.emoji != null) ...[
                            Text(
                              item.emoji!,
                              style: TextStyle(
                                fontSize: (responsive.width * 0.12)
                                    .clamp(36.0, 64.0),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                          Text(
                            item.text,
                            style: AppTextStyles.word.copyWith(
                              color: color,
                              fontSize: titleSize,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      if (item.subtitle != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          item.subtitle!,
                          style: AppTextStyles.body,
                          textAlign: TextAlign.center,
                        ),
                      ],
                      const SizedBox(height: 12),
                      Text(
                        'everyday.readTogether'.tr(),
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