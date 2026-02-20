import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Splash feature state
class SplashState {
  final bool isInitialized;
  final double progress;

  const SplashState({this.isInitialized = false, this.progress = 0.0});

  SplashState copyWith({bool? isInitialized, double? progress}) {
    return SplashState(
      isInitialized: isInitialized ?? this.isInitialized,
      progress: progress ?? this.progress,
    );
  }
}

/// Splash Controller - Manages splash screen initialization
class SplashController extends StateNotifier<SplashState> {
  SplashController() : super(const SplashState());

  /// Initialize app - load configs, check auth, etc.
  Future<void> initialize() async {
    // Simulate initialization steps
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      state = state.copyWith(progress: i / 10);
    }

    state = state.copyWith(isInitialized: true);
  }

  /// Reset state
  void reset() {
    state = const SplashState();
  }
}

/// Splash Controller Provider
final splashControllerProvider =
    StateNotifierProvider<SplashController, SplashState>((ref) {
      return SplashController();
    });
