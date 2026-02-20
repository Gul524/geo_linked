import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'app_button.dart';
import 'app_text.dart';

/// Custom Dialog Widget - Reusable dialog components
/// Usage: AppDialog.show(context, title: 'Title', content: yourWidget)
///        AppDialog.confirm(context, title: 'Confirm', message: 'Are you sure?')
class AppDialog {
  AppDialog._();

  /// Show a custom dialog
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    List<Widget>? actions,
    bool barrierDismissible = true,
    double? width,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => _DialogContent(
        title: title,
        content: content,
        actions: actions,
        width: width,
      ),
    );
  }

  /// Show a confirmation dialog
  static Future<bool?> confirm({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDangerous = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => _DialogContent(
        title: title,
        content: AppText.body(message),
        actions: [
          AppButton.text(
            text: cancelText,
            onPressed: () => Navigator.of(context).pop(false),
          ),
          AppButton.primary(
            text: confirmText,
            onPressed: () => Navigator.of(context).pop(true),
            backgroundColor: isDangerous ? AppColors.error : null,
          ),
        ],
      ),
    );
  }

  /// Show an alert dialog
  static Future<void> alert({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => _DialogContent(
        title: title,
        content: AppText.body(message),
        actions: [
          AppButton.primary(
            text: buttonText,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  /// Show a success dialog
  static Future<void> success({
    required BuildContext context,
    required String title,
    String? message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => _DialogContent(
        title: title,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: AppColors.success, size: 64),
            if (message != null) ...[
              const SizedBox(height: 16),
              AppText.body(message, textAlign: TextAlign.center),
            ],
          ],
        ),
        actions: [
          AppButton.primary(
            text: buttonText,
            onPressed: () {
              Navigator.of(context).pop();
              onPressed?.call();
            },
          ),
        ],
      ),
    );
  }

  /// Show an error dialog
  static Future<void> error({
    required BuildContext context,
    required String title,
    String? message,
    String buttonText = 'OK',
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => _DialogContent(
        title: title,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, color: AppColors.error, size: 64),
            if (message != null) ...[
              const SizedBox(height: 16),
              AppText.body(message, textAlign: TextAlign.center),
            ],
          ],
        ),
        actions: [
          AppButton.primary(
            text: buttonText,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  /// Show a loading dialog
  static Future<void> loading({
    required BuildContext context,
    String? message,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: _DialogContent(
          title: '',
          showTitle: false,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
              if (message != null) ...[
                const SizedBox(height: 16),
                AppText.body(message),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Hide the current dialog
  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class _DialogContent extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;
  final double? width;
  final bool showTitle;

  const _DialogContent({
    required this.title,
    required this.content,
    this.actions,
    this.width,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: width ?? 320,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showTitle && title.isNotEmpty) ...[
              AppText.h5(title, textAlign: TextAlign.center),
              const SizedBox(height: 16),
            ],
            content,
            if (actions != null && actions!.isNotEmpty) ...[
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!
                    .map(
                      (action) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: action,
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
