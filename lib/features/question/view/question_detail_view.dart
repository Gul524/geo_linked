import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/widgets.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

/// Question Detail View - Shows full question and answers
class QuestionDetailView extends ConsumerWidget {
  final Question question;

  const QuestionDetailView({super.key, required this.question});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionState = ref.watch(questionControllerProvider);
    final answerController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: AppText.h5('Question'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            ref
                .read(questionControllerProvider.notifier)
                .clearSelectedQuestion();
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              AppSnackbar.info(context, message: 'Sharing question...');
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showOptionsSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question content
                  QuestionDetailCard(question: question),
                  const SizedBox(height: 24),

                  // Answers section
                  Row(
                    children: [
                      AppText.h5('Answers'),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: AppText.caption(
                          '${questionState.answers.length}',
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Answers list
                  if (questionState.answers.isEmpty)
                    AppEmptyState.noData(
                      title: 'No Answers Yet',
                      message: 'Be the first to answer this question!',
                    )
                  else
                    ...questionState.answers.map((answer) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AnswerCard(answer: answer),
                      );
                    }),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),

          // Answer input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: AppTextField.text(
                      controller: answerController,
                      hintText: 'Write your answer...',
                    ),
                  ),
                  const SizedBox(width: 12),
                  AppIconButton.circle(
                    icon: Icons.send,
                    backgroundColor: AppColors.primary,
                    iconColor: Colors.white,
                    onPressed: () {
                      if (answerController.text.trim().isNotEmpty) {
                        AppSnackbar.success(
                          context,
                          message: 'Answer submitted!',
                        );
                        answerController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOptionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            AppListTile(
              title: 'Save Question',
              leadingIcon: Icons.bookmark_outline,
              onTap: () {
                Navigator.pop(context);
                AppSnackbar.success(context, message: 'Question saved!');
              },
            ),
            AppListTile(
              title: 'Report Question',
              leadingIcon: Icons.flag_outlined,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            AppListTile(
              title: 'Copy Link',
              leadingIcon: Icons.link,
              onTap: () {
                Navigator.pop(context);
                AppSnackbar.info(context, message: 'Link copied!');
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
