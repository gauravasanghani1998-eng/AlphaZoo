import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../../data/math_logic_data.dart';
import '../../utils/haptic_feedback.dart';
import '../../utils/math_logic_colors.dart';
import '../../utils/math_logic_digits.dart';
import '../../utils/responsive.dart';
import 'kid_alphabet_style_detail.dart';

/// Kid-friendly play area widgets for Math & Logic games.
class MathPlayUi {
  MathPlayUi._();

  static const successGreen = Color(0xFF43B56B);
  static const wrongRed = Color(0xFFE53935);

  static Color get _correctOptionBg =>
      Color.lerp(Colors.white, successGreen, 0.14)!;

  static Color get _wrongOptionBg => Color.lerp(Colors.white, wrongRed, 0.14)!;

  /// Green / red styling when a tap target is picked (compare groups, odd one out).
  static ({
    Color background,
    Color border,
    List<BoxShadow> shadows,
  }) selectionStyle({
    required Color accent,
    required bool isSelected,
    required bool isCorrectPick,
  }) {
    var bg = Colors.white;
    var border = accent.withValues(alpha: 0.32);
    var shadows = <BoxShadow>[
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ];

    if (isSelected && isCorrectPick) {
      bg = _correctOptionBg;
      border = successGreen.withValues(alpha: 0.65);
      shadows = [
        BoxShadow(
          color: successGreen.withValues(alpha: 0.22),
          blurRadius: 12,
          offset: const Offset(0, 5),
        ),
      ];
    } else if (isSelected && !isCorrectPick) {
      bg = _wrongOptionBg;
      border = wrongRed.withValues(alpha: 0.65);
      shadows = [
        BoxShadow(
          color: wrongRed.withValues(alpha: 0.22),
          blurRadius: 12,
          offset: const Offset(0, 5),
        ),
      ];
    }

    return (background: bg, border: border, shadows: shadows);
  }

  static Widget sessionProgress({
    required BuildContext context,
    required int currentRound,
    required int totalRounds,
    required Color accent,
    required bool sessionComplete,
  }) {
    final progress = sessionComplete ? 1.0 : currentRound / totalRounds;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withValues(alpha: 0.22), width: 1.5),
      ),
      child: Column(
        children: [
          if (totalRounds <= 10)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalRounds, (i) {
                final done = sessionComplete || i < currentRound;
                final active = !sessionComplete && i == currentRound - 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: active ? 24 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: done
                          ? accent
                          : active
                              ? accent.withValues(alpha: 0.55)
                              : accent.withValues(alpha: 0.14),
                    ),
                  ),
                );
              }),
            )
          else
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: accent.withValues(alpha: 0.12),
                valueColor: AlwaysStoppedAnimation<Color>(accent),
              ),
            ),
          const SizedBox(height: 8),
          Text(
            sessionComplete
                ? 'mathLogic.games.allDone'.tr()
                : 'mathLogic.games.roundProgress'.tr(
                    namedArgs: {
                      'current': MathLogicDigits.format(context, currentRound),
                      'total': MathLogicDigits.format(context, totalRounds),
                    },
                  ),
            style: AppTextStyles.bodyBold.copyWith(
              fontSize: 14,
              color: sessionComplete ? successGreen : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  static Widget playCard({
    required Color accent,
    required Widget child,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -8,
          right: 20,
          child: _decorBubble(accent, 14),
        ),
        Positioned(
          bottom: 28,
          left: -6,
          child: _decorBubble(accent.withValues(alpha: 0.45), 10),
        ),
        Positioned(
          top: 48,
          left: -10,
          child: _decorBubble(AppColors.accent.withValues(alpha: 0.35), 8),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                accent.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: accent.withValues(alpha: 0.38), width: 2.5),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.16),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    gradient: LinearGradient(
                      colors: [
                        accent.withValues(alpha: 0.25),
                        accent,
                        accent.withValues(alpha: 0.25),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
                child: child,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _decorBubble(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.22),
        shape: BoxShape.circle,
      ),
    );
  }

  static Widget instructionBanner({
    required String text,
    required VoidCallback onSpeak,
    required bool showSuccess,
    required String successText,
    required bool showFinish,
    required String finishText,
    required Color accent,
  }) {
    final isFinish = showFinish;
    final isSuccess = showSuccess && !isFinish;
    final border = isFinish || isSuccess ? successGreen : accent;
    final message = isFinish ? finishText : isSuccess ? successText : text;
    final canSpeak = !isFinish && !isSuccess;
    final emoji = isFinish ? '🏆' : isSuccess ? '⭐' : '💡';

    final banner = AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: isFinish
            ? successGreen.withValues(alpha: 0.1)
            : isSuccess
                ? successGreen.withValues(alpha: 0.08)
                : Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: border.withValues(alpha: 0.42), width: 2),
        boxShadow: [
          BoxShadow(
            color: border.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (isFinish || isSuccess ? successGreen : accent)
                  .withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodyBold.copyWith(
                fontSize: 16,
                color: AppColors.textPrimary,
                height: 1.35,
              ),
            ),
          ),
          if (canSpeak)
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.volume_up_rounded,
                color: accent,
                size: 22,
              ),
            ),
        ],
      ),
    );

    if (!canSpeak) return banner;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          AppHapticFeedback.light();
          onSpeak();
        },
        borderRadius: BorderRadius.circular(22),
        child: banner,
      ),
    );
  }

  static Widget emojiGrid({
    required String emoji,
    required int count,
    double size = 40,
    Color? accent,
  }) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: List.generate(
        count,
        (i) {
          final tileColor = accent != null
              ? MathLogicColors.shift(accent, i)
              : MathLogicColors.safePalette[
                  i % MathLogicColors.safePalette.length];
          return Container(
            width: size + 18,
            height: size + 18,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: tileColor.withValues(alpha: 0.42),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: tileColor.withValues(alpha: 0.14),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(emoji, style: TextStyle(fontSize: size)),
          );
        },
      ),
    );
  }

  static Widget numberPair({
    required String left,
    required String right,
    required String symbol,
    required Color accent,
  }) {
    final leftColor = accent;
    final rightColor = MathLogicColors.shift(accent, 2);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _bigNumberChip(left, leftColor),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Text(
              symbol,
              style: AppTextStyles.heading2.copyWith(
                fontSize: 28,
                color: accent,
              ),
            ),
          ),
        ),
        _bigNumberChip(right, rightColor),
      ],
    );
  }

  static Widget _bigNumberChip(String value, Color color) {
    return Container(
      width: value.runes.length >= 3 ? 96 : 76,
      height: 76,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.48), width: 2.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.14),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        value,
        style: _numberTextStyle(
          fontSize: value.runes.length >= 3 ? 30 : 36,
          color: color,
        ),
      ),
    );
  }

  /// Public single-number spotlight (double-it, next/prev count, …).
  static Widget numberChip(String value, Color color) =>
      _bigNumberChip(value, color);

  /// Fredoka lacks Indic digits — Baloo 2 keeps १ / ८ / ૮ readable.
  static TextStyle _numberTextStyle({
    required double fontSize,
    required Color color,
  }) {
    return AppTextStyles.bodyBold.copyWith(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.w800,
      height: 1.05,
      letterSpacing: 0.5,
    );
  }

  static bool _sequenceNeedsWideLayout(List<String> parts) {
    return parts.any((part) => part != '__' && part.runes.length > 3);
  }

  static double _sequenceFontSize(String part, bool isBlank) {
    if (isBlank) return 24;
    final len = part.runes.length;
    if (len <= 2) return 24;
    if (len <= 6) return 18;
    if (len <= 10) return 16;
    return 14;
  }

  static Widget _sequenceChip({
    required String part,
    required int index,
    required Color accent,
    required bool wide,
  }) {
    final isBlank = part == '__';
    final chipColor =
        isBlank ? accent : MathLogicColors.shift(accent, index + 1);
    final fontSize = _sequenceFontSize(part, isBlank);

    final label = Text(
      isBlank ? '?' : part,
      maxLines: 1,
      softWrap: false,
      textAlign: TextAlign.center,
      style: _numberTextStyle(
        fontSize: fontSize,
        color: isBlank ? accent : AppColors.textPrimary,
      ),
    );

    return Container(
      height: 54,
      constraints: BoxConstraints(
        minWidth: isBlank ? 48 : (wide ? 56 : 40),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: wide ? 10 : 12,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isBlank ? accent.withValues(alpha: 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: chipColor.withValues(alpha: isBlank ? 0.65 : 0.42),
          width: 2.5,
        ),
        boxShadow: isBlank
            ? null
            : [
                BoxShadow(
                  color: chipColor.withValues(alpha: 0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: label,
    );
  }

  static Widget sequenceRow(List<String> parts, {required Color accent}) {
    final wide = _sequenceNeedsWideLayout(parts);

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: wide ? 8 : 10,
      runSpacing: 10,
      children: parts.asMap().entries.map((entry) {
        return IntrinsicWidth(
          child: _sequenceChip(
            part: entry.value,
            index: entry.key,
            accent: accent,
            wide: wide,
          ),
        );
      }).toList(),
    );
  }

  static Widget optionButtons({
    required List<String> labels,
    required bool answered,
    required int? selectedIndex,
    required int? correctIndex,
    required ValueChanged<int> onPick,
    required Color accent,
  }) {
    final buttons = List.generate(labels.length, (index) {
      return _optionButton(
        label: labels[index],
        index: index,
        answered: answered,
        selectedIndex: selectedIndex,
        correctIndex: correctIndex,
        onPick: onPick,
        accent: accent,
        fullWidth: labels.length <= 4,
      );
    });

    if (labels.length <= 4) {
      return Column(
        children: [
          for (var i = 0; i < buttons.length; i++) ...[
            buttons[i],
            if (i < buttons.length - 1) const SizedBox(height: 12),
          ],
        ],
      );
    }

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: buttons,
    );
  }

  static Widget _optionButton({
    required String label,
    required int index,
    required bool answered,
    required int? selectedIndex,
    required int? correctIndex,
    required ValueChanged<int> onPick,
    required Color accent,
    required bool fullWidth,
  }) {
    final isSelected = selectedIndex == index;
    final isCorrectPick = correctIndex != null && index == correctIndex;
    final isCorrect = isCorrectPick && (answered || isSelected);
    final isWrong = isSelected && !isCorrectPick;

    Color bg = Colors.white;
    Color border = accent.withValues(alpha: 0.32);
    List<BoxShadow> shadows = [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ];

    if (isCorrect) {
      bg = _correctOptionBg;
      border = successGreen.withValues(alpha: 0.65);
      shadows = [
        BoxShadow(
          color: successGreen.withValues(alpha: 0.22),
          blurRadius: 12,
          offset: const Offset(0, 5),
        ),
      ];
    } else if (isWrong) {
      bg = _wrongOptionBg;
      border = wrongRed.withValues(alpha: 0.65);
      shadows = [
        BoxShadow(
          color: wrongRed.withValues(alpha: 0.22),
          blurRadius: 12,
          offset: const Offset(0, 5),
        ),
      ];
    }

    final button = GestureDetector(
      onTap: answered ? null : () => onPick(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        width: fullWidth ? double.infinity : null,
        constraints: BoxConstraints(
          minWidth: fullWidth ? double.infinity : 88,
          minHeight: 58,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: border, width: 2.5),
          boxShadow: shadows,
        ),
        child: Center(
          child: Text(
            label,
            style: _numberTextStyle(
              fontSize: label.length <= 2 ? 30 : 24,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );

    return button;
  }

  static Widget roundNavigationBar({
    required Responsive responsive,
    required Color accent,
    required bool canPrevious,
    required bool canNext,
    required VoidCallback? onPrevious,
    required VoidCallback? onNext,
    required bool showFinishLabel,
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
          colors: [
            KidAlphabetStyleDetail.navBarGradientTop,
            KidAlphabetStyleDetail.navBarGradientBottom,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: KidAlphabetStyleDetail.navButton(
              label: 'nav.previous'.tr(),
              icon: Icons.arrow_back_ios_new_rounded,
              accentColor: accent,
              enabled: canPrevious,
              isNext: false,
              onTap: onPrevious,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: KidAlphabetStyleDetail.navButton(
              label: showFinishLabel
                  ? 'mathLogic.games.finish'.tr()
                  : 'nav.next'.tr(),
              icon: showFinishLabel
                  ? Icons.check_rounded
                  : Icons.arrow_forward_ios_rounded,
              accentColor: accent,
              enabled: canNext,
              isNext: true,
              onTap: onNext,
            ),
          ),
        ],
      ),
    );
  }

  static Widget pictureMathDisplay(
    PictureMathRound round, {
    required Color accent,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: constraints.maxWidth),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 10,
              children: [
                _miniGroup(round.emoji, round.groupA, accent: accent),
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    round.isAddition ? '+' : '−',
                    style: AppTextStyles.heading2.copyWith(
                      fontSize: 28,
                      color: accent,
                    ),
                  ),
                ),
                if (round.isAddition)
                  _miniGroup(round.emoji, round.groupB, accent: accent)
                else
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'mathLogic.games.takeAway'.tr(),
                        style: AppTextStyles.caption.copyWith(fontSize: 11),
                      ),
                      _miniGroup(round.emoji, round.groupB, accent: accent, faded: true),
                    ],
                  ),
                Text(
                  '=',
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: 32,
                    color: AppColors.textSecondary,
                  ),
                ),
                Container(
                  width: 54,
                  height: 54,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: accent.withValues(alpha: 0.55), width: 2),
                  ),
                  child: Text(
                    '?',
                    style: AppTextStyles.heading2.copyWith(
                      fontSize: 26,
                      color: accent,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _miniGroup(
    String emoji,
    int count, {
    required Color accent,
    bool faded = false,
  }) {
    final size = count > 6 ? 22.0 : 26.0;
    return Opacity(
      opacity: faded ? 0.55 : 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withValues(alpha: 0.28), width: 1.5),
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 2,
          runSpacing: 2,
          children: List.generate(
            count.clamp(0, 8),
            (_) => Text(emoji, style: TextStyle(fontSize: size)),
          ),
        ),
      ),
    );
  }
}
