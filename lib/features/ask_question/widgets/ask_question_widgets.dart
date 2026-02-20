import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/widgets.dart';
import '../controller/ask_question_controller.dart';

/// Category Selector Widget
class CategorySelector extends StatelessWidget {
  final QuestionCategory selectedCategory;
  final ValueChanged<QuestionCategory> onCategorySelected;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: QuestionCategory.values.map((category) {
        final isSelected = category == selectedCategory;
        return GestureDetector(
          onTap: () => onCategorySelected(category),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.border,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(category.icon),
                const SizedBox(width: 6),
                AppText.body(
                  category.displayName,
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// Tags List Widget
class TagsList extends StatelessWidget {
  final List<String> tags;
  final ValueChanged<String> onRemoveTag;

  const TagsList({super.key, required this.tags, required this.onRemoveTag});

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) {
      return AppText.caption(
        'No tags added yet (max 5)',
        color: AppColors.textMuted,
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText.caption(tag, color: AppColors.primary),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () => onRemoveTag(tag),
                child: const Icon(
                  Icons.close,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

/// Question Guidelines Widget
class QuestionGuidelines extends StatelessWidget {
  const QuestionGuidelines({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard.outlined(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lightbulb_outline,
                color: AppColors.warning,
                size: 20,
              ),
              const SizedBox(width: 8),
              AppText.body(
                'Tips for a good question',
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _GuidelineItem(
            icon: Icons.check_circle_outline,
            text: 'Be specific and clear about what you need',
          ),
          _GuidelineItem(
            icon: Icons.check_circle_outline,
            text: 'Include relevant details and context',
          ),
          _GuidelineItem(
            icon: Icons.check_circle_outline,
            text: 'Use appropriate tags for better visibility',
          ),
          _GuidelineItem(
            icon: Icons.check_circle_outline,
            text: 'Share your location for location-based help',
          ),
        ],
      ),
    );
  }
}

class _GuidelineItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _GuidelineItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.success),
          const SizedBox(width: 8),
          Expanded(
            child: AppText.caption(text, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

/// Question Preview Card Widget
class QuestionPreviewCard extends StatelessWidget {
  final String title;
  final String description;
  final QuestionCategory category;
  final List<String> tags;
  final bool includeLocation;

  const QuestionPreviewCard({
    super.key,
    required this.title,
    required this.description,
    required this.category,
    required this.tags,
    required this.includeLocation,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppText.caption('Preview', color: AppColors.textMuted),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(category.icon, style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    AppText.caption(
                      category.displayName,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppText.body(
            title.isNotEmpty ? title : 'Your question title',
            fontWeight: FontWeight.w600,
            color: title.isNotEmpty
                ? AppColors.textPrimary
                : AppColors.textMuted,
          ),
          const SizedBox(height: 8),
          AppText.body(
            description.isNotEmpty
                ? description
                : 'Your question description...',
            color: description.isNotEmpty
                ? AppColors.textSecondary
                : AppColors.textMuted,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          if (tags.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: AppText.caption('#$tag'),
                );
              }).toList(),
            ),
          ],
          if (includeLocation) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 14,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 4),
                AppText.caption(
                  'Location included',
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
