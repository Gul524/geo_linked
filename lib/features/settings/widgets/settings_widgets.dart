import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_text.dart';

/// Settings Section Header
class SettingsSectionHeader extends StatelessWidget {
  final String title;

  const SettingsSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: AppText.label(title.toUpperCase(), color: AppColors.primary),
    );
  }
}

/// Settings Toggle Tile
class SettingsToggleTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const SettingsToggleTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 22),
      ),
      title: AppText.body(title),
      subtitle: subtitle != null ? AppText.caption(subtitle!) : null,
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }
}

/// Settings Navigation Tile
class SettingsNavigationTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  const SettingsNavigationTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 22),
      ),
      title: AppText.body(title),
      subtitle: subtitle != null ? AppText.caption(subtitle!) : null,
      trailing:
          trailing ??
          const Icon(Icons.chevron_right, color: AppColors.textMuted),
      onTap: onTap,
    );
  }
}

/// Settings Action Tile (for destructive actions)
class SettingsActionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;

  const SettingsActionTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.error;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: effectiveColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: effectiveColor, size: 22),
      ),
      title: AppText.body(title, color: effectiveColor),
      onTap: onTap,
    );
  }
}

/// Settings Slider Tile
class SettingsSliderTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final ValueChanged<double>? onChanged;

  const SettingsSliderTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.value,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          title: AppText.body(title),
          subtitle: subtitle != null ? AppText.caption(subtitle!) : null,
          trailing: AppText.label(value.toStringAsFixed(1)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: AppColors.primary,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
