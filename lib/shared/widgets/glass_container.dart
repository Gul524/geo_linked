import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';

/// Glassmorphism container widget
/// Creates a frosted glass effect commonly used in iOS design
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final double blur;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? boxShadow;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = AppConstants.radiusMD,
    this.blur = 20.0,
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.margin,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color:
                  backgroundColor ??
                  (isDark
                      ? Colors.black.withValues(alpha: 0.3)
                      : Colors.white.withValues(alpha: 0.85)),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color:
                    borderColor ??
                    (isDark ? AppColors.borderDark : AppColors.glassBorder),
                width: 1,
              ),
              boxShadow:
                  boxShadow ??
                  [
                    BoxShadow(
                      color: AppColors.shadow.withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  /// Factory for search bar style
  factory GlassContainer.searchBar({
    required Widget child,
    EdgeInsetsGeometry? padding,
  }) {
    return GlassContainer(
      borderRadius: 16,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
      child: child,
    );
  }

  /// Factory for filter pill style
  factory GlassContainer.pill({
    required Widget child,
    EdgeInsetsGeometry? padding,
    bool isActive = false,
  }) {
    return GlassContainer(
      borderRadius: AppConstants.radiusPill,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      backgroundColor: isActive
          ? AppColors.primary
          : Colors.white.withValues(alpha: 0.8),
      borderColor: isActive ? AppColors.primary : AppColors.glassBorder,
      child: child,
    );
  }
}
