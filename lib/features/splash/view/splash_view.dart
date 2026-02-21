import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../onboarding/view/onboarding_view.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

/// Splash Screen - Initial loading screen with GeoLinked branding
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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final splashState = ref.watch(splashControllerProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Background mesh
          const Positioned.fill(child: SplashMeshBackground()),
          // Content
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingXL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    // Logo with animation
                    const SplashLogo(size: AppConstants.logoLarge),

                    const SizedBox(height: 20),

                    // App name and tagline
                    const SplashBranding(),

                    const SizedBox(height: 40),

                    // Animated loading bar
                    const SplashLoadingBar(),

                    const Spacer(flex: 2),

                    // Progress indicator (optional - shown during load)
                    if (splashState.progress > 0 && splashState.progress < 1)
                      SplashLoadingIndicator(progress: splashState.progress),

                    // Version footer
                    Text(
                      'Version ${AppConstants.appVersion}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white38
                            : Colors.black38,
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
