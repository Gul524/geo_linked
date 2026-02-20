import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'app_text.dart';

/// Loading indicator size variants
enum AppLoadingSize { small, medium, large }

/// Custom Loading Widget - Reusable loading indicators
/// Usage: AppLoading()
///        AppLoading.overlay()
///        AppLoading.withText(text: 'Loading...')
class AppLoading extends StatelessWidget {
  final AppLoadingSize size;
  final Color? color;
  final String? text;
  final double? strokeWidth;

  const AppLoading._({
    this.size = AppLoadingSize.medium,
    this.color,
    this.text,
    this.strokeWidth,
  });

  /// Standard circular loading indicator
  factory AppLoading({
    AppLoadingSize size = AppLoadingSize.medium,
    Color? color,
    double? strokeWidth,
  }) {
    return AppLoading._(size: size, color: color, strokeWidth: strokeWidth);
  }

  /// Loading indicator with text
  factory AppLoading.withText({
    required String text,
    AppLoadingSize size = AppLoadingSize.medium,
    Color? color,
  }) {
    return AppLoading._(size: size, color: color, text: text);
  }

  double get _size {
    switch (size) {
      case AppLoadingSize.small:
        return 20;
      case AppLoadingSize.medium:
        return 36;
      case AppLoadingSize.large:
        return 48;
    }
  }

  double get _strokeWidth {
    if (strokeWidth != null) return strokeWidth!;
    switch (size) {
      case AppLoadingSize.small:
        return 2;
      case AppLoadingSize.medium:
        return 3;
      case AppLoadingSize.large:
        return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = SizedBox(
      width: _size,
      height: _size,
      child: CircularProgressIndicator(
        strokeWidth: _strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
      ),
    );

    if (text != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          loadingIndicator,
          const SizedBox(height: 16),
          AppText.body(text!, color: AppColors.textSecondary),
        ],
      );
    }

    return loadingIndicator;
  }
}

/// Full screen loading overlay
class AppLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? loadingText;
  final Color? backgroundColor;

  const AppLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.loadingText,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: backgroundColor ?? Colors.black.withOpacity(0.3),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: loadingText != null
                    ? AppLoading.withText(text: loadingText!)
                    : const AppLoading._(),
              ),
            ),
          ),
      ],
    );
  }
}

/// Shimmer loading placeholder
class AppShimmer extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const AppShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(_animation.value, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: const [
                Color(0xFFE0E0E0),
                Color(0xFFF5F5F5),
                Color(0xFFE0E0E0),
              ],
            ),
          ),
        );
      },
    );
  }
}
