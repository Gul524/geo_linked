import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/home_controller.dart';

/// Search bar for map view
class MapSearchBar extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final VoidCallback? onMenuTap;

  const MapSearchBar({
    super.key,
    required this.value,
    required this.onChanged,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.black.withOpacity(0.6)
                : Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: 22,
                color: isDark ? Colors.white54 : Colors.black45,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  onChanged: onChanged,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search this area...',
                    hintStyle: TextStyle(
                      color: isDark ? Colors.white38 : Colors.black38,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onMenuTap,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.tune, size: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Filter pills row
class FilterPillsRow extends StatelessWidget {
  final Set<FilterCategory> activeFilters;
  final ValueChanged<FilterCategory> onToggle;

  const FilterPillsRow({
    super.key,
    required this.activeFilters,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: FilterCategory.values.map((category) {
          final isActive = activeFilters.contains(category);
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _FilterPill(
              label: category.label,
              emoji: category.emoji,
              isActive: isActive,
              onTap: () => onToggle(category),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  final String label;
  final String emoji;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterPill({
    required this.label,
    required this.emoji,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          gradient: isActive ? AppColors.buttonGradient : null,
          color: isActive
              ? null
              : (isDark
                    ? Colors.black.withOpacity(0.5)
                    : Colors.white.withOpacity(0.9)),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isActive
                ? Colors.transparent
                : (isDark ? Colors.white10 : Colors.black.withOpacity(0.08)),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? Colors.white
                    : (isDark ? Colors.white : Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Map container with fake map background
class MapContainer extends StatelessWidget {
  final List<MapMarkerData> markers;
  final double userLat;
  final double userLng;
  final int radius;
  final bool showRadiusCircle;
  final ValueChanged<MapMarkerData>? onMarkerTap;

  const MapContainer({
    super.key,
    required this.markers,
    required this.userLat,
    required this.userLng,
    this.radius = 300,
    this.showRadiusCircle = false,
    this.onMarkerTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? AppColors.mapGradientDark : AppColors.mapGradient,
      ),
      child: Stack(
        children: [
          // Grid pattern
          CustomPaint(
            size: Size.infinite,
            painter: _GridPainter(isDark: isDark),
          ),
          // Roads
          CustomPaint(
            size: Size.infinite,
            painter: _RoadsPainter(isDark: isDark),
          ),
          // Radius circle (if enabled)
          if (showRadiusCircle)
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.1),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 2,
                  ),
                ),
              ),
            ),
          // Center user marker
          Center(
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: AppColors.buttonGradient,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 24),
            ),
          ),
          // Markers
          ...markers.asMap().entries.map((entry) {
            final index = entry.key;
            final marker = entry.value;
            // Position markers around center
            final positions = [
              const Offset(-80, -120),
              const Offset(100, -60),
              const Offset(-60, 100),
              const Offset(120, 80),
            ];
            final offset = positions[index % positions.length];

            return Positioned(
              left: MediaQuery.of(context).size.width / 2 + offset.dx - 20,
              top: MediaQuery.of(context).size.height / 2 + offset.dy - 20,
              child: GestureDetector(
                onTap: () => onMarkerTap?.call(marker),
                child: _MapMarker(marker: marker),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final bool isDark;

  _GridPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark
          ? Colors.white.withOpacity(0.03)
          : Colors.black.withOpacity(0.03)
      ..strokeWidth = 1;

    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RoadsPainter extends CustomPainter {
  final bool isDark;

  _RoadsPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark
          ? Colors.white.withOpacity(0.08)
          : Colors.black.withOpacity(0.08)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    // Horizontal road
    canvas.drawLine(
      Offset(0, size.height * 0.4),
      Offset(size.width, size.height * 0.4),
      paint,
    );
    // Vertical road
    canvas.drawLine(
      Offset(size.width * 0.6, 0),
      Offset(size.width * 0.6, size.height),
      paint,
    );
    // Diagonal road
    canvas.drawLine(
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.5, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MapMarker extends StatelessWidget {
  final MapMarkerData marker;

  const _MapMarker({required this.marker});

  String get _emoji {
    switch (marker.category) {
      case FilterCategory.traffic:
        return '🚗';
      case FilterCategory.safety:
        return '⚠️';
      case FilterCategory.market:
        return '🏪';
      case FilterCategory.utility:
        return '🔧';
      case FilterCategory.event:
        return '🎉';
      case FilterCategory.question:
        return '❓';
    }
  }

  Color get _color {
    switch (marker.category) {
      case FilterCategory.traffic:
        return AppColors.warning;
      case FilterCategory.safety:
        return AppColors.error;
      case FilterCategory.market:
        return AppColors.success;
      case FilterCategory.utility:
        return AppColors.info;
      case FilterCategory.event:
        return AppColors.accent;
      case FilterCategory.question:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: _color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: _color.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(child: Text(_emoji, style: const TextStyle(fontSize: 20))),
    );
  }
}

/// Expandable FAB for map actions
class HomeMapFab extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onAskQuestion;
  final VoidCallback onBroadcast;
  final VoidCallback onMyLocation;

  const HomeMapFab({
    super.key,
    required this.isExpanded,
    required this.onToggle,
    required this.onAskQuestion,
    required this.onBroadcast,
    required this.onMyLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Expanded options
        if (isExpanded) ...[
          _FabOption(
            icon: Icons.broadcast_on_personal,
            label: 'Broadcast',
            color: AppColors.primaryLight,
            onTap: () {
              onToggle();
              onBroadcast();
            },
          ),
          const SizedBox(height: 12),
          _FabOption(
            icon: Icons.help_outline,
            label: 'Ask',
            color: AppColors.primary,
            onTap: () {
              onToggle();
              onAskQuestion();
            },
          ),
          const SizedBox(height: 12),
          _FabOption(
            icon: Icons.my_location,
            label: 'Location',
            color: AppColors.success,
            onTap: () {
              onToggle();
              onMyLocation();
            },
          ),
          const SizedBox(height: 16),
        ],
        // Main FAB
        GestureDetector(
          onTap: onToggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: AppColors.buttonGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: AnimatedRotation(
              turns: isExpanded ? 0.125 : 0,
              duration: const Duration(milliseconds: 200),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
          ),
        ),
      ],
    );
  }
}

class _FabOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _FabOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }
}

/// Glass bottom navigation bar
class HomeNavBar extends StatelessWidget {
  final NavTab currentTab;
  final ValueChanged<NavTab> onTabChanged;

  const HomeNavBar({
    super.key,
    required this.currentTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 12,
            bottom: MediaQuery.of(context).padding.bottom + 8,
          ),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.black.withOpacity(0.7)
                : Colors.white.withOpacity(0.85),
            border: Border(
              top: BorderSide(
                color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.map_outlined,
                activeIcon: Icons.map,
                label: 'Map',
                isActive: currentTab == NavTab.map,
                onTap: () => onTabChanged(NavTab.map),
              ),
              _NavItem(
                icon: Icons.dynamic_feed_outlined,
                activeIcon: Icons.dynamic_feed,
                label: 'Feed',
                isActive: currentTab == NavTab.feed,
                onTap: () => onTabChanged(NavTab.feed),
              ),
              const SizedBox(width: 60), // Space for FAB
              _NavItem(
                icon: Icons.chat_bubble_outline,
                activeIcon: Icons.chat_bubble,
                label: 'Chat',
                isActive: currentTab == NavTab.chat,
                onTap: () => onTabChanged(NavTab.chat),
              ),
              _NavItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                isActive: currentTab == NavTab.profile,
                onTap: () => onTabChanged(NavTab.profile),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              size: 26,
              color: isActive
                  ? AppColors.primary
                  : (isDark ? Colors.white54 : Colors.black45),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive
                    ? AppColors.primary
                    : (isDark ? Colors.white54 : Colors.black45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Marker detail sheet
class MarkerDetailSheet extends StatelessWidget {
  final MapMarkerData marker;
  final VoidCallback? onClose;
  final VoidCallback? onRespond;

  const MarkerDetailSheet({
    super.key,
    required this.marker,
    this.onClose,
    this.onRespond,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF1A1A1A).withOpacity(0.95)
                : Colors.white.withOpacity(0.95),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Header
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _getCategoryColor(
                        marker.category,
                      ).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        marker.category.emoji,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          marker.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        if (marker.subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            marker.subtitle!,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white54 : Colors.black45,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Stats row
              Row(
                children: [
                  _StatChip(
                    icon: Icons.chat_bubble_outline,
                    label: '${marker.responseCount} responses',
                    isDark: isDark,
                  ),
                  const SizedBox(width: 12),
                  _StatChip(
                    icon: Icons.access_time,
                    label: _getTimeAgo(marker.timestamp),
                    isDark: isDark,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Respond button
              GestureDetector(
                onTap: onRespond,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonGradient,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text(
                      'Respond',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(FilterCategory category) {
    switch (category) {
      case FilterCategory.traffic:
        return AppColors.warning;
      case FilterCategory.safety:
        return AppColors.error;
      case FilterCategory.market:
        return AppColors.success;
      case FilterCategory.utility:
        return AppColors.info;
      case FilterCategory.event:
        return AppColors.accent;
      case FilterCategory.question:
        return AppColors.primary;
    }
  }

  String _getTimeAgo(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else {
      return '${diff.inDays}d ago';
    }
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: isDark ? Colors.white54 : Colors.black45),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white54 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
