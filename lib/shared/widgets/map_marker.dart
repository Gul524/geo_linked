import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';

/// Marker type for different alert categories
enum MarkerType { traffic, safety, market, utility }

/// Map marker widget used on the map view
/// Displays an emoji icon with a colored background and pointer
class MapMarker extends StatelessWidget {
  final MarkerType type;
  final String emoji;
  final double size;
  final VoidCallback? onTap;
  final bool showPointer;

  const MapMarker({
    super.key,
    required this.type,
    required this.emoji,
    this.size = AppConstants.markerSize,
    this.onTap,
    this.showPointer = true,
  });

  Color get _backgroundColor {
    switch (type) {
      case MarkerType.traffic:
        return AppColors.markerTraffic;
      case MarkerType.safety:
        return AppColors.markerSafety;
      case MarkerType.market:
        return AppColors.markerMarket;
      case MarkerType.utility:
        return AppColors.markerUtility;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(AppConstants.radiusMarker),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(emoji, style: TextStyle(fontSize: size * 0.45)),
            ),
          ),
          if (showPointer)
            CustomPaint(
              size: const Size(12, 8),
              painter: _MarkerPointerPainter(color: _backgroundColor),
            ),
        ],
      ),
    );
  }

  /// Factory for traffic marker
  factory MapMarker.traffic({
    double size = AppConstants.markerSize,
    VoidCallback? onTap,
  }) {
    return MapMarker(
      type: MarkerType.traffic,
      emoji: '🚗',
      size: size,
      onTap: onTap,
    );
  }

  /// Factory for safety marker
  factory MapMarker.safety({
    double size = AppConstants.markerSize,
    VoidCallback? onTap,
  }) {
    return MapMarker(
      type: MarkerType.safety,
      emoji: '⚠️',
      size: size,
      onTap: onTap,
    );
  }

  /// Factory for market marker
  factory MapMarker.market({
    double size = AppConstants.markerSize,
    VoidCallback? onTap,
  }) {
    return MapMarker(
      type: MarkerType.market,
      emoji: '🛍️',
      size: size,
      onTap: onTap,
    );
  }

  /// Factory for utility marker
  factory MapMarker.utility({
    double size = AppConstants.markerSize,
    VoidCallback? onTap,
  }) {
    return MapMarker(
      type: MarkerType.utility,
      emoji: '⚡',
      size: size,
      onTap: onTap,
    );
  }
}

/// Custom painter for the marker pointer triangle
class _MarkerPointerPainter extends CustomPainter {
  final Color color;

  _MarkerPointerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);
    path.close();

    // Draw shadow
    canvas.drawPath(path.shift(const Offset(0, 2)), shadowPaint);
    // Draw pointer
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
