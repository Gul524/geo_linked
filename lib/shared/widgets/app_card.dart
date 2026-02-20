import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Card elevation variants
enum AppCardElevation { none, low, medium, high }

/// Custom Card Widget - Reusable card with consistent styling
/// Usage: AppCard(child: yourWidget)
///        AppCard.outlined(child: yourWidget)
class AppCard extends StatelessWidget {
  final Widget child;
  final AppCardElevation elevation;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool isOutlined;
  final double? width;
  final double? height;
  final Gradient? gradient;

  const AppCard._({
    required this.child,
    this.elevation = AppCardElevation.low,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.onTap,
    this.isOutlined = false,
    this.width,
    this.height,
    this.gradient,
  });

  /// Standard card with shadow
  factory AppCard({
    required Widget child,
    AppCardElevation elevation = AppCardElevation.low,
    Color? backgroundColor,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    double? width,
    double? height,
    Gradient? gradient,
  }) {
    return AppCard._(
      elevation: elevation,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      padding: padding,
      margin: margin,
      onTap: onTap,
      width: width,
      height: height,
      gradient: gradient,
      child: child,
    );
  }

  /// Outlined card without shadow
  factory AppCard.outlined({
    required Widget child,
    Color? backgroundColor,
    Color? borderColor,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    double? width,
    double? height,
  }) {
    return AppCard._(
      elevation: AppCardElevation.none,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      padding: padding,
      margin: margin,
      onTap: onTap,
      isOutlined: true,
      width: width,
      height: height,
      child: child,
    );
  }

  /// Gradient card
  factory AppCard.gradient({
    required Widget child,
    required Gradient gradient,
    AppCardElevation elevation = AppCardElevation.low,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    double? width,
    double? height,
  }) {
    return AppCard._(
      elevation: elevation,
      borderRadius: borderRadius,
      padding: padding,
      margin: margin,
      onTap: onTap,
      width: width,
      height: height,
      gradient: gradient,
      child: child,
    );
  }

  double get _elevation {
    switch (elevation) {
      case AppCardElevation.none:
        return 0;
      case AppCardElevation.low:
        return 2;
      case AppCardElevation.medium:
        return 4;
      case AppCardElevation.high:
        return 8;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardBorderRadius = BorderRadius.circular(borderRadius ?? 12);

    Widget cardContent = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: gradient == null ? (backgroundColor ?? AppColors.surface) : null,
        gradient: gradient,
        borderRadius: cardBorderRadius,
        border: isOutlined
            ? Border.all(color: borderColor ?? AppColors.border)
            : null,
        boxShadow: elevation != AppCardElevation.none && !isOutlined
            ? [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: _elevation * 2,
                  offset: Offset(0, _elevation / 2),
                ),
              ]
            : null,
      ),
      child: child,
    );

    if (margin != null) {
      cardContent = Padding(padding: margin!, child: cardContent);
    }

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: cardBorderRadius,
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }
}
