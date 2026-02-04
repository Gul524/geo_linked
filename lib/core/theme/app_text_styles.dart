import 'package:flutter/material.dart';
import 'app_colors.dart';

/// App text sizes - centralized text size definitions
class AppTextSizes {
  AppTextSizes._();

  // Heading Sizes
  static const double h1 = 32.0;
  static const double h2 = 28.0;
  static const double h3 = 24.0;
  static const double h4 = 20.0;
  static const double h5 = 18.0;
  static const double h6 = 16.0;

  // Body Sizes
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;

  // Caption & Label Sizes
  static const double caption = 12.0;
  static const double label = 14.0;
  static const double labelSmall = 11.0;

  // Button Sizes
  static const double buttonLarge = 16.0;
  static const double buttonMedium = 14.0;
  static const double buttonSmall = 12.0;
}

/// App text styles - centralized text style definitions
class AppTextStyles {
  AppTextStyles._();

  static const String _fontFamily = 'Roboto';

  // Headings
  static TextStyle get h1 => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.h1,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle get h2 => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.h2,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get h3 => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.h3,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get h4 => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.h4,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get h5 => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.h5,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get h6 => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.h6,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  // Body Text
  static TextStyle get bodyLarge => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.bodyLarge,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.bodyMedium,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.bodySmall,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  // Labels
  static TextStyle get label => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.label,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get labelSmall => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.labelSmall,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  // Caption
  static TextStyle get caption => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.caption,
        fontWeight: FontWeight.normal,
        color: AppColors.textMuted,
        height: 1.4,
      );

  // Button Text
  static TextStyle get buttonLarge => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.buttonLarge,
        fontWeight: FontWeight.w600,
        color: AppColors.textLight,
        height: 1.2,
      );

  static TextStyle get buttonMedium => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.buttonMedium,
        fontWeight: FontWeight.w600,
        color: AppColors.textLight,
        height: 1.2,
      );

  static TextStyle get buttonSmall => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.buttonSmall,
        fontWeight: FontWeight.w600,
        color: AppColors.textLight,
        height: 1.2,
      );

  // Link Text
  static TextStyle get link => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.bodyMedium,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
        decoration: TextDecoration.underline,
        height: 1.5,
      );

  // Error Text
  static TextStyle get error => const TextStyle(
        fontFamily: _fontFamily,
        fontSize: AppTextSizes.bodySmall,
        fontWeight: FontWeight.normal,
        color: AppColors.error,
        height: 1.4,
      );
}
