import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Question model
class Question {
  final String id;
  final String title;
  final String description;
  final String authorName;
  final String authorAvatar;
  final DateTime createdAt;
  final String category;
  final List<String> tags;
  final int answerCount;
  final int viewCount;
  final bool hasLocation;
  final double? latitude;
  final double? longitude;
  final String? locationName;

  const Question({
    required this.id,
    required this.title,
    required this.description,
    required this.authorName,
    required this.authorAvatar,
    required this.createdAt,
    required this.category,
    this.tags = const [],
    this.answerCount = 0,
    this.viewCount = 0,
    this.hasLocation = false,
    this.latitude,
    this.longitude,
    this.locationName,
  });
}

/// Answer model
class Answer {
  final String id;
  final String content;
  final String authorName;
  final String authorAvatar;
  final DateTime createdAt;
  final int upvotes;
  final bool isAccepted;

  const Answer({
    required this.id,
    required this.content,
    required this.authorName,
    required this.authorAvatar,
    required this.createdAt,
    this.upvotes = 0,
    this.isAccepted = false,
  });
}

/// Question filter options
enum QuestionFilter { latest, popular, unanswered, nearby }

extension QuestionFilterExtension on QuestionFilter {
  String get displayName {
    switch (this) {
      case QuestionFilter.latest:
        return 'Latest';
      case QuestionFilter.popular:
        return 'Popular';
      case QuestionFilter.unanswered:
        return 'Unanswered';
      case QuestionFilter.nearby:
        return 'Nearby';
    }
  }
}

/// Question page feature state
class QuestionState {
  final bool isLoading;
  final String? error;
  final List<Question> questions;
  final Question? selectedQuestion;
  final List<Answer> answers;
  final QuestionFilter filter;
  final String searchQuery;
  final bool isLoadingMore;
  final bool hasMore;

  const QuestionState({
    this.isLoading = false,
    this.error,
    this.questions = const [],
    this.selectedQuestion,
    this.answers = const [],
    this.filter = QuestionFilter.latest,
    this.searchQuery = '',
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  QuestionState copyWith({
    bool? isLoading,
    String? error,
    List<Question>? questions,
    Question? selectedQuestion,
    List<Answer>? answers,
    QuestionFilter? filter,
    String? searchQuery,
    bool? isLoadingMore,
    bool? hasMore,
  }) {
    return QuestionState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      questions: questions ?? this.questions,
      selectedQuestion: selectedQuestion ?? this.selectedQuestion,
      answers: answers ?? this.answers,
      filter: filter ?? this.filter,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

/// Question Controller - Manages the state of question pages
class QuestionController extends StateNotifier<QuestionState> {
  QuestionController() : super(const QuestionState());

  /// Load questions
  Future<void> loadQuestions() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Sample questions data
      final sampleQuestions = [
        Question(
          id: '1',
          title: 'Best coffee shops near downtown?',
          description:
              'I\'m looking for quiet coffee shops where I can work on my laptop. Any recommendations near the downtown area?',
          authorName: 'John Doe',
          authorAvatar: '',
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          category: 'Recommendations',
          tags: ['coffee', 'downtown', 'workspace'],
          answerCount: 5,
          viewCount: 42,
          hasLocation: true,
          locationName: 'Downtown Area',
        ),
        Question(
          id: '2',
          title: 'How to get to the airport from Central Station?',
          description:
              'What\'s the fastest and most affordable way to reach the airport from Central Station? Public transport preferred.',
          authorName: 'Jane Smith',
          authorAvatar: '',
          createdAt: DateTime.now().subtract(const Duration(hours: 5)),
          category: 'Directions',
          tags: ['airport', 'transport', 'central station'],
          answerCount: 8,
          viewCount: 156,
          hasLocation: true,
          locationName: 'Central Station',
        ),
        Question(
          id: '3',
          title: 'Any events happening this weekend?',
          description:
              'Looking for fun activities or events happening in the city this weekend. Family-friendly options would be great!',
          authorName: 'Mike Johnson',
          authorAvatar: '',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          category: 'Events',
          tags: ['weekend', 'events', 'family'],
          answerCount: 3,
          viewCount: 89,
          hasLocation: false,
        ),
        Question(
          id: '4',
          title: 'Is the park area safe at night?',
          description:
              'I\'m planning to jog in the evening around the main park. Is it safe to do so after dark?',
          authorName: 'Sarah Wilson',
          authorAvatar: '',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          category: 'Safety',
          tags: ['safety', 'park', 'jogging'],
          answerCount: 12,
          viewCount: 234,
          hasLocation: true,
          locationName: 'Main Park',
        ),
        Question(
          id: '5',
          title: 'Good restaurants for vegetarian food?',
          description:
              'Can anyone recommend some good vegetarian or vegan restaurants in the area? Looking for both casual and fine dining options.',
          authorName: 'Emily Brown',
          authorAvatar: '',
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          category: 'Recommendations',
          tags: ['vegetarian', 'vegan', 'restaurants'],
          answerCount: 7,
          viewCount: 112,
          hasLocation: false,
        ),
      ];

      state = state.copyWith(
        isLoading: false,
        questions: sampleQuestions,
        hasMore: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load questions. Please try again.',
      );
    }
  }

  /// Load more questions
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      await Future.delayed(const Duration(seconds: 1));
      // In real app, append more questions
      state = state.copyWith(isLoadingMore: false, hasMore: false);
    } catch (e) {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  /// Select a question
  void selectQuestion(Question question) {
    state = state.copyWith(selectedQuestion: question);
    _loadAnswers(question.id);
  }

  /// Clear selected question
  void clearSelectedQuestion() {
    state = state.copyWith(selectedQuestion: null, answers: []);
  }

  /// Load answers for a question
  Future<void> _loadAnswers(String questionId) async {
    // Sample answers data
    final sampleAnswers = [
      Answer(
        id: '1',
        content:
            'I highly recommend "The Daily Grind" on 5th Street. They have great coffee and plenty of power outlets for laptops!',
        authorName: 'Coffee Lover',
        authorAvatar: '',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        upvotes: 12,
        isAccepted: true,
      ),
      Answer(
        id: '2',
        content:
            'Try "Brew & Bean" on Main Avenue. It\'s quiet and has free WiFi. The latte there is amazing!',
        authorName: 'Local Guide',
        authorAvatar: '',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        upvotes: 8,
        isAccepted: false,
      ),
      Answer(
        id: '3',
        content:
            'Check out the new place called "Code & Coffee". It\'s designed specifically for remote workers.',
        authorName: 'Tech Worker',
        authorAvatar: '',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        upvotes: 5,
        isAccepted: false,
      ),
    ];

    state = state.copyWith(answers: sampleAnswers);
  }

  /// Set filter
  void setFilter(QuestionFilter filter) {
    state = state.copyWith(filter: filter);
    loadQuestions();
  }

  /// Set search query
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  /// Search questions
  Future<void> search() async {
    if (state.searchQuery.isEmpty) {
      loadQuestions();
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final filtered = state.questions
          .where(
            (q) =>
                q.title.toLowerCase().contains(
                  state.searchQuery.toLowerCase(),
                ) ||
                q.description.toLowerCase().contains(
                  state.searchQuery.toLowerCase(),
                ),
          )
          .toList();
      state = state.copyWith(isLoading: false, questions: filtered);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Search failed');
    }
  }

  /// Reset state
  void reset() {
    state = const QuestionState();
  }
}

/// Question Controller Provider
final questionControllerProvider =
    StateNotifierProvider<QuestionController, QuestionState>(
      (ref) => QuestionController(),
    );
