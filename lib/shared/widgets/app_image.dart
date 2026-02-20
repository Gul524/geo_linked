import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Image shape variants
enum AppImageShape { rectangle, rounded, circle }

/// Custom Image Widget - Reusable image component with loading and error states
/// Usage: AppImage.network(url: 'https://...')
///        AppImage.asset(path: 'assets/images/logo.png')
class AppImage extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AppImageShape shape;
  final double borderRadius;
  final Color? backgroundColor;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Color? borderColor;
  final double borderWidth;

  const AppImage._({
    this.imageUrl,
    this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.shape = AppImageShape.rectangle,
    this.borderRadius = 0,
    this.backgroundColor,
    this.placeholder,
    this.errorWidget,
    this.borderColor,
    this.borderWidth = 0,
  });

  /// Network image
  factory AppImage.network({
    required String url,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    AppImageShape shape = AppImageShape.rectangle,
    double borderRadius = 0,
    Color? backgroundColor,
    Widget? placeholder,
    Widget? errorWidget,
    Color? borderColor,
    double borderWidth = 0,
  }) {
    return AppImage._(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      shape: shape,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      placeholder: placeholder,
      errorWidget: errorWidget,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );
  }

  /// Asset image
  factory AppImage.asset({
    required String path,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    AppImageShape shape = AppImageShape.rectangle,
    double borderRadius = 0,
    Color? backgroundColor,
    Color? borderColor,
    double borderWidth = 0,
  }) {
    return AppImage._(
      assetPath: path,
      width: width,
      height: height,
      fit: fit,
      shape: shape,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );
  }

  /// Avatar image (circular)
  factory AppImage.avatar({
    String? url,
    String? assetPath,
    double size = 48,
    Color? backgroundColor,
    Widget? placeholder,
    Color? borderColor,
    double borderWidth = 0,
  }) {
    return AppImage._(
      imageUrl: url,
      assetPath: assetPath,
      width: size,
      height: size,
      fit: BoxFit.cover,
      shape: AppImageShape.circle,
      backgroundColor: backgroundColor,
      placeholder: placeholder,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );
  }

  BorderRadius get _borderRadius {
    switch (shape) {
      case AppImageShape.circle:
        return BorderRadius.circular(width ?? height ?? 100);
      case AppImageShape.rounded:
        return BorderRadius.circular(borderRadius > 0 ? borderRadius : 12);
      case AppImageShape.rectangle:
        return BorderRadius.circular(borderRadius);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (assetPath != null) {
      imageWidget = Image.asset(
        assetPath!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _buildError(),
      );
    } else if (imageUrl != null) {
      imageWidget = Image.network(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildPlaceholder();
        },
        errorBuilder: (context, error, stackTrace) => _buildError(),
      );
    } else {
      imageWidget = _buildPlaceholder();
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.border,
        borderRadius: _borderRadius,
        border: borderWidth > 0
            ? Border.all(
                color: borderColor ?? AppColors.border,
                width: borderWidth,
              )
            : null,
      ),
      child: ClipRRect(borderRadius: _borderRadius, child: imageWidget),
    );
  }

  Widget _buildPlaceholder() {
    return placeholder ??
        Container(
          width: width,
          height: height,
          color: backgroundColor ?? AppColors.border,
          child: Icon(
            Icons.image_outlined,
            color: AppColors.textSecondary,
            size: (width ?? height ?? 48) / 2,
          ),
        );
  }

  Widget _buildError() {
    return errorWidget ??
        Container(
          width: width,
          height: height,
          color: backgroundColor ?? AppColors.border,
          child: Icon(
            Icons.broken_image_outlined,
            color: AppColors.textSecondary,
            size: (width ?? height ?? 48) / 2,
          ),
        );
  }
}
