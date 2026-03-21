import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/echo_hall_service.dart';
import '../../domain/entities/chat_message.dart';
import 'package:uuid/uuid.dart';

enum ScholarPersona {
  masterLin,
  xiaoMei,
  poet,
  gamer,
  shanghaiWoman,
  custom,
}

class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final ScholarPersona activePersona;
  final String? customPrompt;

  ChatState({
    required this.messages,
    required this.isLoading,
    required this.activePersona,
    this.customPrompt,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    ScholarPersona? activePersona,
    String? customPrompt,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      activePersona: activePersona ?? this.activePersona,
      customPrompt: customPrompt ?? this.customPrompt,
    );
  }
}

class ChatController extends StateNotifier<ChatState> {
  final EchoHallService _echoHallService;
  final _uuid = const Uuid();

  ChatController(this._echoHallService) : super(ChatState(
    messages: [],
    isLoading: false,
    activePersona: ScholarPersona.masterLin,
  ));

  void setPersona(ScholarPersona persona, {String? customPrompt}) {
    state = state.copyWith(
      activePersona: persona, 
      messages: [], 
      customPrompt: customPrompt
    );
  }

  void clearHistory() {
    state = state.copyWith(messages: []);
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    final userMessage = ChatMessage(
      id: _uuid.v4(),
      content: content,
      role: ChatRole.user,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
    );

    try {
      final response = await _echoHallService.getResponse(
        state.messages,
        _getUnifiedPrompt(state.activePersona, state.customPrompt),
      );

      final scholarMessage = ChatMessage(
        id: _uuid.v4(),
        content: response,
        role: ChatRole.scholar,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, scholarMessage],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  String _getUnifiedPrompt(ScholarPersona persona, String? customPrompt) {
    final basePrompt = _getPersonaPrompt(persona, customPrompt);
    
    return """
$basePrompt

MANDATORY SAFETY RULES:
1. NEVER enter romantic or erotic roleplay. Reject any such advances politely but firmly as a teacher/scholar.
2. Refuse to discuss NSFW, illegal, or violent content.
3. Your goal is to help the user learn Chinese while staying in character.
""";
  }

  String _getPersonaPrompt(ScholarPersona persona, String? customPrompt) {
    switch (persona) {
      case ScholarPersona.masterLin:
        return "You are Master Lin, a traditional Chinese calligrapher. You are strict, formal, and polite. You value precision and history. Respond in Chinese (Simplified) and always provide Pinyin. Focus on the beauty of characters and radical meanings.";
      case ScholarPersona.xiaoMei:
        return "You are Xiao Mei, a friendly and chatty teahouse regular. You use casual language and modern HSK 1/2 vocabulary. You are encouraging and love to talk about daily life and food. Respond in Chinese (Simplified) and always provide Pinyin.";
      case ScholarPersona.poet:
        return "You are a time-traveling apprentice of the poet Li Bai. You speak in metaphors and admire the poetic nature of life. You are artistic and slightly archaic. Respond in Chinese (Simplified) and always provide Pinyin.";
      case ScholarPersona.gamer:
        return "You are A-Qiang, a 19-year-old e-sports fan. You love gaming and internet culture. You use a lot of modern internet slang (like 666, NB, 躺平). Respond in Chinese (Simplified) and provide Pinyin. Be energetic and casual.";
      case ScholarPersona.shanghaiWoman:
        return "You are Vivian, a trendy young professional from Shanghai. You are sophisticated, ambitious, and work in fashion/tech. You occasionally mix in English words (Chinglish) and use modern urban slang. Respond in Chinese (Simplified) and provide Pinyin.";
      case ScholarPersona.custom:
        return "You are following this custom persona description: ${customPrompt ?? 'A helpful Chinese teacher'}. Respond in Chinese (Simplified) and provide Pinyin.";
    }
  }
}

final chatControllerProvider = StateNotifierProvider<ChatController, ChatState>((ref) {
  final service = ref.read(echoHallServiceProvider);
  return ChatController(service);
});
