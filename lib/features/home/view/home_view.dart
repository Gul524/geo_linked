import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/widgets.dart';
import '../../google_map/view/google_map_view.dart';
import '../../settings/view/settings_view.dart';
import '../../ask_question/view/ask_question_view.dart';
import '../../question/view/question_view.dart';
import '../controller/controller.dart';
import '../widgets/widgets.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: AppText.h5('GeoLinked'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsView()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome Section
              const HomeWelcomeCard(),
              const SizedBox(height: 24),

              // Quick Actions Grid
              AppText.h5('Quick Actions'),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  HomeActionCard(
                    icon: Icons.map_outlined,
                    title: 'View Map',
                    subtitle: 'Explore locations',
                    color: AppColors.primary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const GoogleMapView(),
                        ),
                      );
                    },
                  ),
                  HomeActionCard(
                    icon: Icons.question_answer_outlined,
                    title: 'Ask Question',
                    subtitle: 'Get help',
                    color: AppColors.accent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AskQuestionView(),
                        ),
                      );
                    },
                  ),
                  HomeActionCard(
                    icon: Icons.quiz_outlined,
                    title: 'Questions',
                    subtitle: 'Browse all',
                    color: AppColors.warning,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const QuestionView()),
                      );
                    },
                  ),
                  HomeActionCard(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    subtitle: 'Preferences',
                    color: AppColors.secondary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsView()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Recent Activity
              AppText.h5('Recent Activity'),
              const SizedBox(height: 16),
              const HomeRecentActivity(),
            ],
          ),
        ),
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
}
