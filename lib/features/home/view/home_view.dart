import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../ask_question/view/ask_question_view.dart';
import '../../settings/view/settings_view.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  void _showMarkerDetail(BuildContext context, MapMarkerData marker) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => MarkerDetailSheet(
        marker: marker,
        onRespond: () {
          Navigator.pop(context);
          // TODO: Navigate to respond screen
        },
      ),
    );
  }

  void _navigateToAskQuestion(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AskQuestionView()),
    );
  }

  void _handleTabChange(BuildContext context, WidgetRef ref, NavTab tab) {
    ref.read(homeControllerProvider.notifier).setTab(tab);

    switch (tab) {
      case NavTab.map:
        // Already on map
        break;
      case NavTab.feed:
        // TODO: Navigate to feed view
        break;
      case NavTab.add:
        _navigateToAskQuestion(context);
        break;
      case NavTab.chat:
        // TODO: Navigate to chat list view
        break;
      case NavTab.profile:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SettingsView()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeControllerProvider);
    final homeController = ref.read(homeControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: Stack(
        children: [
          // Map background
          MapContainer(
            markers: homeState.filteredMarkers,
            userLat: homeState.userLat,
            userLng: homeState.userLng,
            radius: homeState.askRadius,
            showRadiusCircle: homeState.showRadiusCircle,
            onMarkerTap: (marker) => _showMarkerDetail(context, marker),
          ),

          // Top overlay (search + filters)
          SafeArea(
            child: Column(
              children: [
                // Search bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: MapSearchBar(
                    value: homeState.searchQuery,
                    onChanged: homeController.setSearchQuery,
                    onMenuTap: () {
                      // TODO: Show filter menu
                    },
                  ),
                ),
                // Filter pills
                FilterPillsRow(
                  activeFilters: homeState.activeFilters,
                  onToggle: homeController.toggleFilter,
                ),
              ],
            ),
          ),

          // FAB
          Positioned(
            right: 16,
            bottom: MediaQuery.of(context).padding.bottom + 100,
            child: HomeMapFab(
              isExpanded: homeState.isFabExpanded,
              onToggle: homeController.toggleFab,
              onAskQuestion: () => _navigateToAskQuestion(context),
              onBroadcast: () {
                // TODO: Navigate to broadcast
              },
              onMyLocation: () {
                homeController.toggleRadiusCircle();
              },
            ),
          ),

          // Bottom navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: HomeNavBar(
              currentTab: homeState.currentTab,
              onTabChanged: (tab) => _handleTabChange(context, ref, tab),
            ),
          ),

          // Loading overlay
          if (homeState.isLoading)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
