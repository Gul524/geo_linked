import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Alert type for feed items
enum AlertType {
  traffic('Traffic', '🚗', 0xFFF5A623),
  safety('Safety', '⚠️', 0xFFE53935),
  market('Market', '🏪', 0xFF43A047),
  event('Event', '🎉', 0xFF9C27B0),
  question('Question', '❓', 0xFF0047AB),
  utility('Utility', '🔧', 0xFF039BE5);

  final String label;
  final String emoji;
  final int colorValue;
  const AlertType(this.label, this.emoji, this.colorValue);
}

/// Feed alert data model
class FeedAlert {
  final String id;
  final AlertType type;
  final String title;
  final String? subtitle;
  final String timeAgo;
  final String distance;
  final int responseCount;
  final bool isVerified;
  final String? authorName;

  const FeedAlert({
    required this.id,
    required this.type,
    required this.title,
    this.subtitle,
    required this.timeAgo,
    required this.distance,
    this.responseCount = 0,
    this.isVerified = false,
    this.authorName,
  });
}

/// Broadcast Feed feature state
class BroadcastFeedState {
  final bool isLoading;
  final String? error;
  final List<FeedAlert> alerts;
  final Set<AlertType> activeFilters;
  final int radiusKm;
  final bool isSheetExpanded;

  const BroadcastFeedState({
    this.isLoading = false,
    this.error,
    this.alerts = const [],
    this.activeFilters = const {},
    this.radiusKm = 10,
    this.isSheetExpanded = true,
  });

  BroadcastFeedState copyWith({
    bool? isLoading,
    String? error,
    List<FeedAlert>? alerts,
    Set<AlertType>? activeFilters,
    int? radiusKm,
    bool? isSheetExpanded,
  }) {
    return BroadcastFeedState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      alerts: alerts ?? this.alerts,
      activeFilters: activeFilters ?? this.activeFilters,
      radiusKm: radiusKm ?? this.radiusKm,
      isSheetExpanded: isSheetExpanded ?? this.isSheetExpanded,
    );
  }

  /// Get filtered alerts
  List<FeedAlert> get filteredAlerts {
    if (activeFilters.isEmpty) return alerts;
    return alerts.where((a) => activeFilters.contains(a.type)).toList();
  }

  /// Formatted radius
  String get radiusFormatted => '${radiusKm}km';
}

/// Broadcast Feed Controller
class BroadcastFeedController extends StateNotifier<BroadcastFeedState> {
  BroadcastFeedController() : super(const BroadcastFeedState()) {
    _loadAlerts();
  }

  /// Load alerts from API
  Future<void> _loadAlerts() async {
    state = state.copyWith(isLoading: true);

    await Future.delayed(const Duration(milliseconds: 500));

    final alerts = [
      const FeedAlert(
        id: '1',
        type: AlertType.traffic,
        title: 'Heavy traffic on Market St',
        subtitle: 'Multiple accidents reported',
        timeAgo: '5m ago',
        distance: '0.3km',
        responseCount: 12,
        isVerified: true,
      ),
      const FeedAlert(
        id: '2',
        type: AlertType.safety,
        title: 'Road closure ahead',
        subtitle: 'Construction work until 6 PM',
        timeAgo: '15m ago',
        distance: '0.5km',
        responseCount: 8,
      ),
      const FeedAlert(
        id: '3',
        type: AlertType.market,
        title: 'Farmers market today!',
        subtitle: 'Fresh produce at Union Square',
        timeAgo: '30m ago',
        distance: '1.2km',
        responseCount: 24,
        isVerified: true,
      ),
      const FeedAlert(
        id: '4',
        type: AlertType.question,
        title: 'Best coffee shop nearby?',
        subtitle: 'Looking for recommendations',
        timeAgo: '1h ago',
        distance: '0.8km',
        responseCount: 5,
        authorName: 'Anonymous',
      ),
      const FeedAlert(
        id: '5',
        type: AlertType.event,
        title: 'Street performance at 3 PM',
        subtitle: 'Live music at the plaza',
        timeAgo: '2h ago',
        distance: '0.4km',
        responseCount: 18,
      ),
      const FeedAlert(
        id: '6',
        type: AlertType.utility,
        title: 'Free WiFi hotspot',
        subtitle: 'Available at community center',
        timeAgo: '3h ago',
        distance: '0.9km',
        responseCount: 32,
        isVerified: true,
      ),
    ];

    state = state.copyWith(isLoading: false, alerts: alerts);
  }

  /// Toggle filter
  void toggleFilter(AlertType type) {
    final newFilters = Set<AlertType>.from(state.activeFilters);
    if (newFilters.contains(type)) {
      newFilters.remove(type);
    } else {
      newFilters.add(type);
    }
    state = state.copyWith(activeFilters: newFilters);
  }

  /// Clear all filters
  void clearFilters() {
    state = state.copyWith(activeFilters: {});
  }

  /// Set radius
  void setRadius(int km) {
    state = state.copyWith(radiusKm: km.clamp(1, 50));
  }

  /// Toggle sheet expanded
  void toggleSheetExpanded() {
    state = state.copyWith(isSheetExpanded: !state.isSheetExpanded);
  }

  /// Refresh alerts
  Future<void> refresh() async {
    await _loadAlerts();
  }

  /// Set error
  void setError(String? error) {
    state = state.copyWith(error: error);
  }
}

/// Broadcast Feed Controller Provider
final broadcastFeedControllerProvider =
    StateNotifierProvider<BroadcastFeedController, BroadcastFeedState>(
      (ref) => BroadcastFeedController(),
    );
