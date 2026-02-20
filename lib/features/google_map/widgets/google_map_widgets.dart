import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/widgets.dart';
import '../controller/google_map_controller.dart';

/// Map Placeholder Widget (Replace with actual Google Maps widget)
class MapPlaceholder extends StatelessWidget {
  const MapPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.border.withOpacity(0.3),
      child: Stack(
        children: [
          // Grid pattern to simulate map
          CustomPaint(size: Size.infinite, painter: _GridPainter()),
          // Center marker
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, size: 48, color: AppColors.primary),
                const SizedBox(height: 8),
                AppCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: AppText.caption(
                    'Google Maps Placeholder',
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border.withOpacity(0.5)
      ..strokeWidth = 1;

    const spacing = 50.0;

    // Vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Location Info Card Widget
class LocationInfoCard extends StatelessWidget {
  final LocationData location;
  final VoidCallback? onDirections;
  final VoidCallback? onShare;

  const LocationInfoCard({
    super.key,
    required this.location,
    this.onDirections,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      elevation: AppCardElevation.high,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.location_on, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.body(
                      location.name ?? 'Selected Location',
                      fontWeight: FontWeight.w600,
                    ),
                    if (location.address != null)
                      AppText.caption(
                        location.address!,
                        color: AppColors.textSecondary,
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppText.caption(
            'Lat: ${location.latitude.toStringAsFixed(4)}, Lng: ${location.longitude.toStringAsFixed(4)}',
            color: AppColors.textMuted,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppButton.primary(
                  text: 'Directions',
                  onPressed: onDirections,
                  icon: Icons.directions,
                  size: AppButtonSize.small,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton.outline(
                  text: 'Share',
                  onPressed: onShare,
                  icon: Icons.share,
                  size: AppButtonSize.small,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Map Zoom Controls Widget
class MapZoomControls extends StatelessWidget {
  final VoidCallback? onZoomIn;
  final VoidCallback? onZoomOut;

  const MapZoomControls({super.key, this.onZoomIn, this.onZoomOut});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIconButton(icon: Icons.add, onPressed: onZoomIn, size: 40),
          const Divider(height: 1),
          AppIconButton(icon: Icons.remove, onPressed: onZoomOut, size: 40),
        ],
      ),
    );
  }
}

/// Current Location Button Widget
class MapCurrentLocationButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const MapCurrentLocationButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(4),
      child: AppIconButton(
        icon: Icons.my_location,
        onPressed: onPressed,
        iconColor: AppColors.primary,
        size: 44,
      ),
    );
  }
}

/// Map Markers Button Widget
class MapMarkersButton extends StatelessWidget {
  final int count;
  final VoidCallback? onPressed;

  const MapMarkersButton({super.key, required this.count, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.place, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          AppText.body('$count markers', fontWeight: FontWeight.w500),
        ],
      ),
    );
  }
}

/// Map Search Sheet Widget
class MapSearchSheet extends StatelessWidget {
  const MapSearchSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppTextField.text(
              hintText: 'Search for a location...',
              prefixIcon: Icons.search,
              autofocus: true,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return AppListTile(
                  title: 'Location ${index + 1}',
                  subtitle: '123 Sample Street, City',
                  leadingIcon: Icons.location_on_outlined,
                  onTap: () => Navigator.pop(context),
                  showDivider: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Map Type Sheet Widget
class MapTypeSheet extends StatelessWidget {
  const MapTypeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          AppText.h5('Map Type'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MapTypeOption(
                icon: Icons.map,
                label: 'Default',
                isSelected: true,
                onTap: () => Navigator.pop(context),
              ),
              _MapTypeOption(
                icon: Icons.satellite_alt,
                label: 'Satellite',
                isSelected: false,
                onTap: () => Navigator.pop(context),
              ),
              _MapTypeOption(
                icon: Icons.terrain,
                label: 'Terrain',
                isSelected: false,
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _MapTypeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const _MapTypeOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.1)
                  : AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.border,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          AppText.caption(
            label,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ],
      ),
    );
  }
}

/// Markers List Sheet Widget
class MarkersListSheet extends StatelessWidget {
  final List markers;

  const MarkersListSheet({super.key, required this.markers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          AppText.h5('Markers (${markers.length})'),
          const SizedBox(height: 16),
          if (markers.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: AppEmptyState.noData(
                  title: 'No Markers',
                  message: 'Add markers to see them here',
                ),
              ),
            )
          else
            ...markers.map(
              (marker) => AppListTile(
                title: marker.title,
                subtitle: marker.snippet ?? 'No description',
                leadingIcon: Icons.location_on,
                onTap: () => Navigator.pop(context),
                showDivider: true,
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
