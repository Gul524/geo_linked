import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Map marker model
class MapMarker {
  final String id;
  final double latitude;
  final double longitude;
  final String title;
  final String? description;

  const MapMarker({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.title,
    this.description,
  });

  MapMarker copyWith({
    String? id,
    double? latitude,
    double? longitude,
    String? title,
    String? description,
  }) {
    return MapMarker(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}

/// Map View feature state
class MapViewState {
  final bool isLoading;
  final String? error;
  final List<MapMarker> markers;
  final MapMarker? selectedMarker;
  final Offset? currentLocation;
  final double zoomLevel;

  const MapViewState({
    this.isLoading = false,
    this.error,
    this.markers = const [],
    this.selectedMarker,
    this.currentLocation,
    this.zoomLevel = 15.0,
  });

  MapViewState copyWith({
    bool? isLoading,
    String? error,
    List<MapMarker>? markers,
    MapMarker? selectedMarker,
    Offset? currentLocation,
    double? zoomLevel,
  }) {
    return MapViewState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      markers: markers ?? this.markers,
      selectedMarker: selectedMarker,
      currentLocation: currentLocation ?? this.currentLocation,
      zoomLevel: zoomLevel ?? this.zoomLevel,
    );
  }
}

/// Map View Controller - Manages the map state
class MapViewController extends StateNotifier<MapViewState> {
  MapViewController() : super(const MapViewState());

  /// Load markers
  Future<void> loadMarkers() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Sample markers
      final markers = [
        const MapMarker(
          id: '1',
          latitude: 37.7749,
          longitude: -122.4194,
          title: 'San Francisco',
          description: 'Golden Gate City',
        ),
        const MapMarker(
          id: '2',
          latitude: 34.0522,
          longitude: -118.2437,
          title: 'Los Angeles',
          description: 'City of Angels',
        ),
        const MapMarker(
          id: '3',
          latitude: 40.7128,
          longitude: -74.0060,
          title: 'New York',
          description: 'The Big Apple',
        ),
      ];

      state = state.copyWith(isLoading: false, markers: markers);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load markers: $e',
      );
    }
  }

  /// Add marker
  void addMarker(MapMarker marker) {
    state = state.copyWith(markers: [...state.markers, marker]);
  }

  /// Remove marker
  void removeMarker(String markerId) {
    state = state.copyWith(
      markers: state.markers.where((m) => m.id != markerId).toList(),
    );
  }

  /// Select marker
  void selectMarker(MapMarker? marker) {
    state = state.copyWith(selectedMarker: marker);
  }

  /// Update current location
  void updateLocation(Offset location) {
    state = state.copyWith(currentLocation: location);
  }

  /// Set zoom level
  void setZoomLevel(double zoom) {
    state = state.copyWith(zoomLevel: zoom.clamp(1.0, 20.0));
  }

  /// Zoom in
  void zoomIn() {
    setZoomLevel(state.zoomLevel + 1);
  }

  /// Zoom out
  void zoomOut() {
    setZoomLevel(state.zoomLevel - 1);
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Map View Controller Provider
final mapViewControllerProvider =
    StateNotifierProvider<MapViewController, MapViewState>((ref) {
      return MapViewController();
    });
