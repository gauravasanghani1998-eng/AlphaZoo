import 'package:flutter/material.dart';

/// App-wide color palette - bright and kid-friendly
class AppColors {
  AppColors._();

  // Primary colors
  static const Color primary = Color(0xFF4ECDC4);
  static const Color secondary = Color(0xFFFF6B9D);
  static const Color accent = Color(0xFFFFC75F);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color background = Color(0xFFFFF8F0);
  static const Color cardBackground = white;
  static const Color appBarTint = Color(0xFFFFF3D0);

  static const List<Color> letterColors = [
    Color(0xFFFF6B6B), // Red coral
    Color(0xFF43B56B), // Green
    Color(0xFFE84D8A), // Rose
    Color(0xFF01579B), // Ocean blue
    Color(0xFFB8860B), // Antique gold
    Color(0xFF8B5CF6), // Purple
    Color(0xFF2E9B5E), // Emerald
    Color(0xFFE53935), // Cherry red
    Color(0xFF5C6BC0), // Indigo
    Color(0xFFE87B2E), // Deep orange
    Color(0xFF6A0DAD), // Royal violet
    Color(0xFF2EB8AE), // Teal
    Color(0xFFAD1457), // Raspberry
    Color(0xFF1B5E20), // Forest green
    Color(0xFF4D96FF), // Sky blue
    Color(0xFF7B1FA2), // Amethyst
    Color(0xFF00695C), // Rich emerald teal
    Color(0xFF283593), // Royal indigo
    Color(0xFF6A1B9A), // Deep violet
  ];

  // Text colors
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textWhite = white;

  // Shadow colors
  static Color shadow = Colors.black.withValues(alpha: 0.1);
  static Color shadowDark = Colors.black.withValues(alpha: 0.2);

  // ── Good Habits & Hygiene ─────────────────────────────────
  static const Color habitsHygiene = Color(0xFF2EB8AE);
  static const Color habitsDaily = Color(0xFFFF8A65);
  static const Color habitsEating = Color(0xFF66BB6A);
  static const Color habitsClean = Color(0xFF42A5F5);
  static const Color habitsSafety = Color(0xFFEF5350);
  static const Color habitsManners = Color(0xFFAB47BC);
  static const Color habitsEarth = Color(0xFF26A69A);
  static const Color habitsSchool = Color(0xFFFFB300);

  static const List<Color> goodHabitsCategoryColors = [
    habitsHygiene,
    habitsDaily,
    habitsEating,
    habitsClean,
    habitsSafety,
    habitsManners,
    habitsEarth,
    habitsSchool,
  ];

  static const Color goodHabitsHubBg = Color(0xFFF3FBFF);
  static const Color goodHabitsHubAppBar = Color(0xFFE8F7F5);
  static const Color goodHabitsDetailBg = Color(0xFFFFF6EC);
  static const Color goodHabitsTipCardBg = Color(0xFFFFF8E1);
  static const Color goodHabitsSparkDot = Color(0xFFFFF59D);
  static const Color goodHabitsTipTitleWarm = Color(0xFFE65100);

  // ── Positions / Directions ────────────────────────────────
  static const Color directionsHubBg = Color(0xFFF0F9FF);
  static const Color directionsSkyTop = Color(0xFF6FBDF2);
  static const Color directionsSkyMid = Color(0xFFA4D9F9);
  static const Color directionsSkyBottom = Color(0xFFE3F4FF);
  static const Color directionsGrass = Color(0xFF8BC34A);
  static const Color directionsGrassDark = Color(0xFF689F38);
  static const Color directionsDetailBg = Color(0xFFF2FAFF);
  static const Color directionsSun = Color(0xFFFFD54F);
  static const Color directionsCompass = Color(0xFF3F51B5);
  static const List<Color> directionsStageSky = [
    Color(0xFF4FB0F0),
    Color(0xFF90D2F8),
    Color(0xFFD9F1FF),
  ];

  /// Per-item accent for the Positions / Directions module.
  static Color directionsAccent(int index) {
    return letterColors[(index + 2) % letterColors.length];
  }

  /// Get color for a specific letter index
  static Color getLetterColor(int index) {
    return letterColors[index % letterColors.length];
  }

  static Color getGoodHabitsCategoryColor(int index) {
    return goodHabitsCategoryColors[index % goodHabitsCategoryColors.length];
  }

  /// Per-habit tint used on list rows + detail screen together.
  static Color goodHabitsPageAccent({
    required Color categoryAccent,
    required int habitIndex,
  }) {
    final letter = getLetterColor(habitIndex + 3);
    return Color.lerp(categoryAccent, letter, 0.42)!;
  }

  // ── Community Helpers (neighborhood / helper-badge look) ──
  static const Color helpersHubBg = Color(0xFFEAF7F4);
  static const Color helpersHubAppBar = Color(0xFFD8F0EB);
  static const Color helpersDetailBg = Color(0xFFFFF3E8);
  static const Color helpersBadgeRing = Color(0xFFFFB74D);
  static const List<Color> helpersAccentPalette = [
    Color(0xFF2BAFA6),
    Color(0xFFE87B2E),
    Color(0xFF4D96FF),
    Color(0xFFE84D8A),
    Color(0xFF43B56B),
    Color(0xFFE53935),
    Color(0xFF5C6BC0),
    Color(0xFF00897B),
    Color(0xFFFF8A65),
    Color(0xFF7B1FA2),
    Color(0xFF00838F),
    Color(0xFFC0A145),
    Color(0xFF26A69A),
    Color(0xFFEF6C00),
    Color(0xFF3949AB),
    Color(0xFF00897B),
    Color(0xFF6D4C41),
    Color(0xFF546E7A),
    Color(0xFFAD1457),
    Color(0xFF1565C0),
    Color(0xFF2E7D32),
    Color(0xFFF9A825),
    Color(0xFF0277BD),
    Color(0xFF5D4037),
    Color(0xFF00838F),
    Color(0xFF455A64),
    Color(0xFF6A1B9A),
    Color(0xFFC62828),
    Color(0xFF1565C0),
    Color(0xFFEF6C00),
    Color(0xFF2E7D32),
    Color(0xFF6D4C41),
    Color(0xFFFF8F00),
    Color(0xFF0277BD),
    Color(0xFF37474F),
    Color(0xFF5C6BC0),
    Color(0xFFC0A145),
  ];

  static Color helpersAccent(int index) {
    return helpersAccentPalette[index % helpersAccentPalette.length];
  }

  // ── Stories ───────────────────────────────────────────────
  static const Color storiesHubBg = Color(0xFFFFF8F0);
  static const Color storiesReaderBg = Color(0xFFFFFBF5);

  // ── Puzzle Games (Good Habits / Directions-style hub + one theme per game) ──
  static const Color puzzleHubBg = Color(0xFFF3FBFF);
  static const Color puzzleHubAppBar = Color(0xFFE8F7F5);
  static const Color puzzleBoard = Color(0xFFFFFCF8);
  static const Color puzzleSuccess = Color(0xFF43B56B);
  static const Color puzzleWrong = Color(0xFFE53935);

  /// Main accent per game — aligned with Good Habits category colors.
  static const List<Color> puzzleGameThemeColors = [
    habitsHygiene, // Memory Match
    directionsCompass, // Opposites Match
    habitsEating, // Picture Word
    habitsClean, // Listen & Find
    habitsDaily, // Sort Boxes
    habitsManners, // Odd One Out
  ];

  /// Lighter sibling in the same family (buttons, 2nd column, gradients).
  static const List<Color> puzzleGameWashColors = [
    Color(0xFF4ECDC4),
    Color(0xFF7986CB),
    Color(0xFF81C784),
    Color(0xFF64B5F6),
    Color(0xFFFFAB91),
    Color(0xFFCE93D8),
  ];

  static Color getPuzzleGameColor(int index) {
    return puzzleGameThemeColors[index % puzzleGameThemeColors.length];
  }

  static Color getPuzzleGameWash(int index) {
    return puzzleGameWashColors[index % puzzleGameWashColors.length];
  }

  /// Inside one game screen — each row/tile gets its own tint (like habit list).
  static Color puzzlePageAccent({
    required Color gameAccent,
    required int itemIndex,
  }) {
    return goodHabitsPageAccent(
      categoryAccent: gameAccent,
      habitIndex: itemIndex,
    );
  }

  static Color puzzleDeepAccent(Color themeAccent) {
    return Color.lerp(themeAccent, const Color(0xFF37474F), 0.20)!;
  }

  /// Soft card backs for Memory Match — light, teal-friendly (no hot pink/purple).
  static Color memoryLightCardVariant({
    required Color themeAccent,
    required int variantIndex,
  }) {
    const partners = [
      habitsHygiene,
      habitsEarth,
      habitsClean,
      habitsEating,
      primary,
      Color(0xFF4ECDC4),
      Color(0xFF80CBC4),
      Color(0xFF26A69A),
    ];
    final partner = partners[variantIndex % partners.length];
    final mixed = Color.lerp(themeAccent, partner, 0.34)!;
    return Color.lerp(mixed, white, 0.38)!;
  }
}
