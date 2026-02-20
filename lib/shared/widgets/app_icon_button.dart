import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'app_text.dart';

/// Custom Icon Button Widget - Reusable icon button with consistent styling
/// Usage: AppIconButton(icon: Icons.add, onPressed: () {})
///        AppIconButton.circle(icon: Icons.close, onPressed: () {})
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final double size;
  final double iconSize;
  final bool isCircle;
  final String? tooltip;
  final bool isLoading;
  final bool isDisabled;
  final double? borderRadius;
  final Color? borderColor;

  const AppIconButton._({
    required this.icon,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.size = 48,
    this.iconSize = 24,
    this.isCircle = false,
    this.tooltip,
    this.isLoading = false,
    this.isDisabled = false,
    this.borderRadius,
    this.borderColor,
  });

  /// Standard icon button
  factory AppIconButton({
    required IconData icon,
    VoidCallback? onPressed,
    Color? iconColor,
    Color? backgroundColor,
    double size = 48,
    double iconSize = 24,
    String? tooltip,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    return AppIconButton._(
      icon: icon,
      onPressed: onPressed,
      iconColor: iconColor,
      backgroundColor: backgroundColor,
      size: size,
      iconSize: iconSize,
      isCircle: false,
      tooltip: tooltip,
      isLoading: isLoading,
      isDisabled: isDisabled,
    );
  }

  /// Circular icon button
  factory AppIconButton.circle({
    required IconData icon,
    VoidCallback? onPressed,
    Color? iconColor,
    Color? backgroundColor,
    double size = 48,
    double iconSize = 24,
    String? tooltip,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    return AppIconButton._(
      icon: icon,
      onPressed: onPressed,
      iconColor: iconColor,
      backgroundColor: backgroundColor,
      size: size,
      iconSize: iconSize,
      isCircle: true,
      tooltip: tooltip,
      isLoading: isLoading,
      isDisabled: isDisabled,
    );
  }

  /// Outlined icon button
  factory AppIconButton.outlined({
    required IconData icon,
    VoidCallback? onPressed,
    Color? iconColor,
    Color? borderColor,
    double size = 48,
    double iconSize = 24,
    double borderRadius = 8,
    String? tooltip,
    bool isLoading = false,
    bool isDisabled = false,
  }) {
    return AppIconButton._(
      icon: icon,
      onPressed: onPressed,
      iconColor: iconColor,
      backgroundColor: Colors.transparent,
      size: size,
      iconSize: iconSize,
      isCircle: false,
      tooltip: tooltip,
      isLoading: isLoading,
      isDisabled: isDisabled,
      borderRadius: borderRadius,
      borderColor: borderColor,
    );
  }

  /// Back button
  factory AppIconButton.back({
    VoidCallback? onPressed,
    Color? iconColor,
    double size = 40,
  }) {
    return AppIconButton._(
      icon: Icons.arrow_back_ios_new,
      onPressed: onPressed,
      iconColor: iconColor ?? AppColors.textPrimary,
      size: size,
      iconSize: 20,
    );
  }

  /// Close button
  factory AppIconButton.close({
    VoidCallback? onPressed,
    Color? iconColor,
    double size = 40,
  }) {
    return AppIconButton._(
      icon: Icons.close,
      onPressed: onPressed,
      iconColor: iconColor ?? AppColors.textPrimary,
      size: size,
      iconSize: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = isDisabled
        ? AppColors.textMuted
        : (iconColor ?? AppColors.textPrimary);

    Widget buttonContent = isLoading
        ? SizedBox(
            width: iconSize,
            height: iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(effectiveIconColor),
            ),
          )
        : Icon(icon, size: iconSize, color: effectiveIconColor);

    Widget button = Material(
      color: backgroundColor ?? Colors.transparent,
      shape: isCircle
          ? const CircleBorder()
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              side: borderColor != null
                  ? BorderSide(color: borderColor!)
                  : BorderSide.none,
            ),
      child: InkWell(
        onTap: isDisabled || isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(
          isCircle ? size : (borderRadius ?? 8),
        ),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          child: buttonContent,
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}

/// Floating action button with badge
class AppFab extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final String? tooltip;
  final int? badgeCount;
  final bool mini;

  const AppFab({
    super.key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.tooltip,
    this.badgeCount,
    this.mini = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget fab = FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? AppColors.primary,
      mini: mini,
      tooltip: tooltip,
      child: Icon(icon, color: iconColor ?? Colors.white),
    );

    if (badgeCount != null && badgeCount! > 0) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          fab,
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              child: Center(
                child: AppText.caption(
                  badgeCount! > 99 ? '99+' : badgeCount.toString(),
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return fab;
  }
}
