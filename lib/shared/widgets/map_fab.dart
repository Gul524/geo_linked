import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';
import 'glass_container.dart';

/// Expandable FAB for map actions
class MapFab extends StatefulWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback? onBroadcast;
  final VoidCallback? onAsk;

  const MapFab({
    super.key,
    this.isExpanded = false,
    required this.onToggle,
    this.onBroadcast,
    this.onAsk,
  });

  @override
  State<MapFab> createState() => _MapFabState();
}

class _MapFabState extends State<MapFab> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.animationNormal,
    );
    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 0.125,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(MapFab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded && !oldWidget.isExpanded) {
      _controller.forward();
    } else if (!widget.isExpanded && oldWidget.isExpanded) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Expanded options
        ScaleTransition(
          scale: _scaleAnimation,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _FabOption(
                emoji: '📢',
                label: 'Broadcast\n10km',
                onTap: widget.onBroadcast,
              ),
              const SizedBox(width: 12),
              _FabOption(emoji: '❓', label: 'Ask\n300m', onTap: widget.onAsk),
            ],
          ),
        ),
        if (widget.isExpanded) const SizedBox(height: 10),
        // Main FAB button
        GestureDetector(
          onTap: widget.onToggle,
          child: Container(
            width: AppConstants.fabSize,
            height: AppConstants.fabSize,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppConstants.fabBorderRadius),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.45),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Center(
              child: RotationTransition(
                turns: _rotateAnimation,
                child: Icon(
                  widget.isExpanded ? Icons.close : Icons.add,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Individual FAB option button
class _FabOption extends StatelessWidget {
  final String emoji;
  final String label;
  final VoidCallback? onTap;

  const _FabOption({required this.emoji, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: 18,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        backgroundColor: isDark
            ? Colors.black.withValues(alpha: 0.7)
            : Colors.white.withValues(alpha: 0.9),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Simple FAB button
class SimpleFab extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;

  const SimpleFab({
    super.key,
    required this.icon,
    this.onTap,
    this.size = AppConstants.fabSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(AppConstants.fabBorderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.45),
              blurRadius: 32,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Center(child: Icon(icon, color: Colors.white, size: 28)),
      ),
    );
  }
}
