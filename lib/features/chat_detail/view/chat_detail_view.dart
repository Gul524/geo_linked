import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/chat_detail_controller.dart';
import '../widgets/chat_detail_widgets.dart';

/// Chat Detail View
class ChatDetailView extends ConsumerWidget {
  const ChatDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatDetailControllerProvider);
    final controller = ref.read(chatDetailControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0A0F) : Colors.white,
      body: Column(
        children: [
          if (state.question != null)
            ChatHeader(
              question: state.question!,
              onBack: () => Navigator.of(context).pop(),
              isDark: isDark,
            ),
          Expanded(
            child: state.isLoading
                ? const _LoadingView()
                : _ChatContent(
                    state: state,
                    controller: controller,
                    isDark: isDark,
                  ),
          ),
          ChatInputBar(
            text: state.inputText,
            canSend: state.canSend,
            isSending: state.isSending,
            onChanged: controller.setInputText,
            onSend: controller.sendMessage,
            onLocation: () => _shareLocation(context),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  void _shareLocation(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Sharing location...')));
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: Color(0xFF0047AB)),
    );
  }
}

class _ChatContent extends StatelessWidget {
  final ChatDetailState state;
  final ChatDetailController controller;
  final bool isDark;

  const _ChatContent({
    required this.state,
    required this.controller,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        if (state.question != null)
          QuestionBubble(question: state.question!, isDark: isDark),
        const _RepliesHeader(),
        ...state.messages.map(
          (message) => MessageBubble(
            message: message,
            onHelpful: () => controller.markHelpful(message.id),
            onVerify: () => controller.verifyMessage(message.id),
            isDark: isDark,
          ),
        ),
      ],
    );
  }
}

class _RepliesHeader extends StatelessWidget {
  const _RepliesHeader();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            'Replies',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 1,
              color: (isDark ? Colors.white : Colors.black).withValues(
                alpha: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
