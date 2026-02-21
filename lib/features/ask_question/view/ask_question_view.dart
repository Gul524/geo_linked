import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/widgets.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

/// Ask Question View - Screen for posting new questions with map and radius
class AskQuestionView extends ConsumerStatefulWidget {
  const AskQuestionView({super.key});

  @override
  ConsumerState<AskQuestionView> createState() => _AskQuestionViewState();
}

class _AskQuestionViewState extends ConsumerState<AskQuestionView> {
  @override
  void dispose() {
    // Reset controller state when leaving
    ref.read(askQuestionControllerProvider.notifier).reset();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final success = await ref
        .read(askQuestionControllerProvider.notifier)
        .submitQuestion();
    if (success && mounted) {
      AppSnackbar.success(context, message: 'Question posted successfully!');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final askState = ref.watch(askQuestionControllerProvider);
    final askController = ref.read(askQuestionControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppLoadingOverlay(
      isLoading: askState.isLoading,
      loadingText: 'Posting question...',
      child: Scaffold(
        backgroundColor: isDark
            ? AppColors.backgroundDark
            : AppColors.background,
        body: Stack(
          children: [
            // Map background with radius circle
            AskQuestionMap(
              radiusMeters: askState.radiusMeters,
              centerLat: askState.userLat,
              centerLng: askState.userLng,
            ),

            // Top bar
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Back button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.black.withOpacity(0.5)
                              : Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Radius badge
                    AskRadiusBadge(radiusText: askState.radiusFormatted),
                  ],
                ),
              ),
            ),

            // Error snackbar
            if (askState.error != null)
              Positioned(
                top: MediaQuery.of(context).padding.top + 80,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.white),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          askState.error!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => askController.setError(null),
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

            // Bottom sheet
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AskQuestionSheet(
                question: askState.question,
                radiusMeters: askState.radiusMeters,
                radiusPercent: askState.radiusPercent,
                isAnonymous: askState.isAnonymous,
                isValid: askState.isQuestionValid,
                onQuestionChanged: askController.setQuestion,
                onRadiusChanged: askController.setRadiusFromSlider,
                onAnonymousToggle: askController.toggleAnonymous,
                onSubmit: _handleSubmit,
                onClose: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
