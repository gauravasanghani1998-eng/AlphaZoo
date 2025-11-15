import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// App-wide text styles using kid-friendly fonts
class AppTextStyles {
  AppTextStyles._();

  // Base text theme using Fredoka
  static TextTheme get textTheme => GoogleFonts.fredokaTextTheme();
  
  // Large letter display
  static TextStyle get hugeLetter => GoogleFonts.fredoka(
    fontSize: 120,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.0,
  );
  
  // Detail screen letter
  static TextStyle get detailLetter => GoogleFonts.fredoka(
    fontSize: 96,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.0,
  );
  
  // Grid tile letter
  static TextStyle get tileLetter => GoogleFonts.fredoka(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
    height: 1.0,
  );
  
  // Headings
  static TextStyle get heading1 => GoogleFonts.fredoka(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get heading2 => GoogleFonts.fredoka(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get heading3 => GoogleFonts.fredoka(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  // Word display
  static TextStyle get word => GoogleFonts.baloo2(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
  
  // Body text
  static TextStyle get body => GoogleFonts.baloo2(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );
  
  static TextStyle get bodyBold => GoogleFonts.baloo2(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  // Button text
  static TextStyle get button => GoogleFonts.fredoka(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
  );
  
  // Caption
  static TextStyle get caption => GoogleFonts.baloo2(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
}

