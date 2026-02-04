import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Home feature state
class HomeState {
  final bool isLoading;
  final String? error;
  final int counter;

  const HomeState({
    this.isLoading = false,
    this.error,
    this.counter = 0,
  });

  HomeState copyWith({
    bool? isLoading,
    String? error,
    int? counter,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      counter: counter ?? this.counter,
    );
  }
}

/// Home Controller - Manages the state of the home screen
class HomeController extends StateNotifier<HomeState> {
  HomeController() : super(const HomeState());

  /// Increment counter
  void increment() {
    state = state.copyWith(counter: state.counter + 1);
  }

  /// Decrement counter
  void decrement() {
    if (state.counter > 0) {
      state = state.copyWith(counter: state.counter - 1);
    }
  }

  /// Reset counter
  void reset() {
    state = state.copyWith(counter: 0);
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
final homeControllerProvider =
    StateNotifierProvider<HomeController, HomeState>((ref) {
  return HomeController();
});
