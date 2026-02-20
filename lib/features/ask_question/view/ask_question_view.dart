import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/widgets.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

/// Ask Question View - Screen for posting new questions
class AskQuestionView extends ConsumerStatefulWidget {
  const AskQuestionView({super.key});

  @override
  ConsumerState<AskQuestionView> createState() => _AskQuestionViewState();
}

class _AskQuestionViewState extends ConsumerState<AskQuestionView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await ref
          .read(askQuestionControllerProvider.notifier)
          .submitQuestion();
      if (success && mounted) {
        AppSnackbar.success(context, message: 'Question posted successfully!');
        Navigator.pop(context);
      }
    }
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty) {
      ref.read(askQuestionControllerProvider.notifier).addTag(tag);
      _tagController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final askState = ref.watch(askQuestionControllerProvider);
    final askController = ref.read(askQuestionControllerProvider.notifier);

    return AppLoadingOverlay(
      isLoading: askState.isLoading,
      loadingText: 'Posting question...',
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: AppText.h5('Ask a Question'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            TextButton(
              onPressed: askState.isFormValid ? _handleSubmit : null,
              child: AppText.body(
                'Post',
                color: askState.isFormValid
                    ? AppColors.primary
                    : AppColors.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Error message
                if (askState.error != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: AppColors.error),
                        const SizedBox(width: 8),
                        Expanded(
                          child: AppText.body(
                            askState.error!,
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Title
                AppText.body('Question Title', fontWeight: FontWeight.w600),
                const SizedBox(height: 8),
                AppTextField.text(
                  controller: _titleController,
                  hintText: 'What would you like to ask?',
                  maxLength: 100,
                  onChanged: askController.setTitle,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a title';
                    }
                    if (value.trim().length < 10) {
                      return 'Title must be at least 10 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Description
                AppText.body('Description', fontWeight: FontWeight.w600),
                const SizedBox(height: 8),
                AppTextField.multiline(
                  controller: _descriptionController,
                  hintText: 'Provide more details about your question...',
                  maxLength: 500,
                  minLines: 4,
                  maxLines: 8,
                  onChanged: askController.setDescription,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a description';
                    }
                    if (value.trim().length < 20) {
                      return 'Description must be at least 20 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Category
                AppText.body('Category', fontWeight: FontWeight.w600),
                const SizedBox(height: 8),
                CategorySelector(
                  selectedCategory: askState.category,
                  onCategorySelected: askController.setCategory,
                ),
                const SizedBox(height: 20),

                // Tags
                AppText.body('Tags (optional)', fontWeight: FontWeight.w600),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField.text(
                        controller: _tagController,
                        hintText: 'Add a tag',
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _addTag(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    AppIconButton.circle(
                      icon: Icons.add,
                      backgroundColor: AppColors.primary,
                      iconColor: Colors.white,
                      onPressed: _addTag,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TagsList(
                  tags: askState.tags,
                  onRemoveTag: askController.removeTag,
                ),
                const SizedBox(height: 20),

                // Location toggle
                AppCard.outlined(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.body(
                              'Include Location',
                              fontWeight: FontWeight.w500,
                            ),
                            AppText.caption(
                              'Share your current location with the question',
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: askState.includeLocation,
                        onChanged: (_) => askController.toggleIncludeLocation(),
                        activeColor: AppColors.primary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Submit button
                AppButton.primary(
                  text: 'Post Question',
                  onPressed: _handleSubmit,
                  size: AppButtonSize.large,
                  width: double.infinity,
                  icon: Icons.send,
                ),
                const SizedBox(height: 16),

                // Guidelines
                const QuestionGuidelines(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
