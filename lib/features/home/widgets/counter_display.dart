import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_text.dart';

/// Counter Display Widget
class CounterDisplay extends StatelessWidget {
  final int count;

  const CounterDisplay({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.caption('Current Count'),
          const SizedBox(height: 8),
          AppText.h1(count.toString(), color: AppColors.primary),
        ],
      ),
    );
  }
}
