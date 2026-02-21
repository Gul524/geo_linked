import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Onboarding page data model
class OnboardingPageData {
  final String title;
  final String subtitle;
  final List<OnboardingMarker> markers;

  const OnboardingPageData({
    required this.title,
    required this.subtitle,
    required this.markers,
  });
}

/// Marker data for onboarding illustration
class OnboardingMarker {
  final String emoji;
  final double topPercent;
  final double leftPercent;
  final OnboardingMarkerType type;

  const OnboardingMarker({
    required this.emoji,
    required this.topPercent,
    required this.leftPercent,
    required this.type,
  });
}

enum OnboardingMarkerType { traffic, safety, market }

/// Onboarding state
class OnboardingState {
  final int currentPage;
  final List<OnboardingPageData> pages;
  final bool isComplete;

  const OnboardingState({
    this.currentPage = 0,
    this.pages = const [],
    this.isComplete = false,
  });

  OnboardingState copyWith({
    int? currentPage,
    List<OnboardingPageData>? pages,
    bool? isComplete,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      pages: pages ?? this.pages,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}

/// Onboarding Controller - Manages onboarding state and navigation
class OnboardingController extends StateNotifier<OnboardingState> {
  OnboardingController() : super(const OnboardingState()) {
    _initializePages();
  }

  /// Private: Initialize onboarding pages data
  void _initializePages() {
    final pages = [
      const OnboardingPageData(
        title: 'Know what\'s happening around you, instantly.',
        subtitle:
            'See live traffic, road blocks, market conditions, and safety alerts shared by real people nearby.',
        markers: [
          OnboardingMarker(
            emoji: '🚗',
            topPercent: 0.44,
            leftPercent: 0.30,
            type: OnboardingMarkerType.traffic,
          ),
          OnboardingMarker(
            emoji: '🚧',
            topPercent: 0.22,
            leftPercent: 0.60,
            type: OnboardingMarkerType.safety,
          ),
          OnboardingMarker(
            emoji: '🛒',
            topPercent: 0.64,
            leftPercent: 0.62,
            type: OnboardingMarkerType.market,
          ),
        ],
      ),
      const OnboardingPageData(
        title: 'Ask questions to people around you.',
        subtitle:
            'Get instant answers from nearby people. Is the road clear? Is the market open? Ask and find out.',
        markers: [
          OnboardingMarker(
            emoji: '❓',
            topPercent: 0.35,
            leftPercent: 0.45,
            type: OnboardingMarkerType.traffic,
          ),
          OnboardingMarker(
            emoji: '💬',
            topPercent: 0.55,
            leftPercent: 0.65,
            type: OnboardingMarkerType.market,
          ),
        ],
      ),
      const OnboardingPageData(
        title: 'Broadcast alerts to your community.',
        subtitle:
            'Share important updates with people in your area. Help others avoid traffic, stay safe, and save time.',
        markers: [
          OnboardingMarker(
            emoji: '📢',
            topPercent: 0.40,
            leftPercent: 0.50,
            type: OnboardingMarkerType.market,
          ),
          OnboardingMarker(
            emoji: '⚡',
            topPercent: 0.60,
            leftPercent: 0.30,
            type: OnboardingMarkerType.safety,
          ),
        ],
      ),
    ];

    state = state.copyWith(pages: pages);
  }

  /// Navigate to next page
  void nextPage() {
    if (state.currentPage < state.pages.length - 1) {
      state = state.copyWith(currentPage: state.currentPage + 1);
    } else {
      state = state.copyWith(isComplete: true);
    }
  }

  /// Navigate to previous page
  void previousPage() {
    if (state.currentPage > 0) {
      state = state.copyWith(currentPage: state.currentPage - 1);
    }
  }

  /// Set specific page
  void setPage(int page) {
    if (page >= 0 && page < state.pages.length) {
      state = state.copyWith(currentPage: page);
    }
  }

  /// Mark onboarding as complete
  void completeOnboarding() {
    state = state.copyWith(isComplete: true);
  }

  /// Check if current page is last page
  bool get isLastPage => state.currentPage == state.pages.length - 1;

  /// Get current page data
  OnboardingPageData? get currentPageData {
    if (state.pages.isEmpty) return null;
    return state.pages[state.currentPage];
  }
}

/// Onboarding Controller Provider
final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, OnboardingState>((ref) {
      return OnboardingController();
    });
