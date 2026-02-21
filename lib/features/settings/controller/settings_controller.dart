import 'package:flutter_riverpod/flutter_riverpod.dart';

/// User profile data
class UserProfile {
  final String id;
  final String name;
  final String username;
  final String? avatarUrl;
  final int reputationScore;
  final int helpfulAnswers;
  final int verifiedInfo;
  final int questionsAsked;
  final DateTime joinedDate;

  const UserProfile({
    required this.id,
    required this.name,
    required this.username,
    this.avatarUrl,
    this.reputationScore = 0,
    this.helpfulAnswers = 0,
    this.verifiedInfo = 0,
    this.questionsAsked = 0,
    required this.joinedDate,
  });

  /// Score percentage for ring visualization (0-100)
  int get scorePercentage =>
      (reputationScore / 1000 * 100).clamp(0, 100).toInt();

  /// Score level
  String get level {
    if (reputationScore >= 800) return 'Expert';
    if (reputationScore >= 500) return 'Trusted';
    if (reputationScore >= 200) return 'Active';
    return 'New';
  }
}

/// Settings state
class SettingsState {
  final bool isLoading;
  final String? error;
  final UserProfile? profile;
  final bool isDarkMode;
  final bool notificationsEnabled;
  final bool locationEnabled;
  final bool nearbyAlertsEnabled;
  final bool chatMessagesEnabled;
  final bool communityUpdatesEnabled;
  final int alertRadius; // in meters
  final String language;

  const SettingsState({
    this.isLoading = false,
    this.error,
    this.profile,
    this.isDarkMode = false,
    this.notificationsEnabled = true,
    this.locationEnabled = true,
    this.nearbyAlertsEnabled = true,
    this.chatMessagesEnabled = true,
    this.communityUpdatesEnabled = false,
    this.alertRadius = 500,
    this.language = 'en',
  });

  SettingsState copyWith({
    bool? isLoading,
    String? error,
    UserProfile? profile,
    bool? isDarkMode,
    bool? notificationsEnabled,
    bool? locationEnabled,
    bool? nearbyAlertsEnabled,
    bool? chatMessagesEnabled,
    bool? communityUpdatesEnabled,
    int? alertRadius,
    String? language,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      profile: profile ?? this.profile,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      locationEnabled: locationEnabled ?? this.locationEnabled,
      nearbyAlertsEnabled: nearbyAlertsEnabled ?? this.nearbyAlertsEnabled,
      chatMessagesEnabled: chatMessagesEnabled ?? this.chatMessagesEnabled,
      communityUpdatesEnabled:
          communityUpdatesEnabled ?? this.communityUpdatesEnabled,
      alertRadius: alertRadius ?? this.alertRadius,
      language: language ?? this.language,
    );
  }
}

/// Settings Controller
class SettingsController extends StateNotifier<SettingsState> {
  SettingsController() : super(const SettingsState()) {
    _loadProfile();
  }

  /// Load user profile
  Future<void> _loadProfile() async {
    state = state.copyWith(isLoading: true);

    await Future.delayed(const Duration(milliseconds: 500));

    final profile = UserProfile(
      id: '1',
      name: 'Alex Chen',
      username: '@alexchen',
      reputationScore: 847,
      helpfulAnswers: 156,
      verifiedInfo: 89,
      questionsAsked: 42,
      joinedDate: DateTime.now().subtract(const Duration(days: 180)),
    );

    state = state.copyWith(isLoading: false, profile: profile);
  }

  /// Toggle dark mode
  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  /// Set dark mode
  void setDarkMode(bool value) {
    state = state.copyWith(isDarkMode: value);
  }

  /// Toggle notifications
  void toggleNotifications() {
    state = state.copyWith(notificationsEnabled: !state.notificationsEnabled);
  }

  /// Set notifications
  void setNotifications(bool value) {
    state = state.copyWith(notificationsEnabled: value);
  }

  /// Toggle location
  void toggleLocation() {
    state = state.copyWith(locationEnabled: !state.locationEnabled);
  }

  /// Set location
  void setLocation(bool value) {
    state = state.copyWith(locationEnabled: value);
  }

  /// Toggle nearby alerts
  void setNearbyAlerts(bool value) {
    state = state.copyWith(nearbyAlertsEnabled: value);
  }

  /// Toggle chat messages
  void setChatMessages(bool value) {
    state = state.copyWith(chatMessagesEnabled: value);
  }

  /// Toggle community updates
  void setCommunityUpdates(bool value) {
    state = state.copyWith(communityUpdatesEnabled: value);
  }

  /// Set alert radius
  void setAlertRadius(int radius) {
    state = state.copyWith(alertRadius: radius.clamp(100, 2000));
  }

  /// Set language
  void setLanguage(String language) {
    state = state.copyWith(language: language);
  }

  /// Reset to defaults
  void resetToDefaults() {
    final profile = state.profile;
    state = SettingsState(profile: profile);
  }

  /// Logout
  Future<void> logout() async {
    state = const SettingsState();
  }
}

/// Settings Controller Provider
final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SettingsState>(
      (ref) => SettingsController(),
    );
