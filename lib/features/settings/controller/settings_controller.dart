import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Settings state
class SettingsState {
  final bool isDarkMode;
  final bool notificationsEnabled;
  final bool locationEnabled;
  final String language;
  final double mapZoomDefault;

  const SettingsState({
    this.isDarkMode = false,
    this.notificationsEnabled = true,
    this.locationEnabled = true,
    this.language = 'en',
    this.mapZoomDefault = 15.0,
  });

  SettingsState copyWith({
    bool? isDarkMode,
    bool? notificationsEnabled,
    bool? locationEnabled,
    String? language,
    double? mapZoomDefault,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      locationEnabled: locationEnabled ?? this.locationEnabled,
      language: language ?? this.language,
      mapZoomDefault: mapZoomDefault ?? this.mapZoomDefault,
    );
  }
}

/// Settings Controller - Manages app settings
class SettingsController extends StateNotifier<SettingsState> {
  SettingsController() : super(const SettingsState());

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

  /// Set language
  void setLanguage(String language) {
    state = state.copyWith(language: language);
  }

  /// Set default map zoom
  void setMapZoomDefault(double zoom) {
    state = state.copyWith(mapZoomDefault: zoom.clamp(1.0, 20.0));
  }

  /// Reset to defaults
  void resetToDefaults() {
    state = const SettingsState();
  }
}

/// Settings Controller Provider
final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SettingsState>((ref) {
      return SettingsController();
    });
