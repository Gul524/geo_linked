import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_text.dart';
import '../../login/view/login_view.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

/// Settings Screen
class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: AppText.h5('Settings'), centerTitle: true),
      body: ListView(
        children: [
          // Appearance Section
          const SettingsSectionHeader(title: 'Appearance'),
          SettingsToggleTile(
            title: 'Dark Mode',
            subtitle: 'Switch between light and dark theme',
            icon: Icons.dark_mode,
            value: settings.isDarkMode,
            onChanged: (value) => controller.setDarkMode(value),
          ),
          SettingsNavigationTile(
            title: 'Language',
            subtitle: _getLanguageName(settings.language),
            icon: Icons.language,
            onTap: () =>
                _showLanguageDialog(context, controller, settings.language),
          ),

          // Notifications Section
          const SettingsSectionHeader(title: 'Notifications'),
          SettingsToggleTile(
            title: 'Push Notifications',
            subtitle: 'Receive alerts and updates',
            icon: Icons.notifications,
            value: settings.notificationsEnabled,
            onChanged: (value) => controller.setNotifications(value),
          ),

          // Location Section
          const SettingsSectionHeader(title: 'Location'),
          SettingsToggleTile(
            title: 'Location Services',
            subtitle: 'Allow app to access your location',
            icon: Icons.location_on,
            value: settings.locationEnabled,
            onChanged: (value) => controller.setLocation(value),
          ),
          SettingsSliderTile(
            title: 'Default Map Zoom',
            subtitle: 'Initial zoom level when opening map',
            icon: Icons.zoom_in,
            value: settings.mapZoomDefault,
            min: 5.0,
            max: 20.0,
            divisions: 15,
            onChanged: (value) => controller.setMapZoomDefault(value),
          ),

          // Account Section
          const SettingsSectionHeader(title: 'Account'),
          SettingsNavigationTile(
            title: 'Profile',
            subtitle: 'Manage your profile information',
            icon: Icons.person,
            onTap: () {
              // Navigate to profile
            },
          ),
          SettingsNavigationTile(
            title: 'Privacy',
            subtitle: 'Privacy settings and data',
            icon: Icons.privacy_tip,
            onTap: () {
              // Navigate to privacy
            },
          ),
          SettingsNavigationTile(
            title: 'Security',
            subtitle: 'Password and authentication',
            icon: Icons.security,
            onTap: () {
              // Navigate to security
            },
          ),

          // About Section
          const SettingsSectionHeader(title: 'About'),
          SettingsNavigationTile(
            title: 'Help & Support',
            icon: Icons.help,
            onTap: () {
              // Navigate to help
            },
          ),
          SettingsNavigationTile(
            title: 'Terms of Service',
            icon: Icons.description,
            onTap: () {
              // Navigate to terms
            },
          ),
          SettingsNavigationTile(
            title: 'Privacy Policy',
            icon: Icons.policy,
            onTap: () {
              // Navigate to privacy policy
            },
          ),
          const SettingsNavigationTile(
            title: 'App Version',
            icon: Icons.info,
            trailing: Text(
              '1.0.0',
              style: TextStyle(color: AppColors.textMuted),
            ),
          ),

          // Actions Section
          const SettingsSectionHeader(title: 'Actions'),
          SettingsActionTile(
            title: 'Reset Settings',
            icon: Icons.restore,
            color: AppColors.warning,
            onTap: () => _showResetDialog(context, controller),
          ),
          SettingsActionTile(
            title: 'Log Out',
            icon: Icons.logout,
            onTap: () => _showLogoutDialog(context),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
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

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.map((lang) {
            return RadioListTile<String>(
              title: Text(lang.$2),
              value: lang.$1,
              groupValue: currentLanguage,
              activeColor: AppColors.primary,
              onChanged: (value) {
                if (value != null) {
                  controller.setLanguage(value);
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showResetDialog(BuildContext context, SettingsController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Settings'),
        content: const Text(
          'Are you sure you want to reset all settings to defaults?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.resetToDefaults();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings reset to defaults')),
              );
            },
            child: const Text(
              'Reset',
              style: TextStyle(color: AppColors.warning),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to login and clear stack
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginView()),
                (route) => false,
              );
            },
            child: const Text(
              'Log Out',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
