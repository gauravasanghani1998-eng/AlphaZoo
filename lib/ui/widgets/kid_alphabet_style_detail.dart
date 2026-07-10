import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/learning_detail_content.dart';
import '../../utils/responsive.dart';

class KidAlphabetStyleDetail {
  KidAlphabetStyleDetail._();

  static const Color creamBackground = Color(0xFFFFF8E1);
  static const Color navBarGradientTop = Color(0xFFFFFBF0);
  static const Color navBarGradientBottom = Color(0xFFFFF9E6);

  static PreferredSizeWidget appBar({
    required bool isScrolled,
    required Color accentColor,
    required String title,
    required VoidCallback onBack,
  }) {
    return AppBar(
      backgroundColor: isScrolled
          ? accentColor.withValues(alpha: 0.9)
          : AppColors.appBarTint,
      elevation: isScrolled ? 6 : 2,
      shadowColor: isScrolled
          ? accentColor.withValues(alpha: 0.3)
          : Colors.orange.withValues(alpha: 0.1),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: isScrolled ? Colors.white : accentColor,
        ),
        onPressed: onBack,
      ),
      title: Text(
        title,
        style: AppTextStyles.heading3.copyWith(
          color: isScrolled ? Colors.white : accentColor,
        ),
      ),
      centerTitle: true,
    );
  }

  static Widget listenAgainButton({
    required Color accentColor,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            AppHapticFeedback.light();
            onPressed();
          },
          borderRadius: BorderRadius.circular(28),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accentColor, accentColor.withValues(alpha: 0.82)],
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.volume_up_rounded,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
                const SizedBox(width: 14),
                Flexible(
                  child: Text(
                    'learningDetail.tapToHear'.tr(),
                    style: AppTextStyles.button.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget progress({
    required Color accentColor,
    required int currentIndex,
    required int totalCount,
  }) {
    final progress = (currentIndex + 1) / totalCount;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor.withValues(alpha: 0.1),
            accentColor.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: accentColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.emoji_events_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'learningDetail.progress'.tr(namedArgs: {
                      'current': '${currentIndex + 1}',
                      'total': '$totalCount',
                    }),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${currentIndex + 1}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: accentColor.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            ),
          ),
        ],
      ),
    );
  }

  static Widget encouragement({
    required Color accentColor,
    required String message,
    VoidCallback? onSpeak,
  }) {
    final banner = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            accentColor.withValues(alpha: 0.8),
            accentColor,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: onSpeak != null
            ? Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 1.5,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star_rounded, color: Colors.white, size: 24),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (onSpeak != null) ...[
            const SizedBox(width: 8),
            Icon(
              Icons.volume_up_rounded,
              color: Colors.white.withValues(alpha: 0.9),
              size: 20,
            ),
          ],
          const SizedBox(width: 8),
          const Icon(Icons.star_rounded, color: Colors.white, size: 24),
        ],
      ),
    );

    if (onSpeak == null) return banner;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          AppHapticFeedback.light();
          onSpeak();
        },
        borderRadius: BorderRadius.circular(16),
        child: banner,
      ),
    );
  }

  static Widget heartDivider(Color accentColor) {
    return Row(
      children: [
        Expanded(child: _gradientLine(accentColor, fadeEnd: true)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.favorite, color: accentColor, size: 16),
          ),
        ),
        Expanded(child: _gradientLine(accentColor, fadeEnd: false)),
      ],
    );
  }

  static Widget _gradientLine(Color accentColor, {required bool fadeEnd}) {
    return Container(
      height: 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: fadeEnd
              ? [
                  Colors.transparent,
                  accentColor.withValues(alpha: 0.5),
                  accentColor,
                ]
              : [
                  accentColor,
                  accentColor.withValues(alpha: 0.5),
                  Colors.transparent,
                ],
        ),
      ),
    );
  }

  static Widget circleHero({
    required Color accentColor,
    required Widget child,
    double size = 185,
    String? heroTag,
  }) {
    final circle = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor,
            accentColor.withValues(alpha: 0.7),
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(child: child),
    );

    if (heroTag != null) {
      return Hero(tag: heroTag, child: circle);
    }
    return circle;
  }

  static String sectionSpeakText(String title, String body) {
    final t = title.trim();
    final b = body.trim();
    if (t.isEmpty) return b;
    if (b.isEmpty) return t;
    return '$t. $b';
  }

  static Widget speakHintIcon(Color accentColor) => _speakHintIcon(accentColor);

  static Widget _speakHintIcon(Color accentColor) {
    return Icon(
      Icons.volume_up_rounded,
      size: 20,
      color: accentColor.withValues(alpha: 0.7),
    );
  }

  static Widget titleText({
    required String text,
    required Color accentColor,
    double fontSize = 34,
    VoidCallback? onSpeak,
  }) {
    final label = Text(
      text,
      style: AppTextStyles.word.copyWith(
        color: accentColor,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );

    if (onSpeak == null) return label;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          AppHapticFeedback.light();
          onSpeak();
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: label),
              const SizedBox(width: 8),
              _speakHintIcon(accentColor),
            ],
          ),
        ),
      ),
    );
  }

  static Widget subtitleText(String text) {
    return Text(
      text,
      style: AppTextStyles.bodyBold.copyWith(
        fontSize: 20,
        color: AppColors.textSecondary,
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Opposites: Hot — vs — Cold (matches grid cards, not one cramped circle).
  static Widget oppositeTitleRow({
    required BuildContext context,
    required String left,
    required String right,
    required Color accentColor,
    VoidCallback? onSpeakLeft,
    VoidCallback? onSpeakRight,
  }) {
    final compact = LearningDetailContent.compactOppositesLayoutFrom(context);
    final wordSize = compact ? 24.0 : 28.0;
    final vsHPad = compact ? 8.0 : 10.0;
    final vsFont = compact ? 13.0 : 14.0;

    Widget wordChip(String word, VoidCallback? onSpeak) {
      final text = FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          word,
          style: AppTextStyles.word.copyWith(
            color: accentColor,
            fontSize: wordSize,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      );

      if (onSpeak == null) {
        return Flexible(child: text);
      }

      return Flexible(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              AppHapticFeedback.light();
              onSpeak();
            },
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  text,
                  const SizedBox(height: 4),
                  _speakHintIcon(accentColor),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          wordChip(left, onSpeakLeft),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: vsHPad),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? 8 : 10,
                vertical: compact ? 4 : 6,
              ),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'opposites.vs'.tr(),
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                    fontSize: vsFont,
                  ),
                ),
              ),
            ),
          ),
          wordChip(right, onSpeakRight),
        ],
      ),
    );
  }

  static Widget aboutCard({
    required Color accentColor,
    required String title,
    required String body,
    IconData icon = Icons.menu_book_rounded,
    VoidCallback? onSpeak,
  }) {
    return _contentCard(
      accentColor: accentColor,
      title: title,
      body: body,
      icon: icon,
      gradientColors: const [Colors.white, Color(0xFFFFFBF0)],
      borderColor: Colors.orange.withValues(alpha: 0.2),
      onSpeak: onSpeak,
    );
  }

  static Widget funFactCard({
    required Color accentColor,
    required String title,
    required String body,
    IconData icon = Icons.emoji_objects_rounded,
    VoidCallback? onSpeak,
  }) {
    return _contentCard(
      accentColor: accentColor,
      title: title,
      body: body,
      icon: icon,
      gradientColors: const [Color(0xFFFFF9E6), AppColors.appBarTint],
      borderColor: Colors.orange.withValues(alpha: 0.25),
      onSpeak: onSpeak,
    );
  }

  static Widget tryCard({
    required Color accentColor,
    required String title,
    required String body,
    VoidCallback? onSpeak,
  }) {
    return _contentCard(
      accentColor: accentColor,
      title: title,
      body: body,
      icon: Icons.touch_app_rounded,
      gradientColors: const [Colors.white, Color(0xFFFFFBF0)],
      borderColor: accentColor.withValues(alpha: 0.25),
      onSpeak: onSpeak,
    );
  }

  static Widget _contentCard({
    required Color accentColor,
    required String title,
    required String body,
    required IconData icon,
    required List<Color> gradientColors,
    required Color borderColor,
    VoidCallback? onSpeak,
  }) {
    final card = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: onSpeak != null
              ? accentColor.withValues(alpha: 0.45)
              : borderColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: accentColor, size: 22),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  title,
                  style: AppTextStyles.bodyBold.copyWith(
                    fontSize: 18,
                    color: accentColor,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (onSpeak != null) ...[
                const SizedBox(width: 8),
                _speakHintIcon(accentColor),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: AppTextStyles.body.copyWith(
              fontSize: 16,
              height: 1.6,
              color: const Color(0xFF424242),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    if (onSpeak == null) return card;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          AppHapticFeedback.light();
          onSpeak();
        },
        borderRadius: BorderRadius.circular(20),
        child: card,
      ),
    );
  }

  static Widget infoChip({
    required Color accentColor,
    required String label,
    IconData? icon,
    VoidCallback? onSpeak,
    bool expandWidth = false,
  }) {
    final chip = Container(
      width: expandWidth ? double.infinity : null,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accentColor.withValues(alpha: 0.2),
            accentColor.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: onSpeak != null
            ? Border.all(
                color: accentColor.withValues(alpha: 0.45),
                width: 1.5,
              )
            : null,
      ),
      child: Row(
        mainAxisSize:
            expandWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: accentColor, size: 18),
            const SizedBox(width: 8),
          ],
          if (expandWidth)
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: accentColor,
                  height: 1.35,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          else
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: accentColor,
              ),
            ),
          if (onSpeak != null) ...[
            const SizedBox(width: 8),
            speakHintIcon(accentColor),
          ],
        ],
      ),
    );

    if (onSpeak == null) return chip;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          AppHapticFeedback.light();
          onSpeak();
        },
        borderRadius: BorderRadius.circular(20),
        child: chip,
      ),
    );
  }

  /// 2–3 example words in separate tappable chips (alphabet detail style).
  static Widget exampleWordsSection({
    required Color accentColor,
    required String title,
    required List<String> words,
    void Function(String word)? onSpeakWord,
  }) {
    if (words.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xFFFFFBF0)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.28),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_awesome_rounded, color: accentColor, size: 20),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  style: AppTextStyles.bodyBold.copyWith(
                    fontSize: 16,
                    color: accentColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: words.map((word) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onSpeakWord == null
                      ? null
                      : () {
                          AppHapticFeedback.light();
                          onSpeakWord(word);
                        },
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          accentColor.withValues(alpha: 0.18),
                          accentColor.withValues(alpha: 0.08),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: accentColor.withValues(alpha: 0.45),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          word,
                          style: AppTextStyles.bodyBold.copyWith(
                            fontSize: 16,
                            color: accentColor,
                          ),
                        ),
                        if (onSpeakWord != null) ...[
                          const SizedBox(width: 6),
                          speakHintIcon(accentColor),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  static Widget navigationBar({
    required Responsive responsive,
    required Color accentColor,
    required bool canPrevious,
    required bool canNext,
    required VoidCallback? onPrevious,
    required VoidCallback? onNext,
    Animation<double>? scaleAnimation,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.horizontalPadding,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [navBarGradientTop, navBarGradientBottom],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: navButton(
              label: 'nav.previous'.tr(),
              icon: Icons.arrow_back_ios_new_rounded,
              accentColor: accentColor,
              enabled: canPrevious,
              isNext: false,
              onTap: onPrevious,
              scaleAnimation: scaleAnimation,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: navButton(
              label: 'nav.next'.tr(),
              icon: Icons.arrow_forward_ios_rounded,
              accentColor: accentColor,
              enabled: canNext,
              isNext: true,
              onTap: onNext,
              scaleAnimation: scaleAnimation,
            ),
          ),
        ],
      ),
    );
  }

  static Widget navButton({
    required String label,
    required IconData icon,
    required Color accentColor,
    required bool enabled,
    required bool isNext,
    required VoidCallback? onTap,
    Animation<double>? scaleAnimation,
  }) {
    Widget button = Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        gradient: enabled
            ? LinearGradient(
                colors: [accentColor, accentColor.withValues(alpha: 0.8)],
              )
            : null,
        color: enabled ? null : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16),
        boxShadow: enabled
            ? [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isNext) Icon(icon, color: Colors.white, size: 20),
          if (!isNext) const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.button.copyWith(
              color: enabled ? Colors.white : Colors.grey.shade600,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (isNext) const SizedBox(width: 8),
          if (isNext) Icon(icon, color: Colors.white, size: 20),
        ],
      ),
    );

    if (scaleAnimation != null) {
      button = AnimatedBuilder(
        animation: scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 - (scaleAnimation.value * 0.1),
            child: child,
          );
        },
        child: button,
      );
    }

    return GestureDetector(
      onTap: enabled
          ? () {
              AppHapticFeedback.medium();
              onTap?.call();
            }
          : null,
      child: button,
    );
  }
}
