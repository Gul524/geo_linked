import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'app_text.dart';

/// Custom List Tile Widget - Reusable list item component
/// Usage: AppListTile(title: 'Title', onTap: () {})
///        AppListTile.settings(title: 'Settings', icon: Icons.settings)
class AppListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool enabled;
  final bool selected;
  final Color? backgroundColor;
  final Color? selectedColor;
  final EdgeInsetsGeometry? contentPadding;
  final double? minLeadingWidth;
  final bool dense;
  final bool showDivider;

  const AppListTile._({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.leadingIcon,
    this.trailingIcon,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
    this.selected = false,
    this.backgroundColor,
    this.selectedColor,
    this.contentPadding,
    this.minLeadingWidth,
    this.dense = false,
    this.showDivider = false,
  });

  /// Standard list tile
  factory AppListTile({
    required String title,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    IconData? leadingIcon,
    IconData? trailingIcon,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    bool enabled = true,
    bool selected = false,
    Color? backgroundColor,
    EdgeInsetsGeometry? contentPadding,
    bool dense = false,
    bool showDivider = false,
  }) {
    return AppListTile._(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      leadingIcon: leadingIcon,
      trailingIcon:
          trailingIcon ?? (onTap != null ? Icons.chevron_right : null),
      onTap: onTap,
      onLongPress: onLongPress,
      enabled: enabled,
      selected: selected,
      backgroundColor: backgroundColor,
      contentPadding: contentPadding,
      dense: dense,
      showDivider: showDivider,
    );
  }

  /// Settings style list tile with icon
  factory AppListTile.settings({
    required String title,
    String? subtitle,
    required IconData icon,
    Widget? trailing,
    VoidCallback? onTap,
    bool enabled = true,
    bool showDivider = true,
    Color? iconColor,
  }) {
    return AppListTile._(
      title: title,
      subtitle: subtitle,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (iconColor ?? AppColors.primary).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor ?? AppColors.primary, size: 20),
      ),
      trailing:
          trailing ??
          const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
      enabled: enabled,
      showDivider: showDivider,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  /// Switch list tile
  factory AppListTile.switchTile({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    IconData? leadingIcon,
    bool enabled = true,
    bool showDivider = true,
  }) {
    return AppListTile._(
      title: title,
      subtitle: subtitle,
      leadingIcon: leadingIcon,
      trailing: Switch(
        value: value,
        onChanged: enabled ? onChanged : null,
        activeColor: AppColors.primary,
      ),
      onTap: enabled ? () => onChanged(!value) : null,
      enabled: enabled,
      showDivider: showDivider,
    );
  }

  /// Checkbox list tile
  factory AppListTile.checkbox({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    IconData? leadingIcon,
    bool enabled = true,
    bool showDivider = true,
  }) {
    return AppListTile._(
      title: title,
      subtitle: subtitle,
      leadingIcon: leadingIcon,
      trailing: Checkbox(
        value: value,
        onChanged: enabled ? (v) => onChanged(v ?? false) : null,
        activeColor: AppColors.primary,
      ),
      onTap: enabled ? () => onChanged(!value) : null,
      enabled: enabled,
      showDivider: showDivider,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget tile = ListTile(
      title: AppText.body(
        title,
        color: enabled ? AppColors.textPrimary : AppColors.textMuted,
        fontWeight: FontWeight.w500,
      ),
      subtitle: subtitle != null
          ? AppText.caption(
              subtitle!,
              color: enabled ? AppColors.textSecondary : AppColors.textMuted,
            )
          : null,
      leading:
          leading ??
          (leadingIcon != null
              ? Icon(
                  leadingIcon,
                  color: enabled
                      ? AppColors.textSecondary
                      : AppColors.textMuted,
                )
              : null),
      trailing:
          trailing ??
          (trailingIcon != null
              ? Icon(
                  trailingIcon,
                  color: enabled
                      ? AppColors.textSecondary
                      : AppColors.textMuted,
                )
              : null),
      onTap: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      enabled: enabled,
      selected: selected,
      selectedColor: selectedColor ?? AppColors.primary,
      tileColor: backgroundColor,
      selectedTileColor: (selectedColor ?? AppColors.primary).withOpacity(0.1),
      contentPadding:
          contentPadding ?? const EdgeInsets.symmetric(horizontal: 16),
      minLeadingWidth: minLeadingWidth ?? 24,
      dense: dense,
    );

    if (showDivider) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [tile, const Divider(height: 1, indent: 16, endIndent: 16)],
      );
    }

    return tile;
  }
}
