import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/widgets.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

/// Google Map View - Main map screen
class GoogleMapView extends ConsumerStatefulWidget {
  const GoogleMapView({super.key});

  @override
  ConsumerState<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends ConsumerState<GoogleMapView> {
  @override
  void initState() {
    super.initState();
    // Initialize map when view loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(googleMapControllerProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(googleMapControllerProvider);
    final mapController = ref.read(googleMapControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: AppText.h5('Map'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _showSearchBottomSheet(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.layers_outlined),
            onPressed: () {
              _showMapTypeBottomSheet(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Map Placeholder (Replace with actual Google Map widget)
          if (mapState.isLoading)
            Center(child: AppLoading())
          else if (mapState.error != null)
            Center(
              child: AppEmptyState.error(
                title: 'Map Error',
                message: mapState.error,
                buttonText: 'Retry',
                onButtonPressed: mapController.initialize,
              ),
            )
          else
            const MapPlaceholder(),

          // Location info card at bottom
          if (mapState.selectedLocation != null)
            Positioned(
              left: 16,
              right: 16,
              bottom: 100,
              child: LocationInfoCard(
                location: mapState.selectedLocation!,
                onDirections: () {
                  AppSnackbar.info(context, message: 'Opening directions...');
                },
                onShare: () {
                  AppSnackbar.success(context, message: 'Location shared!');
                },
              ),
            ),

          // Zoom controls
          Positioned(
            right: 16,
            bottom: 220,
            child: MapZoomControls(
              onZoomIn: mapController.zoomIn,
              onZoomOut: mapController.zoomOut,
            ),
          ),

          // Current location button
          Positioned(
            right: 16,
            bottom: 320,
            child: MapCurrentLocationButton(
              onPressed: mapController.goToCurrentLocation,
            ),
          ),

          // Markers list button
          Positioned(
            left: 16,
            bottom: 220,
            child: MapMarkersButton(
              count: mapState.markers.length,
              onPressed: () {
                _showMarkersBottomSheet(context, mapState.markers);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const MapSearchSheet(),
    );
  }

  void _showMapTypeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const MapTypeSheet(),
    );
  }

  void _showMarkersBottomSheet(BuildContext context, List markers) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => MarkersListSheet(markers: markers),
    );
  }
}
