import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Login feature state
class LoginState {
  final bool isLoading;
  final String? error;
  final bool isLoggedIn;
  final bool obscurePassword;
  final String email;
  final String password;

  const LoginState({
    this.isLoading = false,
    this.error,
    this.isLoggedIn = false,
    this.obscurePassword = true,
    this.email = '',
    this.password = '',
  });

  LoginState copyWith({
    bool? isLoading,
    String? error,
    bool? isLoggedIn,
    bool? obscurePassword,
    String? email,
    String? password,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  /// Validate email format
  bool get isEmailValid {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Validate password (minimum 6 characters)
  bool get isPasswordValid => password.length >= 6;

  /// Check if form is valid
  bool get isFormValid => isEmailValid && isPasswordValid;
}

/// Login Controller - Manages the state of the login screen
class LoginController extends StateNotifier<LoginState> {
  LoginController() : super(const LoginState());

  /// Update email
  void setEmail(String email) {
    state = state.copyWith(email: email, error: null);
  }

  /// Update password
  void setPassword(String password) {
    state = state.copyWith(password: password, error: null);
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  /// Perform login
  Future<bool> login() async {
    if (!state.isFormValid) {
      if (!state.isEmailValid) {
        state = state.copyWith(error: 'Please enter a valid email');
      } else if (!state.isPasswordValid) {
        state = state.copyWith(error: 'Password must be at least 6 characters');
      }
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with actual authentication logic
      // For demo, accept any valid email/password
      state = state.copyWith(isLoading: false, isLoggedIn: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Login failed. Please try again.',
      );
      return false;
    }
  }

  /// Reset state
  void reset() {
    state = const LoginState();
  }

  /// Set error
  void setError(String? error) {
    state = state.copyWith(error: error);
  }
}

/// Login Controller Provider
final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>(
      (ref) => LoginController(),
    );
