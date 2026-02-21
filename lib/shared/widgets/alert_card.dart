import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Alert type enum for different alert categories
enum AlertType { roadBlock, traffic, market, utility }

/// Alert card data model
class AlertCardData {
  final String id;
  final AlertType type;
  final String message;
  final String timeAgo;
  final int seenCount;
  final double distanceKm;
  final int verifiedCount;

  const AlertCardData({
    required this.id,
    required this.type,
    required this.message,
    required this.timeAgo,
    this.seenCount = 0,
    required this.distanceKm,
    this.verifiedCount = 0,
  });
}

/// Alert card widget for the broadcast feed
/// Displays alert information with meta chips
class AlertCard extends StatelessWidget {
  final AlertCardData data;
  final VoidCallback? onTap;

  const AlertCard({super.key, required this.data, this.onTap});

  String get _emoji {
    switch (data.type) {
      case AlertType.roadBlock:
        return '🚧';
      case AlertType.traffic:
        return '🚦';
      case AlertType.market:
        return '🛒';
      case AlertType.utility:
        return '⚡';
    }
  }

  String get _typeLabel {
    switch (data.type) {
      case AlertType.roadBlock:
        return 'ROAD BLOCK';
      case AlertType.traffic:
        return 'TRAFFIC JAM';
      case AlertType.market:
        return 'MARKET STATUS';
      case AlertType.utility:
        return 'UTILITIES';
    }
  }

  Color get _typeColor {
    switch (data.type) {
      case AlertType.roadBlock:
        return AppColors.error;
      case AlertType.traffic:
        return AppColors.warning;
      case AlertType.market:
        return AppColors.primary;
      case AlertType.utility:
        return AppColors.success;
    }
  }

  Color get _iconBgColor {
    switch (data.type) {
      case AlertType.roadBlock:
        return AppColors.errorLight;
      case AlertType.traffic:
        return AppColors.warningLight;
      case AlertType.market:
        return AppColors.infoLight;
      case AlertType.utility:
        return AppColors.successLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isDark
                    ? AppColors.borderDark
                    : AppColors.surfaceSecondary,
                width: 1,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _iconBgColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(_emoji, style: const TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(width: 14),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _typeLabel,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: _typeColor,
                          ),
                        ),
                        Text(
                          data.timeAgo,
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? AppColors.textTertiaryDark
                                : AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    // Message
                    Text(
                      data.message,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Meta chips
                    Wrap(
                      spacing: 10,
                      children: [
                        if (data.seenCount > 0)
                          _MetaChip(
                            emoji: '👁️',
                            label: '${data.seenCount} seen',
                          ),
                        _MetaChip(
                          emoji: '📍',
                          label: '${data.distanceKm.toStringAsFixed(1)} km',
                        ),
                        if (data.verifiedCount > 0)
                          _MetaChip(
                            emoji: '✅',
                            label: '${data.verifiedCount} verified',
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Meta chip widget for displaying stats
class _MetaChip extends StatelessWidget {
  final String emoji;
  final String label;

  const _MetaChip({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceSecondaryDark
            : AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 10)),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Exposed MetaChip for external use
class MetaChip extends StatelessWidget {
  final String emoji;
  final String label;
  final Color? backgroundColor;

  const MetaChip({
    super.key,
    required this.emoji,
    required this.label,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (isDark
                ? AppColors.surfaceSecondaryDark
                : AppColors.surfaceSecondary),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 10)),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
