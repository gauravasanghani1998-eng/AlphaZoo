import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../data/math_logic_data.dart';

/// Play-area accents from [AppColors.letterColors], excluding greens and reds
/// so correct / wrong option feedback stays clear.
class MathLogicColors {
  MathLogicColors._();

  static const Color _successGreen = Color(0xFF43B56B);
  static const Color _wrongRed = Color(0xFFE53935);

  static const Set<int> _excludedArgb = {
    0xFFFF6B6B, // red coral
    0xFF43B56B, // green
    0xFF2E9B5E, // emerald
    0xFFE53935, // cherry red
    0xFF1B5E20, // forest green
    0xFF00695C, // emerald teal
    0xFFAD1457, // raspberry (too close to wrong red)
    0xFF2EB8AE, // teal (close to success green)
  };

  static bool _isFeedbackColor(Color color) {
    final argb = color.toARGB32();
    if (_excludedArgb.contains(argb)) return true;
    if (argb == _successGreen.toARGB32() || argb == _wrongRed.toARGB32()) {
      return true;
    }
    return false;
  }

  static List<Color> get safePalette => AppColors.letterColors
      .where((color) => !_isFeedbackColor(color))
      .toList(growable: false);

  static int _indexOf(Color color) {
    final idx = safePalette.indexWhere((c) => c.toARGB32() == color.toARGB32());
    return idx >= 0 ? idx : 0;
  }

  static Color forActivity(MathActivityId activityId) {
    final palette = safePalette;
    return palette[activityId.index % palette.length];
  }

  static Color forRound(
    MathActivityId activityId,
    int roundIndex, {
    Color? baseAccent,
  }) {
    final palette = safePalette;
    if (baseAccent != null && !_isFeedbackColor(baseAccent)) {
      final start = _indexOf(baseAccent);
      return palette[(start + roundIndex) % palette.length];
    }
    return palette[(activityId.index + roundIndex) % palette.length];
  }

  static Color tileColor(
    MathActivityId activityId,
    int roundIndex,
    int tileIndex, {
    Color? baseAccent,
  }) {
    final palette = safePalette;
    if (baseAccent != null && !_isFeedbackColor(baseAccent)) {
      final start = _indexOf(baseAccent);
      return palette[(start + roundIndex + tileIndex + 1) % palette.length];
    }
    return palette[(activityId.index + roundIndex + tileIndex + 1) %
        palette.length];
  }

  static Color shift(Color base, int offset) {
    final palette = safePalette;
    return palette[(_indexOf(base) + offset) % palette.length];
  }
}
