import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/widgets.dart';

/// Home Welcome Card Widget
class HomeWelcomeCard extends StatelessWidget {
  const HomeWelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard.gradient(
      gradient: AppColors.primaryGradient,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.h5('Welcome Back!', color: Colors.white),
                    const SizedBox(height: 4),
                    AppText.body(
                      'Explore and connect with your surroundings',
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Home Action Card Widget
class HomeActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback? onTap;

  const HomeActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          AppText.body(title, fontWeight: FontWeight.w600),
          const SizedBox(height: 4),
          AppText.caption(subtitle, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

/// Home Recent Activity Widget
class HomeRecentActivity extends StatelessWidget {
  const HomeRecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample recent activity data
    final activities = [
      _ActivityItem(
        icon: Icons.question_answer,
        title: 'Question Posted',
        subtitle: 'How to navigate to downtown?',
        time: '2 hours ago',
        color: AppColors.primary,
      ),
      _ActivityItem(
        icon: Icons.location_on,
        title: 'Location Shared',
        subtitle: 'Central Park, New York',
        time: '5 hours ago',
        color: AppColors.accent,
      ),
      _ActivityItem(
        icon: Icons.check_circle,
        title: 'Answer Received',
        subtitle: 'Your question was answered',
        time: '1 day ago',
        color: AppColors.success,
      ),
    ];

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: activities.asMap().entries.map((entry) {
          final index = entry.key;
          final activity = entry.value;
          return Column(
            children: [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: activity.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(activity.icon, color: activity.color, size: 20),
                ),
                title: AppText.body(
                  activity.title,
                  fontWeight: FontWeight.w500,
                ),
                subtitle: AppText.caption(
                  activity.subtitle,
                  color: AppColors.textSecondary,
                ),
                trailing: AppText.caption(
                  activity.time,
                  color: AppColors.textMuted,
                ),
              ),
              if (index < activities.length - 1)
                const Divider(height: 1, indent: 72),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _ActivityItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final Color color;

  _ActivityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
  });
}

/// Home Stats Widget
class HomeStats extends StatelessWidget {
  final int questionsAsked;
  final int questionsAnswered;
  final int locationsShared;

  const HomeStats({
    super.key,
    this.questionsAsked = 0,
    this.questionsAnswered = 0,
    this.locationsShared = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatItem(
            value: questionsAsked.toString(),
            label: 'Asked',
            color: AppColors.primary,
          ),
        ),
        Expanded(
          child: _StatItem(
            value: questionsAnswered.toString(),
            label: 'Answered',
            color: AppColors.accent,
          ),
        ),
        Expanded(
          child: _StatItem(
            value: locationsShared.toString(),
            label: 'Shared',
            color: AppColors.warning,
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard.outlined(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          AppText.h4(value, color: color),
          const SizedBox(height: 4),
          AppText.caption(label, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}
