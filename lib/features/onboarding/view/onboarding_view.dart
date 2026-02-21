import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../login/view/login_view.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

/// Onboarding Screen - Introduction to app features
class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Navigate to login when complete
    if (state.isComplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginView()));
      });
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? null : AppColors.onboardingGradient,
          color: isDark ? AppColors.backgroundDark : null,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Illustration area
              Expanded(
                flex: 5,
                child: PageView.builder(
                  itemCount: state.pages.length,
                  onPageChanged: controller.setPage,
                  itemBuilder: (context, index) {
                    final page = state.pages[index];
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: OnboardingMapPreview(markers: page.markers),
                      ),
                    );
                  },
                ),
              ),
              // Content area
              Container(
                padding: const EdgeInsets.fromLTRB(
                  AppConstants.paddingXL,
                  0,
                  AppConstants.paddingXL,
                  AppConstants.paddingXL,
                ),
                child: Column(
                  children: [
                    // Dots indicator
                    OnboardingDots(
                      totalPages: state.pages.length,
                      currentPage: state.currentPage,
                    ),
                    const SizedBox(height: 20),
                    // Title
                    if (controller.currentPageData != null) ...[
                      Text(
                        controller.currentPageData!.title,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      // Subtitle
                      Text(
                        controller.currentPageData!.subtitle,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    const SizedBox(height: 28),
                    // Continue button
                    GradientButton.withArrow(
                      text: controller.isLastPage ? 'Get Started' : 'Continue',
                      onPressed: controller.nextPage,
                    ),
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
