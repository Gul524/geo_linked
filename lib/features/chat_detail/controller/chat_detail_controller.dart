import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Message type
enum MessageType { text, location, image }

/// Chat message model
class ChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String? senderAvatar;
  final String content;
  final MessageType type;
  final DateTime timestamp;
  final bool isMe;
  final bool isVerified;
  final int helpfulCount;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    this.senderAvatar,
    required this.content,
    this.type = MessageType.text,
    required this.timestamp,
    this.isMe = false,
    this.isVerified = false,
    this.helpfulCount = 0,
  });

  ChatMessage copyWith({bool? isVerified, int? helpfulCount}) {
    return ChatMessage(
      id: id,
      senderId: senderId,
      senderName: senderName,
      senderAvatar: senderAvatar,
      content: content,
      type: type,
      timestamp: timestamp,
      isMe: isMe,
      isVerified: isVerified ?? this.isVerified,
      helpfulCount: helpfulCount ?? this.helpfulCount,
    );
  }
}

/// Question data for chat
class ChatQuestion {
  final String id;
  final String title;
  final String authorName;
  final String? authorAvatar;
  final String timeAgo;
  final String distance;
  final int replyCount;

  const ChatQuestion({
    required this.id,
    required this.title,
    required this.authorName,
    this.authorAvatar,
    required this.timeAgo,
    required this.distance,
    this.replyCount = 0,
  });
}

/// Chat Detail state
class ChatDetailState {
  final bool isLoading;
  final String? error;
  final ChatQuestion? question;
  final List<ChatMessage> messages;
  final String inputText;
  final bool isSending;

  const ChatDetailState({
    this.isLoading = false,
    this.error,
    this.question,
    this.messages = const [],
    this.inputText = '',
    this.isSending = false,
  });

  ChatDetailState copyWith({
    bool? isLoading,
    String? error,
    ChatQuestion? question,
    List<ChatMessage>? messages,
    String? inputText,
    bool? isSending,
  }) {
    return ChatDetailState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      question: question ?? this.question,
      messages: messages ?? this.messages,
      inputText: inputText ?? this.inputText,
      isSending: isSending ?? this.isSending,
    );
  }

  bool get canSend => inputText.trim().isNotEmpty && !isSending;
}

/// Chat Detail Controller
class ChatDetailController extends StateNotifier<ChatDetailState> {
  ChatDetailController() : super(const ChatDetailState()) {
    _loadChat();
  }

  /// Load chat data
  Future<void> _loadChat() async {
    state = state.copyWith(isLoading: true);

    await Future.delayed(const Duration(milliseconds: 500));

    final question = const ChatQuestion(
      id: '1',
      title: 'Best coffee shop with WiFi nearby?',
      authorName: 'Sarah M.',
      timeAgo: '30m ago',
      distance: '0.3km',
      replyCount: 5,
    );

    final messages = [
      ChatMessage(
        id: '1',
        senderId: 'user1',
        senderName: 'Alex',
        content:
            'Blue Bottle on Market St has great WiFi and excellent coffee! Usually not too crowded in mornings.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
        helpfulCount: 8,
        isVerified: true,
      ),
      ChatMessage(
        id: '2',
        senderId: 'user2',
        senderName: 'Jordan',
        content:
            'Agreed! Their single origin pour-over is amazing. I work from there all the time.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
        helpfulCount: 4,
      ),
      ChatMessage(
        id: '3',
        senderId: 'me',
        senderName: 'You',
        content: 'Thanks for the suggestions! Do they have power outlets?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        isMe: true,
      ),
      ChatMessage(
        id: '4',
        senderId: 'user1',
        senderName: 'Alex',
        content:
            'Yes! There are outlets at most tables, especially along the wall. Get there before 9 AM for best seating.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
        helpfulCount: 12,
        isVerified: true,
      ),
    ];

    state = state.copyWith(
      isLoading: false,
      question: question,
      messages: messages,
    );
  }

  /// Update input text
  void setInputText(String text) {
    state = state.copyWith(inputText: text);
  }

  /// Send message
  Future<void> sendMessage() async {
    if (!state.canSend) return;

    final text = state.inputText.trim();
    state = state.copyWith(inputText: '', isSending: true);

    // Simulate sending
    await Future.delayed(const Duration(milliseconds: 500));

    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'me',
      senderName: 'You',
      content: text,
      timestamp: DateTime.now(),
      isMe: true,
    );

    state = state.copyWith(
      messages: [...state.messages, newMessage],
      isSending: false,
    );
  }

  /// Mark message as helpful
  void markHelpful(String messageId) {
    final messages = state.messages.map((m) {
      if (m.id == messageId) {
        return m.copyWith(helpfulCount: m.helpfulCount + 1);
      }
      return m;
    }).toList();
    state = state.copyWith(messages: messages);
  }

  /// Verify message
  void verifyMessage(String messageId) {
    final messages = state.messages.map((m) {
      if (m.id == messageId) {
        return m.copyWith(isVerified: true);
      }
      return m;
    }).toList();
    state = state.copyWith(messages: messages);
  }

  /// Set error
  void setError(String? error) {
    state = state.copyWith(error: error);
  }
}

/// Chat Detail Controller Provider
final chatDetailControllerProvider =
    StateNotifierProvider<ChatDetailController, ChatDetailState>(
      (ref) => ChatDetailController(),
    );
