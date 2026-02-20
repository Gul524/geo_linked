import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Question category model
enum QuestionCategory {
  general,
  directions,
  recommendations,
  events,
  safety,
  other,
}

extension QuestionCategoryExtension on QuestionCategory {
  String get displayName {
    switch (this) {
      case QuestionCategory.general:
        return 'General';
      case QuestionCategory.directions:
        return 'Directions';
      case QuestionCategory.recommendations:
        return 'Recommendations';
      case QuestionCategory.events:
        return 'Events';
      case QuestionCategory.safety:
        return 'Safety';
      case QuestionCategory.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case QuestionCategory.general:
        return '💬';
      case QuestionCategory.directions:
        return '🗺️';
      case QuestionCategory.recommendations:
        return '⭐';
      case QuestionCategory.events:
        return '🎉';
      case QuestionCategory.safety:
        return '🛡️';
      case QuestionCategory.other:
        return '❓';
    }
  }
}

/// Ask question feature state
class AskQuestionState {
  final bool isLoading;
  final String? error;
  final bool isSubmitted;
  final String title;
  final String description;
  final QuestionCategory category;
  final bool includeLocation;
  final List<String> tags;

  const AskQuestionState({
    this.isLoading = false,
    this.error,
    this.isSubmitted = false,
    this.title = '',
    this.description = '',
    this.category = QuestionCategory.general,
    this.includeLocation = true,
    this.tags = const [],
  });

  AskQuestionState copyWith({
    bool? isLoading,
    String? error,
    bool? isSubmitted,
    String? title,
    String? description,
    QuestionCategory? category,
    bool? includeLocation,
    List<String>? tags,
  }) {
    return AskQuestionState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      includeLocation: includeLocation ?? this.includeLocation,
      tags: tags ?? this.tags,
    );
  }

  /// Check if title is valid
  bool get isTitleValid => title.trim().length >= 10;

  /// Check if description is valid
  bool get isDescriptionValid => description.trim().length >= 20;

  /// Check if form is valid
  bool get isFormValid => isTitleValid && isDescriptionValid;
}

/// Ask Question Controller - Manages the state of ask question screen
class AskQuestionController extends StateNotifier<AskQuestionState> {
  AskQuestionController() : super(const AskQuestionState());

  /// Update title
  void setTitle(String title) {
    state = state.copyWith(title: title, error: null);
  }

  /// Update description
  void setDescription(String description) {
    state = state.copyWith(description: description, error: null);
  }

  /// Update category
  void setCategory(QuestionCategory category) {
    state = state.copyWith(category: category);
  }

  /// Toggle include location
  void toggleIncludeLocation() {
    state = state.copyWith(includeLocation: !state.includeLocation);
  }

  /// Add tag
  void addTag(String tag) {
    if (tag.isNotEmpty && !state.tags.contains(tag) && state.tags.length < 5) {
      state = state.copyWith(tags: [...state.tags, tag]);
    }
  }

  /// Remove tag
  void removeTag(String tag) {
    state = state.copyWith(tags: state.tags.where((t) => t != tag).toList());
  }

  /// Submit question
  Future<bool> submitQuestion() async {
    if (!state.isFormValid) {
      if (!state.isTitleValid) {
        state = state.copyWith(error: 'Title must be at least 10 characters');
      } else if (!state.isDescriptionValid) {
        state = state.copyWith(
          error: 'Description must be at least 20 characters',
        );
      }
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
