import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';

/// Gradient button widget for primary actions
/// Creates buttons with gradient backgrounds as per design
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double height;
  final double borderRadius;
  final Gradient? gradient;
  final IconData? suffixIcon;
  final String? suffixEmoji;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = AppConstants.buttonHeight,
    this.borderRadius = AppConstants.radiusMD,
    this.gradient,
    this.suffixIcon,
    this.suffixEmoji,
  });

  /// Factory for primary button style
  factory GradientButton.primary({
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    double? width,
  }) {
    return GradientButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      width: width,
      gradient: AppColors.buttonGradient,
    );
  }

  /// Factory for button with arrow
  factory GradientButton.withArrow({
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    double? width,
  }) {
    return GradientButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      width: width,
      gradient: AppColors.buttonGradient,
      suffixEmoji: '→',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: onPressed != null && !isLoading
            ? (gradient ?? AppColors.buttonGradient)
            : null,
        color: onPressed == null || isLoading ? AppColors.textTertiary : null,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: onPressed != null && !isLoading
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                      if (suffixEmoji != null) ...[
                        const SizedBox(width: 4),
                        Text(
                          suffixEmoji!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                      if (suffixIcon != null) ...[
                        const SizedBox(width: 8),
                        Icon(suffixIcon, color: Colors.white, size: 18),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

/// Small variant of gradient button
class GradientButtonSmall extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double borderRadius;

  const GradientButtonSmall({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.borderRadius = AppConstants.radiusSM,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        gradient: onPressed != null && !isLoading
            ? AppColors.buttonGradient
            : null,
        color: onPressed == null || isLoading ? AppColors.textTertiary : null,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: onPressed != null && !isLoading
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
