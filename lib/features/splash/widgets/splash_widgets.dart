import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_text.dart';

/// App Logo Widget for Splash Screen
class SplashLogo extends StatelessWidget {
  final double size;

  const SplashLogo({super.key, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(size * 0.25),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(
        Icons.location_on,
        size: size * 0.5,
        color: AppColors.textLight,
      ),
    );
  }
}

/// Loading Indicator Widget
class SplashLoadingIndicator extends StatelessWidget {
  final double progress;

  const SplashLoadingIndicator({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 200,
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.border,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            borderRadius: BorderRadius.circular(4),
            minHeight: 4,
          ),
        ),
        const SizedBox(height: 16),
        AppText.caption('${(progress * 100).toInt()}%'),
      ],
    );
  }
}
