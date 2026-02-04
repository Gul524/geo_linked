import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/widgets.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

/// Home Screen - Main screen of the app
class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeControllerProvider);
    final homeController = ref.read(homeControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: AppText.h5('GeoLinked'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: homeController.reset,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              Center(
                child: AppText.h3(
                  'Welcome to GeoLinked',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: AppText.body(
                  'Your location-based connection app',
                  color: AppColors.textSecondary,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 48),

              // Counter Display
              Center(
                child: CounterDisplay(count: homeState.counter),
              ),
              const SizedBox(height: 48),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton.secondary(
                    text: 'Decrease',
                    onPressed: homeController.decrement,
                    icon: Icons.remove,
                    size: AppButtonSize.medium,
                  ),
                  const SizedBox(width: 16),
                  AppButton.primary(
                    text: 'Increase',
                    onPressed: homeController.increment,
                    icon: Icons.add,
                    size: AppButtonSize.medium,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Full Width Button Example
              AppButton.primary(
                text: 'Get Started',
                onPressed: () {
                  // Navigate to next screen
                },
                size: AppButtonSize.large,
                width: double.infinity,
                suffixIcon: Icons.arrow_forward,
              ),
              const SizedBox(height: 12),

              AppButton.outline(
                text: 'Learn More',
                onPressed: () {
                  // Show info
                },
                size: AppButtonSize.medium,
                width: double.infinity,
              ),
              const SizedBox(height: 12),

              AppButton.text(
                text: 'Skip for now',
                onPressed: () {
                  // Skip
                },
                size: AppButtonSize.small,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
