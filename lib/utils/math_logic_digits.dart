import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../data/numbers_data.dart';

/// Locale-aware digit formatting for Math & Logic screens.
class MathLogicDigits {
  MathLogicDigits._();

  /// Prefix for [PickAnswerRound] labels resolved via easy_localization at display time.
  static const translationRefPrefix = '@';

  static String glyphs(BuildContext context) => NumbersData.glyphsKey.tr();

  static bool isTranslationRef(String value) =>
      value.startsWith(translationRefPrefix);

  static String resolveLabel(BuildContext context, String label) {
    if (label == '__') return label;
    if (isTranslationRef(label)) {
      return label.substring(translationRefPrefix.length).tr();
    }
    return formatText(context, label);
  }

  static String format(BuildContext context, int value) {
    return NumbersData.formatDigits(value, glyphs(context));
  }

  static String formatText(BuildContext context, String text) {
    final n = int.tryParse(text.trim());
    if (n == null) return text;
    return format(context, n);
  }

  static List<String> formatLabels(BuildContext context, List<String> labels) {
    return labels
        .map((label) => resolveLabel(context, label))
        .toList(growable: false);
  }

  static Map<String, String> formatArgs(
    BuildContext context,
    Map<String, String>? args,
  ) {
    if (args == null) return const {};
    return {
      for (final entry in args.entries)
        entry.key: formatText(context, entry.value),
    };
  }

  static List<String> formatParts(BuildContext context, List<String> parts) {
    return parts
        .map((part) => resolveLabel(context, part))
        .toList(growable: false);
  }
}
