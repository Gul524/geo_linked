import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';

/// Alert banner widget for showing important notifications
/// Appears at the top of the screen with a colored background
class AlertBanner extends StatefulWidget {
  final String message;
  final String? emoji;
  final Color backgroundColor;
  final Duration? animationDuration;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  const AlertBanner({
    super.key,
    required this.message,
    this.emoji,
    this.backgroundColor = AppColors.error,
    this.animationDuration,
    this.onTap,
    this.onDismiss,
  });

  /// Factory for road block alert
  factory AlertBanner.roadBlock({
    required String message,
    VoidCallback? onTap,
    VoidCallback? onDismiss,
  }) {
    return AlertBanner(
      message: message,
      emoji: '🚧',
      backgroundColor: AppColors.error.withValues(alpha: 0.92),
      onTap: onTap,
      onDismiss: onDismiss,
    );
  }

  /// Factory for traffic alert
  factory AlertBanner.traffic({
    required String message,
    VoidCallback? onTap,
    VoidCallback? onDismiss,
  }) {
    return AlertBanner(
      message: message,
      emoji: '🚦',
      backgroundColor: AppColors.warning.withValues(alpha: 0.92),
      onTap: onTap,
      onDismiss: onDismiss,
    );
  }

  /// Factory for safety alert
  factory AlertBanner.safety({
    required String message,
    VoidCallback? onTap,
    VoidCallback? onDismiss,
  }) {
    return AlertBanner(
      message: message,
      emoji: '⚠️',
      backgroundColor: AppColors.error.withValues(alpha: 0.92),
      onTap: onTap,
      onDismiss: onDismiss,
    );
  }

  @override
  State<AlertBanner> createState() => _AlertBannerState();
}

class _AlertBannerState extends State<AlertBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? AppConstants.animationNormal,
    );

    _slideAnimation = Tween<double>(
      begin: -50,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(opacity: _fadeAnimation.value, child: child),
        );
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: widget.backgroundColor.withValues(alpha: 0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.emoji != null) ...[
                    Text(widget.emoji!, style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 10),
                  ],
                  Flexible(
                    child: Text(
                      widget.message,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
