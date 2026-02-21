import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../login/view/login_view.dart';
import '../controller/settings_controller.dart';
import '../widgets/settings_widgets.dart';

/// Settings/Profile View
class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0A0A0F)
          : const Color(0xFFF5F5F7),
      body: state.isLoading
          ? const _LoadingView()
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: state.profile != null
                      ? ProfileHeader(
                          profile: state.profile!,
                          onEditProfile: () => _editProfile(context),
                          isDark: isDark,
                        )
                      : const SizedBox.shrink(),
                ),
                SliverToBoxAdapter(
                  child: state.profile != null
                      ? ScoreRing(
                          score: state.profile!.reputationScore,
                          percentage: state.profile!.scorePercentage,
                          level: state.profile!.level,
                          isDark: isDark,
                        )
                      : const SizedBox.shrink(),
                ),

                // Appearance
                SliverToBoxAdapter(
                  child: SettingsGroupHeader(
                    title: 'APPEARANCE',
                    icon: Icons.palette_outlined,
                    isDark: isDark,
                  ),
                ),
                SliverToBoxAdapter(
                  child: ThemeSelector(
                    isDarkMode: state.isDarkMode,
                    onChanged: controller.setDarkMode,
                    isDark: isDark,
                  ),
                ),

                // Notifications
                SliverToBoxAdapter(
                  child: SettingsGroupHeader(
                    title: 'NOTIFICATIONS',
                    icon: Icons.notifications_outlined,
                    isDark: isDark,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SettingsCard(
                    isDark: isDark,
                    children: [
                      SettingsToggleRow(
                        title: 'Nearby Alerts',
                        subtitle: 'Get notified about nearby broadcasts',
                        icon: Icons.broadcast_on_home_outlined,
                        value: state.nearbyAlertsEnabled,
                        onChanged: controller.setNearbyAlerts,
                        isDark: isDark,
                      ),
                      SettingsToggleRow(
                        title: 'Chat Messages',
                        subtitle: 'Receive reply notifications',
                        icon: Icons.chat_bubble_outline_rounded,
                        value: state.chatMessagesEnabled,
                        onChanged: controller.setChatMessages,
                        isDark: isDark,
                      ),
                      SettingsToggleRow(
                        title: 'Community Updates',
                        subtitle: 'Weekly community digest',
                        icon: Icons.people_outline_rounded,
                        value: state.communityUpdatesEnabled,
                        onChanged: controller.setCommunityUpdates,
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),

                // Location & Privacy
                SliverToBoxAdapter(
                  child: SettingsGroupHeader(
                    title: 'LOCATION & PRIVACY',
                    icon: Icons.location_on_outlined,
                    isDark: isDark,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SettingsCard(
                    isDark: isDark,
                    children: [
                      SettingsToggleRow(
                        title: 'Location Services',
                        subtitle: 'Allow location access',
                        icon: Icons.my_location_rounded,
                        value: state.locationEnabled,
                        onChanged: controller.setLocation,
                        isDark: isDark,
                      ),
                      SettingsNavRow(
                        title: 'Alert Radius',
                        subtitle: '${state.alertRadius}m',
                        icon: Icons.radar_rounded,
                        onTap: () => _showRadiusSelector(
                          context,
                          controller,
                          state.alertRadius,
                        ),
                        isDark: isDark,
                      ),
                      SettingsNavRow(
                        title: 'Privacy Settings',
                        icon: Icons.shield_outlined,
                        onTap: () {},
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),

                // Account
                SliverToBoxAdapter(
                  child: SettingsGroupHeader(
                    title: 'ACCOUNT',
                    icon: Icons.person_outline_rounded,
                    isDark: isDark,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SettingsCard(
                    isDark: isDark,
                    children: [
                      SettingsNavRow(
                        title: 'Edit Profile',
                        icon: Icons.edit_outlined,
                        onTap: () => _editProfile(context),
                        isDark: isDark,
                      ),
                      SettingsNavRow(
                        title: 'Language',
                        subtitle: _getLanguageName(state.language),
                        icon: Icons.language_rounded,
                        onTap: () => _showLanguageDialog(
                          context,
                          controller,
                          state.language,
                        ),
                        isDark: isDark,
                      ),
                      SettingsNavRow(
                        title: 'Help & Support',
                        icon: Icons.help_outline_rounded,
                        onTap: () {},
                        isDark: isDark,
                      ),
                      SettingsNavRow(
                        title: 'About',
                        icon: Icons.info_outline_rounded,
                        onTap: () {},
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),

                SliverToBoxAdapter(
                  child: LogoutButton(
                    onTap: () => _showLogoutDialog(context, controller),
                    isDark: isDark,
                  ),
                ),

                const SliverToBoxAdapter(
                  child: AppVersionInfo(version: '1.0.0', isDark: false),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
    );
  }

  void _editProfile(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Edit profile')));
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      case 'de':
        return 'Deutsch';
      case 'ar':
        return 'العربية';
      default:
        return 'English';
    }
  }

  void _showLanguageDialog(
    BuildContext context,
    SettingsController controller,
    String currentLanguage,
  ) {
    final languages = [
      ('en', 'English'),
      ('es', 'Español'),
      ('fr', 'Français'),
      ('de', 'Deutsch'),
      ('ar', 'العربية'),
    ];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1A1A2E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Select Language',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ...languages.map(
              (lang) => ListTile(
                title: Text(
                  lang.$2,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                trailing: currentLanguage == lang.$1
                    ? const Icon(Icons.check_circle, color: Color(0xFF0047AB))
                    : null,
                onTap: () {
                  controller.setLanguage(lang.$1);
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showRadiusSelector(
    BuildContext context,
    SettingsController controller,
    int currentRadius,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    int selectedRadius = currentRadius;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1A1A2E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Alert Radius',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${selectedRadius}m',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0047AB),
                  ),
                ),
                const SizedBox(height: 24),
                Slider(
                  value: selectedRadius.toDouble(),
                  min: 100,
                  max: 2000,
                  divisions: 19,
                  activeColor: const Color(0xFF0047AB),
                  onChanged: (value) {
                    setState(() {
                      selectedRadius = value.toInt();
                    });
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.setAlertRadius(selectedRadius);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0047AB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, SettingsController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1A1A2E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Log Out',
          style: TextStyle(color: isDark ? Colors.white : Colors.black87),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: TextStyle(
            color: (isDark ? Colors.white : Colors.black).withValues(
              alpha: 0.7,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: (isDark ? Colors.white : Colors.black).withValues(
                  alpha: 0.5,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginView()),
                (route) => false,
              );
            },
            child: const Text('Log Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: Color(0xFF0047AB)),
    );
  }
}
