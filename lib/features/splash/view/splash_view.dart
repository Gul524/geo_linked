import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_text.dart';
import '../../home/view/home_view.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

/// Splash Screen - Initial loading screen
class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await ref.read(splashControllerProvider.notifier).initialize();

    if (mounted) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final splashState = ref.watch(splashControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),

                // Logo
                const SplashLogo(size: 120),
                const SizedBox(height: 32),

                // App Name
                AppText.h2('GeoLinked', color: AppColors.primary),
                const SizedBox(height: 8),
                AppText.body(
                  'Connect with your world',
                  color: AppColors.textSecondary,
                ),

                const Spacer(flex: 2),

                // Loading Indicator
                SplashLoadingIndicator(progress: splashState.progress),

                const SizedBox(height: 48),

                // Footer
                AppText.caption('Version 1.0.0'),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
