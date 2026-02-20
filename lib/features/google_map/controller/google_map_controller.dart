import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Location model
class LocationData {
  final double latitude;
  final double longitude;
  final String? address;
  final String? name;

  const LocationData({
    required this.latitude,
    required this.longitude,
    this.address,
    this.name,
  });

  LocationData copyWith({
    double? latitude,
    double? longitude,
    String? address,
    String? name,
  }) {
    return LocationData(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      name: name ?? this.name,
    );
  }
}

/// Marker model
class MapMarker {
  final String id;
  final LocationData location;
  final String title;
  final String? snippet;

  const MapMarker({
    required this.id,
    required this.location,
    required this.title,
    this.snippet,
  });
}

/// Google Map feature state
class GoogleMapState {
  final bool isLoading;
  final String? error;
  final LocationData? currentLocation;
  final LocationData? selectedLocation;
  final List<MapMarker> markers;
  final double zoom;
  final bool isMapReady;
  final bool isLocationPermissionGranted;

  const GoogleMapState({
    this.isLoading = false,
    this.error,
    this.currentLocation,
    this.selectedLocation,
    this.markers = const [],
    this.zoom = 15.0,
    this.isMapReady = false,
    this.isLocationPermissionGranted = false,
  });

  GoogleMapState copyWith({
    bool? isLoading,
    String? error,
    LocationData? currentLocation,
    LocationData? selectedLocation,
    List<MapMarker>? markers,
    double? zoom,
    bool? isMapReady,
    bool? isLocationPermissionGranted,
  }) {
    return GoogleMapState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentLocation: currentLocation ?? this.currentLocation,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      markers: markers ?? this.markers,
      zoom: zoom ?? this.zoom,
      isMapReady: isMapReady ?? this.isMapReady,
      isLocationPermissionGranted:
          isLocationPermissionGranted ?? this.isLocationPermissionGranted,
    );
  }
}

/// Google Map Controller - Manages the state of the map screen
class GoogleMapController extends StateNotifier<GoogleMapState> {
  GoogleMapController() : super(const GoogleMapState());

  /// Initialize map and get current location
  Future<void> initialize() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // TODO: Implement actual location permission and fetching
      await Future.delayed(const Duration(seconds: 1));

      // Default location (can be replaced with actual GPS location)
      const defaultLocation = LocationData(
        latitude: 37.7749,
        longitude: -122.4194,
        address: 'San Francisco, CA',
        name: 'Current Location',
      );

      state = state.copyWith(
        isLoading: false,
        currentLocation: defaultLocation,
        selectedLocation: defaultLocation,
        isLocationPermissionGranted: true,
        isMapReady: true,
      );

      // Add sample markers
      _addSampleMarkers();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to initialize map: ${e.toString()}',
      );
    }
  }

  void _addSampleMarkers() {
    final sampleMarkers = [
      const MapMarker(
        id: '1',
        location: LocationData(latitude: 37.7749, longitude: -122.4194),
        title: 'San Francisco',
        snippet: 'Golden Gate City',
      ),
      const MapMarker(
        id: '2',
        location: LocationData(latitude: 37.7849, longitude: -122.4094),
        title: 'Downtown SF',
        snippet: 'Business District',
      ),
      const MapMarker(
        id: '3',
        location: LocationData(latitude: 37.7649, longitude: -122.4294),
        title: 'Golden Gate Park',
        snippet: 'Recreation Area',
      ),
    ];

    state = state.copyWith(markers: sampleMarkers);
  }

  /// Set selected location
  void selectLocation(LocationData location) {
    state = state.copyWith(selectedLocation: location);
  }

  /// Add a marker
  void addMarker(MapMarker marker) {
    state = state.copyWith(markers: [...state.markers, marker]);
  }

  /// Remove a marker
  void removeMarker(String markerId) {
    state = state.copyWith(
      markers: state.markers.where((m) => m.id != markerId).toList(),
    );
  }

  /// Clear all markers
  void clearMarkers() {
    state = state.copyWith(markers: []);
  }

  /// Set zoom level
  void setZoom(double zoom) {
    state = state.copyWith(zoom: zoom.clamp(1.0, 20.0));
  }

  /// Zoom in
  void zoomIn() {
    setZoom(state.zoom + 1);
  }

  /// Zoom out
  void zoomOut() {
    setZoom(state.zoom - 1);
  }

  /// Go to current location
  void goToCurrentLocation() {
    if (state.currentLocation != null) {
      state = state.copyWith(selectedLocation: state.currentLocation);
    }
  }

  /// Set error
  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  /// Reset state
  void reset() {
    state = const GoogleMapState();
  }
}

/// Google Map Controller Provider
final googleMapControllerProvider =
    StateNotifierProvider<GoogleMapController, GoogleMapState>(
      (ref) => GoogleMapController(),
    );
