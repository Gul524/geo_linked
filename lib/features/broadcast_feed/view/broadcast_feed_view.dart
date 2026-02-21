import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

/// Broadcast Feed View - Shows nearby alerts and broadcasts
class BroadcastFeedView extends ConsumerWidget {
  const BroadcastFeedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(broadcastFeedControllerProvider);
    final feedController = ref.read(broadcastFeedControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: Stack(
        children: [
          // Blurred map background
          const FeedMapBackground(),

          // Close button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
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
            ),
          ),

          // Feed sheet
          FeedSheet(
            alerts: feedState.filteredAlerts,
            activeFilters: feedState.activeFilters,
            radiusText: feedState.radiusFormatted,
            onFilterToggle: feedController.toggleFilter,
            onAlertTap: (alert) {
              // TODO: Navigate to alert detail
            },
          ),

          // Loading overlay
          if (feedState.isLoading)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
