import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/widgets.dart';
import '../../home/view/home_view.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

/// Login View - User authentication screen
class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  void _showCountryPicker() {
    final loginState = ref.read(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CountryPickerSheet(
        countries: LoginController.countryCodes,
        selectedCountry: loginState.selectedCountry,
        onSelect: controller.setCountry,
      ),
    );
  }

  Future<void> _handleAppleSignIn() async {
    final success = await ref
        .read(loginControllerProvider.notifier)
        .signInWithApple();
    if (success && mounted) {
      _navigateToHome();
    }
  }

  Future<void> _handleGoogleSignIn() async {
    final success = await ref
        .read(loginControllerProvider.notifier)
        .signInWithGoogle();
    if (success && mounted) {
      _navigateToHome();
    }
  }

  Future<void> _handleContinue() async {
    final success = await ref
        .read(loginControllerProvider.notifier)
        .continueWithPhone();
    if (success && mounted) {
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeView()));
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);
    final loginController = ref.read(loginControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppLoadingOverlay(
      isLoading: loginState.isLoading,
      loadingText: 'Signing in...',
      child: Scaffold(
        backgroundColor: isDark
            ? AppColors.backgroundDark
            : AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Hero Section
              const LoginHero(),

              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    // Error message
                    if (loginState.error != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: AppColors.error,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                loginState.error!,
                                style: const TextStyle(
                                  color: AppColors.error,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Social Sign In Buttons
                    SocialSignInButton.apple(onPressed: _handleAppleSignIn),
                    const SizedBox(height: 12),
                    SocialSignInButton.google(onPressed: _handleGoogleSignIn),

                    const SizedBox(height: 32),

                    // Divider
                    const AuthDivider(),

                    const SizedBox(height: 32),

                    // Phone Input
                    PhoneInputField(
                      phoneNumber: loginState.phoneNumber,
                      selectedCountry: loginState.selectedCountry,
                      isFocused: loginState.isPhoneInputFocused,
                      onPhoneChanged: loginController.setPhoneNumber,
                      onCountryTap: _showCountryPicker,
                      onFocusChange: () {
                        loginController.setPhoneInputFocus(
                          !loginState.isPhoneInputFocused,
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Continue Button
                    ContinueButton(
                      onPressed: _handleContinue,
                      isEnabled: loginState.phoneNumber.isNotEmpty,
                    ),

                    const SizedBox(height: 40),

                    // Privacy Badge
                    const LocationPrivacyBadge(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
