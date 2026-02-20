import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'app_button.dart';
import 'app_text.dart';

/// Custom Empty State Widget - Reusable empty state placeholder
/// Usage: AppEmptyState(title: 'No Data', message: 'Start by adding items')
class AppEmptyState extends StatelessWidget {
  final String title;
  final String? message;
  final IconData? icon;
  final Widget? customIcon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final double iconSize;
  final Color? iconColor;

  const AppEmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon,
    this.customIcon,
    this.buttonText,
    this.onButtonPressed,
    this.iconSize = 80,
    this.iconColor,
  });

  /// No data empty state
  factory AppEmptyState.noData({
    String title = 'No Data',
    String? message = 'There is no data to display',
    String? buttonText,
    VoidCallback? onButtonPressed,
  }) {
    return AppEmptyState(
      title: title,
      message: message,
      icon: Icons.inbox_outlined,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
    );
  }

  /// No results empty state
  factory AppEmptyState.noResults({
    String title = 'No Results',
    String? message = 'Try adjusting your search or filters',
    String? buttonText = 'Clear Filters',
    VoidCallback? onButtonPressed,
  }) {
    return AppEmptyState(
      title: title,
      message: message,
      icon: Icons.search_off_outlined,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
    );
  }

  /// Error empty state
  factory AppEmptyState.error({
    String title = 'Something Went Wrong',
    String? message = 'An error occurred. Please try again.',
    String? buttonText = 'Retry',
    VoidCallback? onButtonPressed,
  }) {
    return AppEmptyState(
      title: title,
      message: message,
      icon: Icons.error_outline,
      iconColor: AppColors.error,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
    );
  }

  /// No connection empty state
  factory AppEmptyState.noConnection({
    String title = 'No Connection',
    String? message = 'Check your internet connection and try again',
    String? buttonText = 'Retry',
    VoidCallback? onButtonPressed,
  }) {
    return AppEmptyState(
      title: title,
      message: message,
      icon: Icons.wifi_off_outlined,
      buttonText: buttonText,
      onButtonPressed: onButtonPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customIcon ??
                Icon(
                  icon ?? Icons.inbox_outlined,
                  size: iconSize,
                  color: iconColor ?? AppColors.textMuted,
                ),
            const SizedBox(height: 24),
            AppText.h5(title, textAlign: TextAlign.center),
            if (message != null) ...[
              const SizedBox(height: 8),
              AppText.body(
                message!,
                textAlign: TextAlign.center,
                color: AppColors.textSecondary,
              ),
            ],
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              AppButton.primary(text: buttonText!, onPressed: onButtonPressed),
            ],
          ],
        ),
      ),
    );
  }
}
