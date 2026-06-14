import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/scenario.dart';
import '../../../../core/services/echo_hall_service.dart';
import '../../../../core/services/audio_recording_service.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../../core/models/pronunciation_grade.dart';
import '../../../chat/domain/entities/chat_message.dart';

final conversationControllerProvider = StateNotifierProvider<ConversationController, ConversationState>((ref) {
  return ConversationController(
    echoHallService: ref.watch(echoHallServiceProvider),
    audioService: ref.watch(audioRecordingServiceProvider),
    geminiService: ref.watch(geminiServiceProvider),
  );
});

class ConversationState {
  final ConversationScenario? currentScenario;
  final List<GradedChatMessage> messages;
  final bool isRecording;
  final bool isProcessing;
  final String? error;

  ConversationState({
    this.currentScenario,
    this.messages = const [],
    this.isRecording = false,
    this.isProcessing = false,
    this.error,
  });

  ConversationState copyWith({
    ConversationScenario? currentScenario,
    List<GradedChatMessage>? messages,
    bool? isRecording,
    bool? isProcessing,
    String? error,
  }) {
    return ConversationState(
      currentScenario: currentScenario ?? this.currentScenario,
      messages: messages ?? this.messages,
      isRecording: isRecording ?? this.isRecording,
      isProcessing: isProcessing ?? this.isProcessing,
      error: error, // Can be null
    );
  }
}

class GradedChatMessage extends ChatMessage {
  final PronunciationGrade? grade;

  GradedChatMessage({
    required super.id,
    required super.content,
    required super.role,
    required super.timestamp,
    this.grade,
  });
}

class ConversationController extends StateNotifier<ConversationState> {
  final EchoHallService _echoHallService;
  final AudioRecordingService _audioService;
  final GeminiService _geminiService;

  ConversationController({
    required EchoHallService echoHallService,
    required AudioRecordingService audioService,
    required GeminiService geminiService,
  })  : _echoHallService = echoHallService,
        _audioService = audioService,
        _geminiService = geminiService,
        super(ConversationState());

  void startScenario(ConversationScenario scenario) {
    state = ConversationState(
      currentScenario: scenario,
      messages: [
        GradedChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: scenario.initialAiMessage,
          role: ChatRole.scholar,
          timestamp: DateTime.now(),
        )
      ],
    );
  }

  Future<void> startRecording() async {
    try {
      state = state.copyWith(error: null);
      await _audioService.startRecording('user_reply');
      state = state.copyWith(isRecording: true);
    } catch (e) {
      state = state.copyWith(error: "Could not start mic: $e");
    }
  }

  Future<void> stopRecordingAndProcess() async {
    if (!state.isRecording) return;
    
    try {
      final path = await _audioService.stopRecording();
      state = state.copyWith(isRecording: false, isProcessing: true);

      if (path != null) {
        final file = File(path);
        final bytes = await file.readAsBytes();
        
        // 1. Send Audio to Gemini for grading
        // Wait, what is the expected text? For a conversational reply, the user can say ANYTHING!
        // But our Gemini prompt says: "Listen to the user trying to say expectedChinese".
        // Ah! If it's a conversation, we don't know what they will say.
        // We need Gemini to TRANSCRIBE and GRADE.
        // Let's modify GeminiService to transcribe if expected is empty!
        
        final gradeMap = await _geminiService.gradeAudio(bytes, "", "");
        final grade = PronunciationGrade.fromJson(gradeMap);
        
        // The transcribed text is essentially the concatenation of words
        final transcribedText = grade.words.map((w) => w.word).join();
        
        final userMsg = GradedChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: transcribedText.isEmpty ? "(inaudible)" : transcribedText,
          role: ChatRole.user,
          timestamp: DateTime.now(),
          grade: grade,
        );
        
        state = state.copyWith(messages: [...state.messages, userMsg]);

        // 2. Send to DeepSeek
        final reply = await _echoHallService.getResponse(state.messages, state.currentScenario!.systemPrompt);
        
        final aiMsg = GradedChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: reply,
          role: ChatRole.scholar,
          timestamp: DateTime.now(),
        );
        
        state = state.copyWith(messages: [...state.messages, aiMsg], isProcessing: false);
      }
    } catch (e) {
      state = state.copyWith(isProcessing: false, error: "Processing failed: $e");
    }
  }
}
