import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_text.dart';
import '../controller/map_view_controller.dart';

/// Map Marker Pin Widget
class MapMarkerPin extends StatelessWidget {
  final MapMarker marker;
  final bool isSelected;
  final VoidCallback? onTap;

  const MapMarkerPin({
    super.key,
    required this.marker,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: isSelected ? 8 : 4,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: 1,
                ),
              ),
              child: AppText.labelSmall(
                marker.title,
                color: isSelected ? AppColors.textLight : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Icon(
              Icons.location_on,
              color: isSelected ? AppColors.primary : AppColors.secondary,
              size: isSelected ? 36 : 28,
            ),
          ],
        ),
      ),
    );
  }
}

/// Map Info Card Widget
class MapInfoCard extends StatelessWidget {
  final MapMarker marker;
  final VoidCallback? onClose;
  final VoidCallback? onNavigate;

  const MapInfoCard({
    super.key,
    required this.marker,
    this.onClose,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.h6(marker.title),
                    if (marker.description != null)
                      AppText.caption(marker.description!),
                  ],
                ),
              ),
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close),
                iconSize: 20,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.my_location,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              AppText.bodySmall(
                '${marker.latitude.toStringAsFixed(4)}, ${marker.longitude.toStringAsFixed(4)}',
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onNavigate,
              icon: const Icon(Icons.directions, size: 18),
              label: const Text('Navigate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textLight,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Zoom Controls Widget
class MapZoomControls extends StatelessWidget {
  final VoidCallback? onZoomIn;
  final VoidCallback? onZoomOut;
  final VoidCallback? onMyLocation;

  const MapZoomControls({
    super.key,
    this.onZoomIn,
    this.onZoomOut,
    this.onMyLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ZoomButton(
            icon: Icons.add,
            onPressed: onZoomIn,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          const Divider(height: 1, thickness: 1),
          _ZoomButton(icon: Icons.remove, onPressed: onZoomOut),
          const Divider(height: 1, thickness: 1),
          _ZoomButton(
            icon: Icons.my_location,
            onPressed: onMyLocation,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}

class _ZoomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final BorderRadius? borderRadius;

  const _ZoomButton({required this.icon, this.onPressed, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: AppColors.textPrimary, size: 22),
        ),
      ),
    );
  }
}
