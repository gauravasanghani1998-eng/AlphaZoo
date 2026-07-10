import 'package:flutter/material.dart';

/// App-wide color palette - bright and kid-friendly
class AppColors {
  AppColors._();

  // Primary colors
  static const Color primary = Color(0xFF4ECDC4);
  static const Color secondary = Color(0xFFFF6B9D);
  static const Color accent = Color(0xFFFFC75F);

  static const Color background = Color(0xFFFFF8F0);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color appBarTint = Color(0xFFFFF3D0);

  static const List<Color> letterColors = [
    Color(0xFFFF6B6B), // Red coral
    // Color(0xFF0F3460), // Royal navy blue
    Color(0xFF43B56B), // Green
    Color(0xFFE84D8A), // Rose
    Color(0xFF01579B), // Ocean blue
    Color(0xFFB8860B), // Antique gold
    Color(0xFF8B5CF6), // Purple
    Color(0xFF2E9B5E), // Emerald
    Color(0xFFE53935), // Cherry red
    // Color(0xFF004D40), // Deep jade
    Color(0xFF5C6BC0), // Indigo
    Color(0xFFE87B2E), // Deep orange
    Color(0xFF6A0DAD), // Royal violet
    Color(0xFF2EB8AE), // Teal
    Color(0xFFAD1457), // Raspberry
    Color(0xFF1B5E20), // Forest green
    Color(0xFF4D96FF), // Sky blue
    // Color(0xFF6D4C41), // Warm brown
    Color(0xFF7B1FA2), // Amethyst
    Color(0xFF00695C), // Rich emerald teal
    Color(0xFF283593), // Royal indigo
    Color(0xFF6A1B9A), // Deep violet
  ];

  // Text colors
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Shadow colors
  static Color shadow = Colors.black.withValues(alpha: 0.1);
  static Color shadowDark = Colors.black.withValues(alpha: 0.2);

  /// Get color for a specific letter index
  static Color getLetterColor(int index) {
    return letterColors[index % letterColors.length];
  }
}
