import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_text.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

/// Map View Screen - Displays the map with markers
class MapViewScreen extends ConsumerStatefulWidget {
  const MapViewScreen({super.key});

  @override
  ConsumerState<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends ConsumerState<MapViewScreen> {
  @override
  void initState() {
    super.initState();
    // Load markers when screen opens
    Future.microtask(() {
      ref.read(mapViewControllerProvider.notifier).loadMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(mapViewControllerProvider);
    final mapController = ref.read(mapViewControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: AppText.h5('Map View'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Show search
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Show filters
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Map Placeholder (replace with actual map package like google_maps_flutter)
          Container(
            color: AppColors.background,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 64,
                    color: AppColors.primary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  AppText.h5('Map View', color: AppColors.textSecondary),
                  const SizedBox(height: 8),
                  AppText.body(
                    'Integrate google_maps_flutter or\nflutter_map package here',
                    textAlign: TextAlign.center,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(height: 24),
                  AppText.caption(
                    'Zoom Level: ${mapState.zoomLevel.toStringAsFixed(1)}',
                  ),
                ],
              ),
            ),
          ),

          // Loading Overlay
          if (mapState.isLoading)
            Container(
              color: AppColors.surface.withValues(alpha: 0.7),
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),

          // Markers List (for demo purposes)
          if (!mapState.isLoading && mapState.markers.isNotEmpty)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText.label('${mapState.markers.length} Locations'),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: mapState.markers.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final marker = mapState.markers[index];
                          final isSelected =
                              mapState.selectedMarker?.id == marker.id;
                          return GestureDetector(
                            onTap: () => mapController.selectMarker(marker),
                            child: Chip(
                              label: Text(marker.title),
                              backgroundColor: isSelected
                                  ? AppColors.primary
                                  : AppColors.background,
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? AppColors.textLight
                                    : AppColors.textPrimary,
                                fontSize: 12,
                              ),
                              side: BorderSide(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.border,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Zoom Controls
          Positioned(
            right: 16,
            bottom: mapState.selectedMarker != null ? 220 : 100,
            child: MapZoomControls(
              onZoomIn: mapController.zoomIn,
              onZoomOut: mapController.zoomOut,
              onMyLocation: () {
                // Get current location
                mapController.updateLocation(const Offset(37.7749, -122.4194));
              },
            ),
          ),

          // Selected Marker Info Card
          if (mapState.selectedMarker != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: MapInfoCard(
                marker: mapState.selectedMarker!,
                onClose: () => mapController.selectMarker(null),
                onNavigate: () {
                  // Open navigation
                },
              ),
            ),

          // Error Message
          if (mapState.error != null)
            Positioned(
              top: 100,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.error),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: AppColors.error),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppText.bodySmall(
                        mapState.error!,
                        color: AppColors.error,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      color: AppColors.error,
                      onPressed: mapController.clearError,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new marker
          mapController.addMarker(
            MapMarker(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              latitude: 51.5074,
              longitude: -0.1278,
              title: 'New Location',
              description: 'Added manually',
            ),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_location_alt, color: AppColors.textLight),
      ),
    );
  }
}
