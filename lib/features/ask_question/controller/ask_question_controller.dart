import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Question category model
enum QuestionCategory {
  general('General', '💬'),
  directions('Directions', '🗺️'),
  recommendations('Recommendations', '⭐'),
  events('Events', '🎉'),
  safety('Safety', '🛡️'),
  traffic('Traffic', '🚗'),
  other('Other', '❓');

  final String displayName;
  final String icon;
  const QuestionCategory(this.displayName, this.icon);
}

/// Ask question feature state
class AskQuestionState {
  final bool isLoading;
  final String? error;
  final bool isSubmitted;
  final String question;
  final QuestionCategory category;
  final int radiusMeters; // 100m to 1000m
  final double userLat;
  final double userLng;
  final bool isAnonymous;

  const AskQuestionState({
    this.isLoading = false,
    this.error,
    this.isSubmitted = false,
    this.question = '',
    this.category = QuestionCategory.general,
    this.radiusMeters = 300,
    this.userLat = 37.7749,
    this.userLng = -122.4194,
    this.isAnonymous = false,
  });

  AskQuestionState copyWith({
    bool? isLoading,
    String? error,
    bool? isSubmitted,
    String? question,
    QuestionCategory? category,
    int? radiusMeters,
    double? userLat,
    double? userLng,
    bool? isAnonymous,
  }) {
    return AskQuestionState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      question: question ?? this.question,
      category: category ?? this.category,
      radiusMeters: radiusMeters ?? this.radiusMeters,
      userLat: userLat ?? this.userLat,
      userLng: userLng ?? this.userLng,
      isAnonymous: isAnonymous ?? this.isAnonymous,
    );
  }

  /// Check if question is valid (at least 10 chars)
  bool get isQuestionValid => question.trim().length >= 10;

  /// Get radius as formatted string
  String get radiusFormatted {
    if (radiusMeters >= 1000) {
      return '${(radiusMeters / 1000).toStringAsFixed(1)}km';
    }
    return '${radiusMeters}m';
  }

  /// Get radius as percentage (for slider)
  double get radiusPercent => (radiusMeters - 100) / 900;
}

/// Ask Question Controller - Manages the state of ask question screen
class AskQuestionController extends StateNotifier<AskQuestionState> {
  AskQuestionController() : super(const AskQuestionState());

  /// Update question text
  void setQuestion(String question) {
    state = state.copyWith(question: question, error: null);
  }

  /// Update category
  void setCategory(QuestionCategory category) {
    state = state.copyWith(category: category);
  }

  /// Update radius
  void setRadius(int meters) {
    // Clamp between 100m and 1000m
    final clamped = meters.clamp(100, 1000);
    state = state.copyWith(radiusMeters: clamped);
  }

  /// Set radius from slider (0.0 to 1.0)
  void setRadiusFromSlider(double value) {
    final meters = (100 + (value * 900)).round();
    setRadius(meters);
  }

  /// Toggle anonymous mode
  void toggleAnonymous() {
    state = state.copyWith(isAnonymous: !state.isAnonymous);
  }

  /// Update user location
  void setUserLocation(double lat, double lng) {
    state = state.copyWith(userLat: lat, userLng: lng);
  }

  /// Submit question
  Future<bool> submitQuestion() async {
    if (!state.isQuestionValid) {
      state = state.copyWith(error: 'Question must be at least 10 characters');
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with actual API call
      state = state.copyWith(isLoading: false, isSubmitted: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to submit question. Please try again.',
      );
      return false;
    }
  }

  /// Reset state
  void reset() {
    state = const AskQuestionState();
  }

  /// Set error
  void setError(String? error) {
    state = state.copyWith(error: error);
  }
}

/// Ask Question Controller Provider
final askQuestionControllerProvider =
    StateNotifierProvider<AskQuestionController, AskQuestionState>(
      (ref) => AskQuestionController(),
    );
