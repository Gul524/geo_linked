import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Signup feature state
class SignupState {
  final bool isLoading;
  final String? error;
  final bool isSignedUp;
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final bool acceptedTerms;

  const SignupState({
    this.isLoading = false,
    this.error,
    this.isSignedUp = false,
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.acceptedTerms = false,
  });

  SignupState copyWith({
    bool? isLoading,
    String? error,
    bool? isSignedUp,
    String? fullName,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
    bool? acceptedTerms,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSignedUp: isSignedUp ?? this.isSignedUp,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
    );
  }

  /// Validate full name
  bool get isNameValid => fullName.trim().length >= 2;

  /// Validate email format
  bool get isEmailValid {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Validate phone number
  bool get isPhoneValid => phone.length >= 10;

  /// Validate password (minimum 6 characters)
  bool get isPasswordValid => password.length >= 6;

  /// Validate password match
  bool get doPasswordsMatch => password == confirmPassword;

  /// Check if form is valid
  bool get isFormValid =>
      isNameValid &&
      isEmailValid &&
      isPasswordValid &&
      doPasswordsMatch &&
      acceptedTerms;
}

/// Signup Controller - Manages the state of the signup screen
class SignupController extends StateNotifier<SignupState> {
  SignupController() : super(const SignupState());

  /// Update full name
  void setFullName(String name) {
    state = state.copyWith(fullName: name, error: null);
  }

  /// Update email
  void setEmail(String email) {
    state = state.copyWith(email: email, error: null);
  }

  /// Update phone
  void setPhone(String phone) {
    state = state.copyWith(phone: phone, error: null);
  }

  /// Update password
  void setPassword(String password) {
    state = state.copyWith(password: password, error: null);
  }

  /// Update confirm password
  void setConfirmPassword(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword, error: null);
  }

  /// Toggle terms acceptance
  void toggleTermsAcceptance() {
    state = state.copyWith(acceptedTerms: !state.acceptedTerms, error: null);
  }

  /// Perform signup
  Future<bool> signup() async {
    if (!state.isFormValid) {
      if (!state.isNameValid) {
        state = state.copyWith(error: 'Please enter your full name');
      } else if (!state.isEmailValid) {
        state = state.copyWith(error: 'Please enter a valid email');
      } else if (!state.isPasswordValid) {
        state = state.copyWith(error: 'Password must be at least 6 characters');
      } else if (!state.doPasswordsMatch) {
        state = state.copyWith(error: 'Passwords do not match');
      } else if (!state.acceptedTerms) {
        state = state.copyWith(error: 'Please accept the terms and conditions');
      }
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with actual signup logic
      state = state.copyWith(isLoading: false, isSignedUp: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Signup failed. Please try again.',
      );
      return false;
    }
  }

  /// Reset state
  void reset() {
    state = const SignupState();
  }

  /// Set error
  void setError(String? error) {
    state = state.copyWith(error: error);
  }
}

/// Signup Controller Provider
final signupControllerProvider =
    StateNotifierProvider<SignupController, SignupState>(
      (ref) => SignupController(),
    );
