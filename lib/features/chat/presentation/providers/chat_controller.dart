import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/echo_hall_service.dart';
import 'package:hanzi_master/core/services/audio_recording_service.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/core/models/pronunciation_grade.dart';
import '../../domain/entities/chat_message.dart';
import 'package:uuid/uuid.dart';
import 'package:lpinyin/lpinyin.dart';

enum ScholarPersona {
  masterLin,
  xiaoMei,
  poet,
  gamer,
  shanghaiWoman,
  custom,
}

class ChatState {
  final List<GradedChatMessage> messages;
  final bool isLoading;
  final bool isRecording;
  final ScholarPersona activePersona;
  final String? customPrompt;

  ChatState({
    required this.messages,
    required this.isLoading,
    this.isRecording = false,
    required this.activePersona,
    this.customPrompt,
  });

  ChatState copyWith({
    List<GradedChatMessage>? messages,
    bool? isLoading,
    bool? isRecording,
    ScholarPersona? activePersona,
    String? customPrompt,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isRecording: isRecording ?? this.isRecording,
      activePersona: activePersona ?? this.activePersona,
      customPrompt: customPrompt ?? this.customPrompt,
    );
  }
}

class ChatController extends StateNotifier<ChatState> {
  final EchoHallService _echoHallService;
  final AudioRecordingService _audioService;
  final GeminiService _geminiService;
  final _uuid = const Uuid();

  ChatController({
    required EchoHallService echoHallService,
    required AudioRecordingService audioService,
    required GeminiService geminiService,
  }) : _echoHallService = echoHallService,
       _audioService = audioService,
       _geminiService = geminiService,
       super(ChatState(
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
    _initiateConversation(persona, customPrompt);
  }

  void clearHistory() {
    state = state.copyWith(messages: []);
    _initiateConversation(state.activePersona, state.customPrompt);
  }

  Future<void> _initiateConversation(ScholarPersona persona, String? customPrompt) async {
    state = state.copyWith(isLoading: true);
    try {
      final replyJson = await _echoHallService.getConversationResponse(
        [],
        "\${_getUnifiedPrompt(persona, customPrompt)}\n\nUSER: Start the conversation naturally."
      );
      
      final aiMsg = GradedChatMessage(
        id: _uuid.v4(),
        content: replyJson['chinese'] ?? '你好！',
        pinyin: replyJson['pinyin'],
        english: replyJson['english'],
        suggestion: replyJson['suggestion'],
        role: ChatRole.scholar,
        timestamp: DateTime.now(),
      );
      state = state.copyWith(messages: [aiMsg], isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    final userMessage = GradedChatMessage(
      id: _uuid.v4(),
      content: content,
      role: ChatRole.user,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
    );

    await _fetchAiResponse();
  }

  Future<void> startRecording() async {
    try {
      await _audioService.startRecording('chat_user_reply');
      state = state.copyWith(isRecording: true);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> stopRecordingAndProcess() async {
    if (!state.isRecording) return;
    
    try {
      final path = await _audioService.stopRecording();
      state = state.copyWith(isRecording: false, isLoading: true);

      if (path != null) {
        final file = File(path);
        final bytes = await file.readAsBytes();
        
        final gradeMap = await _geminiService.gradeAudio(bytes, "", "");
        final grade = PronunciationGrade.fromJson(gradeMap);
        
        final transcribedText = grade.words.map((w) => w.word).join();
        
        final userMsg = GradedChatMessage(
          id: _uuid.v4(),
          content: transcribedText.isEmpty ? "(inaudible)" : transcribedText,
          role: ChatRole.user,
          timestamp: DateTime.now(),
          grade: grade,
        );
        
        state = state.copyWith(messages: [...state.messages, userMsg]);
        await _fetchAiResponse();
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _fetchAiResponse() async {
    try {
      final replyJson = await _echoHallService.getConversationResponse(
        state.messages,
        _getUnifiedPrompt(state.activePersona, state.customPrompt),
      );

      final scholarMessage = GradedChatMessage(
        id: _uuid.v4(),
        content: replyJson['chinese'] ?? '',
        pinyin: replyJson['pinyin'],
        english: replyJson['english'],
        suggestion: replyJson['suggestion'],
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
        return "You are Master Lin, a traditional Chinese calligrapher. You are strict, formal, and polite. You value precision and history. Respond only in Chinese (Simplified). Do not provide Pinyin. Focus on the beauty of characters and radical meanings.";
      case ScholarPersona.xiaoMei:
        return "You are Xiao Mei, a friendly and chatty teahouse regular. You use casual language and modern HSK 1/2 vocabulary. You are encouraging and love to talk about daily life and food. Respond only in Chinese (Simplified). Do not provide Pinyin.";
      case ScholarPersona.poet:
        return "You are a time-traveling apprentice of the poet Li Bai. You speak in metaphors and admire the poetic nature of life. You are artistic and slightly archaic. Respond only in Chinese (Simplified). Do not provide Pinyin.";
      case ScholarPersona.gamer:
        return "You are A-Qiang, a 19-year-old e-sports fan. You love gaming and internet culture. You use a lot of modern internet slang (like 666, NB, 躺平). Respond only in Chinese (Simplified). Do not provide Pinyin. Be energetic and casual.";
      case ScholarPersona.shanghaiWoman:
        return "You are Vivian, a trendy young professional from Shanghai. You are sophisticated, ambitious, and work in fashion/tech. You occasionally mix in English words (Chinglish) and use modern urban slang. Respond only in Chinese (Simplified). Do not provide Pinyin.";
      case ScholarPersona.custom:
        return "You are following this custom persona description: ${customPrompt ?? 'A helpful Chinese teacher'}. Respond only in Chinese (Simplified). Do not provide Pinyin.";
    }
  }
}

final chatControllerProvider = StateNotifierProvider<ChatController, ChatState>((ref) {
  return ChatController(
    echoHallService: ref.watch(echoHallServiceProvider),
    audioService: ref.watch(audioRecordingServiceProvider),
    geminiService: ref.watch(geminiServiceProvider),
  );
});
