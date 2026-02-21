import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/map_marker.dart';
import '../controller/onboarding_controller.dart';

/// Map preview illustration for onboarding
class OnboardingMapPreview extends StatelessWidget {
  final List<OnboardingMarker> markers;

  const OnboardingMapPreview({super.key, required this.markers});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 310,
      height: 260,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1A2332), const Color(0xFF1E2836)]
              : [const Color(0xFFE8F1FF), const Color(0xFFD4E8FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Grid
          const _MapGrid(),
          // Roads
          _MapRoad(isVertical: false, position: 0.5, thickness: 10),
          _MapRoad(isVertical: true, position: 0.4, thickness: 10),
          _MapRoad(isVertical: false, position: 0.3, thickness: 6),
          _MapRoad(isVertical: true, position: 0.7, thickness: 6),
          // Markers
          ...markers.map(
            (marker) => Positioned(
              top: marker.topPercent * 260,
              left: marker.leftPercent * 310,
              child: Transform.translate(
                offset: const Offset(-17, -17),
                child: MapMarker(
                  type: _getMarkerType(marker.type),
                  emoji: marker.emoji,
                  size: 34,
                ),
              ),
            ),
          ),
          // Chat bubble
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                'Road clear? 🤔',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  MarkerType _getMarkerType(OnboardingMarkerType type) {
    switch (type) {
      case OnboardingMarkerType.traffic:
        return MarkerType.traffic;
      case OnboardingMarkerType.safety:
        return MarkerType.safety;
      case OnboardingMarkerType.market:
        return MarkerType.market;
    }
  }
}

/// Map grid pattern
class _MapGrid extends StatelessWidget {
  const _MapGrid();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lineColor = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : AppColors.primary.withValues(alpha: 0.07);

    return CustomPaint(
      size: const Size(310, 260),
      painter: _GridPainter(lineColor: lineColor, spacing: 28),
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color lineColor;
  final double spacing;

  _GridPainter({required this.lineColor, required this.spacing});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1;

    // Horizontal lines
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    // Vertical lines
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Map road element
class _MapRoad extends StatelessWidget {
  final bool isVertical;
  final double position; // 0.0 to 1.0
  final double thickness;

  const _MapRoad({
    required this.isVertical,
    required this.position,
    required this.thickness,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Positioned(
      top: isVertical ? 0 : (260 * position) - (thickness / 2),
      bottom: isVertical ? 0 : null,
      left: isVertical ? (310 * position) - (thickness / 2) : 0,
      right: isVertical ? null : 0,
      child: Container(
        width: isVertical ? thickness : null,
        height: isVertical ? null : thickness,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.7)
              : Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(thickness / 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}

/// Page dots indicator
class OnboardingDots extends StatelessWidget {
  final int totalPages;
  final int currentPage;

  const OnboardingDots({
    super.key,
    required this.totalPages,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: AppConstants.animationNormal,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 20 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary
                : (isDark
                      ? AppColors.textTertiaryDark
                      : AppColors.textTertiary),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}
