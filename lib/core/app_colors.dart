import 'package:flutter/material.dart';

/// App-wide color palette - bright and kid-friendly
class AppColors {
  AppColors._();

  // Primary colors
  static const Color primary = Color(0xFF4ECDC4);
  static const Color secondary = Color(0xFFFF6B9D);
  static const Color accent = Color(0xFFFFC75F);

  // Background colors
  static const Color background = Color(0xFFFFF8F0);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // Letter tile colors - rotating palette
  static const List<Color> letterColors = [
    Color(0xFFFF6B6B), // Red
    Color(0xFFFFD93D), // Yellow
    Color(0xFF6BCF7F), // Green
    Color(0xFF4D96FF), // Blue
    Color(0xFFAE7AFF), // Purple
    Color(0xFFFF9999), // Pink
    Color(0xFFFFB347), // Orange
    Color(0xFF77DD77), // Light green
    Color(0xFF779ECB), // Light blue
    Color(0xFFDDA0DD), // Plum
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
