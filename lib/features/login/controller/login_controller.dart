import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Country code data for phone input
class CountryCode {
  final String code;
  final String dialCode;
  final String flag;
  final String name;

  const CountryCode({
    required this.code,
    required this.dialCode,
    required this.flag,
    required this.name,
  });
}

/// Login feature state
class LoginState {
  final bool isLoading;
  final String? error;
  final bool isLoggedIn;
  final String phoneNumber;
  final CountryCode selectedCountry;
  final bool isPhoneInputFocused;

  static const defaultCountry = CountryCode(
    code: 'US',
    dialCode: '+1',
    flag: '🇺🇸',
    name: 'United States',
  );

  const LoginState({
    this.isLoading = false,
    this.error,
    this.isLoggedIn = false,
    this.phoneNumber = '',
    this.selectedCountry = defaultCountry,
    this.isPhoneInputFocused = false,
  });

  LoginState copyWith({
    bool? isLoading,
    String? error,
    bool? isLoggedIn,
    String? phoneNumber,
    CountryCode? selectedCountry,
    bool? isPhoneInputFocused,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      isPhoneInputFocused: isPhoneInputFocused ?? this.isPhoneInputFocused,
    );
  }

  /// Validate phone number (minimum 10 digits)
  bool get isPhoneValid {
    final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');
    return digits.length >= 10;
  }

  /// Format phone for display
  String get formattedPhone {
    return '${selectedCountry.dialCode} $phoneNumber';
  }
}

/// Login Controller - Manages the state of the login screen
class LoginController extends StateNotifier<LoginState> {
  LoginController() : super(const LoginState());

  /// Available country codes
  static const List<CountryCode> countryCodes = [
    CountryCode(
      code: 'US',
      dialCode: '+1',
      flag: '🇺🇸',
      name: 'United States',
    ),
    CountryCode(
      code: 'GB',
      dialCode: '+44',
      flag: '🇬🇧',
      name: 'United Kingdom',
    ),
    CountryCode(code: 'CA', dialCode: '+1', flag: '🇨🇦', name: 'Canada'),
    CountryCode(code: 'AU', dialCode: '+61', flag: '🇦🇺', name: 'Australia'),
    CountryCode(code: 'DE', dialCode: '+49', flag: '🇩🇪', name: 'Germany'),
    CountryCode(code: 'FR', dialCode: '+33', flag: '🇫🇷', name: 'France'),
    CountryCode(code: 'IN', dialCode: '+91', flag: '🇮🇳', name: 'India'),
    CountryCode(code: 'PK', dialCode: '+92', flag: '🇵🇰', name: 'Pakistan'),
    CountryCode(code: 'JP', dialCode: '+81', flag: '🇯🇵', name: 'Japan'),
    CountryCode(code: 'BR', dialCode: '+55', flag: '🇧🇷', name: 'Brazil'),
  ];

  /// Update phone number
  void setPhoneNumber(String phone) {
    state = state.copyWith(phoneNumber: phone, error: null);
  }

  /// Update selected country
  void setCountry(CountryCode country) {
    state = state.copyWith(selectedCountry: country, error: null);
  }

  /// Set phone input focus state
  void setPhoneInputFocus(bool focused) {
    state = state.copyWith(isPhoneInputFocused: focused);
  }

  /// Sign in with Apple
  Future<bool> signInWithApple() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await Future.delayed(const Duration(seconds: 2));
      // TODO: Implement Apple Sign In
      state = state.copyWith(isLoading: false, isLoggedIn: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Apple Sign In failed. Please try again.',
      );
      return false;
    }
  }

  /// Sign in with Google
  Future<bool> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await Future.delayed(const Duration(seconds: 2));
      // TODO: Implement Google Sign In
      state = state.copyWith(isLoading: false, isLoggedIn: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Google Sign In failed. Please try again.',
      );
      return false;
    }
  }

  /// Continue with phone number
  Future<bool> continueWithPhone() async {
    if (!state.isPhoneValid) {
      state = state.copyWith(error: 'Please enter a valid phone number');
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      await Future.delayed(const Duration(seconds: 2));
      // TODO: Implement phone verification (OTP)
      state = state.copyWith(isLoading: false, isLoggedIn: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Phone verification failed. Please try again.',
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
