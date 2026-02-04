import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Button size variants
enum AppButtonSize { small, medium, large }

/// Button type variants
enum AppButtonType { primary, secondary, text, outline }

/// Custom Button Widget - Primary and Secondary buttons for the app
/// Usage: AppButton.primary(text: 'Click Me', onPressed: () {})
///        AppButton.secondary(text: 'Cancel', onPressed: () {})
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final IconData? suffixIcon;
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;

  const AppButton._({
    required this.text,
    required this.onPressed,
    required this.type,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.suffixIcon,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
  });

  /// Primary Button - Filled with primary color
  factory AppButton.primary({
    required String text,
    required VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    IconData? suffixIcon,
    double? width,
    Color? backgroundColor,
    Color? textColor,
    double? borderRadius,
  }) {
    return AppButton._(
      text: text,
      onPressed: onPressed,
      type: AppButtonType.primary,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      suffixIcon: suffixIcon,
      width: width,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderRadius: borderRadius,
    );
  }

  /// Secondary Button - Outlined with primary color
  factory AppButton.secondary({
    required String text,
    required VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    IconData? suffixIcon,
    double? width,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    double? borderRadius,
  }) {
    return AppButton._(
      text: text,
      onPressed: onPressed,
      type: AppButtonType.secondary,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      suffixIcon: suffixIcon,
      width: width,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
    );
  }

  /// Outline Button - Transparent with border
  factory AppButton.outline({
    required String text,
    required VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    IconData? suffixIcon,
    double? width,
    Color? textColor,
    Color? borderColor,
    double? borderRadius,
  }) {
    return AppButton._(
      text: text,
      onPressed: onPressed,
      type: AppButtonType.outline,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      suffixIcon: suffixIcon,
      width: width,
      textColor: textColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
    );
  }

  /// Text Button - No background, just text
  factory AppButton.text({
    required String text,
    required VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    IconData? suffixIcon,
    double? width,
    Color? textColor,
  }) {
    return AppButton._(
      text: text,
      onPressed: onPressed,
      type: AppButtonType.text,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      suffixIcon: suffixIcon,
      width: width,
      textColor: textColor,
    );
  }

  EdgeInsets get _padding {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 14);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 18);
    }
  }

  double get _iconSize {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  TextStyle get _textStyle {
    switch (size) {
      case AppButtonSize.small:
        return AppTextStyles.buttonSmall;
      case AppButtonSize.medium:
        return AppTextStyles.buttonMedium;
      case AppButtonSize.large:
        return AppTextStyles.buttonLarge;
    }
  }

  double get _loadingSize {
    switch (size) {
      case AppButtonSize.small:
        return 14;
      case AppButtonSize.medium:
        return 18;
      case AppButtonSize.large:
        return 22;
    }
  }

  Color get _backgroundColor {
    if (backgroundColor != null) return backgroundColor!;
    switch (type) {
      case AppButtonType.primary:
        return isDisabled
            ? AppColors.primary.withValues(alpha: 0.5)
            : AppColors.primary;
      case AppButtonType.secondary:
        return Colors.transparent;
      case AppButtonType.outline:
        return Colors.transparent;
      case AppButtonType.text:
        return Colors.transparent;
    }
  }

  Color get _foregroundColor {
    if (textColor != null) return textColor!;
    switch (type) {
      case AppButtonType.primary:
        return isDisabled
            ? AppColors.textLight.withValues(alpha: 0.7)
            : AppColors.textLight;
      case AppButtonType.secondary:
        return isDisabled
            ? AppColors.primary.withValues(alpha: 0.5)
            : AppColors.primary;
      case AppButtonType.outline:
        return isDisabled
            ? AppColors.textSecondary.withValues(alpha: 0.5)
            : AppColors.textSecondary;
      case AppButtonType.text:
        return isDisabled
            ? AppColors.primary.withValues(alpha: 0.5)
            : AppColors.primary;
    }
  }

  Color get _borderColorValue {
    if (borderColor != null) return borderColor!;
    switch (type) {
      case AppButtonType.primary:
        return Colors.transparent;
      case AppButtonType.secondary:
        return isDisabled
            ? AppColors.primary.withValues(alpha: 0.5)
            : AppColors.primary;
      case AppButtonType.outline:
        return isDisabled
            ? AppColors.border.withValues(alpha: 0.5)
            : AppColors.border;
      case AppButtonType.text:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = (isDisabled || isLoading) ? null : onPressed;
    final effectiveBorderRadius = borderRadius ?? 8.0;

    Widget buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: _loadingSize,
            height: _loadingSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(_foregroundColor),
            ),
          ),
          const SizedBox(width: 8),
        ] else if (icon != null) ...[
          Icon(icon, size: _iconSize, color: _foregroundColor),
          const SizedBox(width: 8),
        ],
        Text(text, style: _textStyle.copyWith(color: _foregroundColor)),
        if (suffixIcon != null && !isLoading) ...[
          const SizedBox(width: 8),
          Icon(suffixIcon, size: _iconSize, color: _foregroundColor),
        ],
      ],
    );

    Widget button;

    switch (type) {
      case AppButtonType.primary:
        button = ElevatedButton(
          onPressed: effectiveOnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: _backgroundColor,
            foregroundColor: _foregroundColor,
            padding: _padding,
            elevation: isDisabled ? 0 : 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
            ),
          ),
          child: buttonChild,
        );
        break;
      case AppButtonType.secondary:
        button = OutlinedButton(
          onPressed: effectiveOnPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: _backgroundColor,
            foregroundColor: _foregroundColor,
            padding: _padding,
            side: BorderSide(color: _borderColorValue, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
            ),
          ),
          child: buttonChild,
        );
        break;
      case AppButtonType.outline:
        button = OutlinedButton(
          onPressed: effectiveOnPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: _backgroundColor,
            foregroundColor: _foregroundColor,
            padding: _padding,
            side: BorderSide(color: _borderColorValue, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
            ),
          ),
          child: buttonChild,
        );
        break;
      case AppButtonType.text:
        button = TextButton(
          onPressed: effectiveOnPressed,
          style: TextButton.styleFrom(
            backgroundColor: _backgroundColor,
            foregroundColor: _foregroundColor,
            padding: _padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
            ),
          ),
          child: buttonChild,
        );
        break;
    }

    if (width != null) {
      return SizedBox(width: width, child: button);
    }

    return button;
  }
}
