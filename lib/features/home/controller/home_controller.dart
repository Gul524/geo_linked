import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Filter category for map markers
enum FilterCategory {
  traffic('Traffic', '🚗'),
  safety('Safety', '⚠️'),
  market('Market', '🏪'),
  utility('Utility', '🔧'),
  event('Events', '🎉'),
  question('Questions', '❓');

  final String label;
  final String emoji;
  const FilterCategory(this.label, this.emoji);
}

/// Map marker data model
class MapMarkerData {
  final String id;
  final double lat;
  final double lng;
  final FilterCategory category;
  final String title;
  final String? subtitle;
  final DateTime timestamp;
  final int responseCount;

  const MapMarkerData({
    required this.id,
    required this.lat,
    required this.lng,
    required this.category,
    required this.title,
    this.subtitle,
    required this.timestamp,
    this.responseCount = 0,
  });
}

/// Bottom navigation tab
enum NavTab { map, feed, add, chat, profile }

/// Home feature state
class HomeState {
  final bool isLoading;
  final String? error;
  final String searchQuery;
  final Set<FilterCategory> activeFilters;
  final List<MapMarkerData> markers;
  final NavTab currentTab;
  final bool isFabExpanded;
  final double userLat;
  final double userLng;
  final int askRadius; // in meters
  final bool showRadiusCircle;

  const HomeState({
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
    this.activeFilters = const {},
    this.markers = const [],
    this.currentTab = NavTab.map,
    this.isFabExpanded = false,
    this.userLat = 37.7749,
    this.userLng = -122.4194,
    this.askRadius = 300,
    this.showRadiusCircle = false,
  });

  HomeState copyWith({
    bool? isLoading,
    String? error,
    String? searchQuery,
    Set<FilterCategory>? activeFilters,
    List<MapMarkerData>? markers,
    NavTab? currentTab,
    bool? isFabExpanded,
    double? userLat,
    double? userLng,
    int? askRadius,
    bool? showRadiusCircle,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      searchQuery: searchQuery ?? this.searchQuery,
      activeFilters: activeFilters ?? this.activeFilters,
      markers: markers ?? this.markers,
      currentTab: currentTab ?? this.currentTab,
      isFabExpanded: isFabExpanded ?? this.isFabExpanded,
      userLat: userLat ?? this.userLat,
      userLng: userLng ?? this.userLng,
      askRadius: askRadius ?? this.askRadius,
      showRadiusCircle: showRadiusCircle ?? this.showRadiusCircle,
    );
  }

  /// Get filtered markers based on active filters
  List<MapMarkerData> get filteredMarkers {
    if (activeFilters.isEmpty) return markers;
    return markers.where((m) => activeFilters.contains(m.category)).toList();
  }
}

/// Home Controller - Manages the state of the home map screen
class HomeController extends StateNotifier<HomeState> {
  HomeController() : super(const HomeState()) {
    _loadInitialData();
  }

  /// Load initial markers and data
  Future<void> _loadInitialData() async {
    state = state.copyWith(isLoading: true);

    // Simulate loading markers
    await Future.delayed(const Duration(milliseconds: 500));

    final markers = [
      MapMarkerData(
        id: '1',
        lat: 37.7749,
        lng: -122.4194,
        category: FilterCategory.traffic,
        title: 'Heavy traffic on Market St',
        subtitle: '15 min delay expected',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        responseCount: 12,
      ),
      MapMarkerData(
        id: '2',
        lat: 37.7760,
        lng: -122.4180,
        category: FilterCategory.safety,
        title: 'Road closure ahead',
        subtitle: 'Construction work',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        responseCount: 8,
      ),
      MapMarkerData(
        id: '3',
        lat: 37.7735,
        lng: -122.4210,
        category: FilterCategory.market,
        title: 'Farmers market today',
        subtitle: 'Fresh produce available',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        responseCount: 24,
      ),
      MapMarkerData(
        id: '4',
        lat: 37.7770,
        lng: -122.4160,
        category: FilterCategory.question,
        title: 'Best coffee shop nearby?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        responseCount: 5,
      ),
    ];

    state = state.copyWith(isLoading: false, markers: markers);
  }

  /// Update search query
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  /// Toggle filter category
  void toggleFilter(FilterCategory category) {
    final newFilters = Set<FilterCategory>.from(state.activeFilters);
    if (newFilters.contains(category)) {
      newFilters.remove(category);
    } else {
      newFilters.add(category);
    }
    state = state.copyWith(activeFilters: newFilters);
  }

  /// Clear all filters
  void clearFilters() {
    state = state.copyWith(activeFilters: {});
  }

  /// Set current navigation tab
  void setTab(NavTab tab) {
    state = state.copyWith(currentTab: tab);
  }

  /// Toggle FAB expanded state
  void toggleFab() {
    state = state.copyWith(isFabExpanded: !state.isFabExpanded);
  }

  /// Close FAB
  void closeFab() {
    state = state.copyWith(isFabExpanded: false);
  }

  /// Update ask radius
  void setAskRadius(int radius) {
    state = state.copyWith(askRadius: radius);
  }

  /// Toggle radius circle visibility
  void toggleRadiusCircle() {
    state = state.copyWith(showRadiusCircle: !state.showRadiusCircle);
  }

  /// Update user location
  void setUserLocation(double lat, double lng) {
    state = state.copyWith(userLat: lat, userLng: lng);
  }

  /// Refresh markers
  Future<void> refreshMarkers() async {
    await _loadInitialData();
  }

  /// Set loading state
  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  /// Set error
  void setError(String? error) {
    state = state.copyWith(error: error);
  }
}

/// Home Controller Provider
final homeControllerProvider = StateNotifierProvider<HomeController, HomeState>(
  (ref) => HomeController(),
);
