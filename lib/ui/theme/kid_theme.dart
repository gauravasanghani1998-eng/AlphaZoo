import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';

/// Material theme tuned for AlphaZoo — same palette, kid-sized controls.
ThemeData buildKidTheme() {
  final base = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    textTheme: GoogleFonts.fredokaTextTheme(),
    useMaterial3: true,
  );

  return base.copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.appBarTint.withValues(alpha: 0.95),
      elevation: 4,
      shadowColor: Colors.orange.withValues(alpha: 0.2),
      centerTitle: true,
      toolbarHeight: 60,
      iconTheme: const IconThemeData(color: AppColors.primary, size: 22),
      titleTextStyle: AppTextStyles.heading3.copyWith(
        color: AppColors.primary,
        fontSize: 20,
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      dragHandleColor: Color(0xFFE0E0E0),
      showDragHandle: true,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(120, 52),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        textStyle: AppTextStyles.button.copyWith(fontSize: 18),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.white,
      selectedColor: AppColors.primary,
      labelStyle: AppTextStyles.bodyBold.copyWith(fontSize: 15),
      secondaryLabelStyle: AppTextStyles.bodyBold.copyWith(
        color: Colors.white,
        fontSize: 15,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(
          color: AppColors.primary.withValues(alpha: 0.25),
          width: 2,
        ),
      ),
    ),
  );
}
