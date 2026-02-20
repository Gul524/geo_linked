import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/widgets.dart';
import '../../ask_question/view/ask_question_view.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';
import 'question_detail_view.dart';

/// Question View - Main questions listing screen
class QuestionView extends ConsumerStatefulWidget {
  const QuestionView({super.key});

  @override
  ConsumerState<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends ConsumerState<QuestionView> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(questionControllerProvider.notifier).loadQuestions();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(questionControllerProvider);
    final questionController = ref.read(questionControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: AppText.h5('Questions'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppTextField.text(
              controller: _searchController,
              hintText: 'Search questions...',
              prefixIcon: Icons.search,
              suffixIcon: _searchController.text.isNotEmpty
                  ? Icons.clear
                  : null,
              onSuffixTap: () {
                _searchController.clear();
                questionController.setSearchQuery('');
                questionController.loadQuestions();
              },
              onChanged: (value) {
                questionController.setSearchQuery(value);
              },
              onSubmitted: (_) => questionController.search(),
            ),
          ),

          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: QuestionFilter.values.map((filter) {
                final isSelected = filter == questionState.filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: AppText.caption(
                      filter.displayName,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                    selected: isSelected,
                    onSelected: (_) => questionController.setFilter(filter),
                    backgroundColor: AppColors.surface,
                    selectedColor: AppColors.primary,
                    checkmarkColor: Colors.white,
                    side: BorderSide(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Questions list
          Expanded(
            child: questionState.isLoading
                ? Center(child: AppLoading())
                : questionState.error != null
                ? Center(
                    child: AppEmptyState.error(
                      title: 'Error',
                      message: questionState.error,
                      buttonText: 'Retry',
                      onButtonPressed: questionController.loadQuestions,
                    ),
                  )
                : questionState.questions.isEmpty
                ? Center(
                    child: AppEmptyState.noData(
                      title: 'No Questions',
                      message: 'Be the first to ask a question!',
                      buttonText: 'Ask Question',
                      onButtonPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AskQuestionView(),
                          ),
                        );
                      },
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: questionController.loadQuestions,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount:
                          questionState.questions.length +
                          (questionState.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == questionState.questions.length) {
                          // Load more indicator
                          if (!questionState.isLoadingMore) {
                            questionController.loadMore();
                          }
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: AppLoading(size: AppLoadingSize.small),
                            ),
                          );
                        }

                        final question = questionState.questions[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: QuestionCard(
                            question: question,
                            onTap: () {
                              questionController.selectQuestion(question);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      QuestionDetailView(question: question),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: AppFab(
        icon: Icons.add,
        tooltip: 'Ask a question',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AskQuestionView()),
          );
        },
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const QuestionFilterSheet(),
    );
  }
}
