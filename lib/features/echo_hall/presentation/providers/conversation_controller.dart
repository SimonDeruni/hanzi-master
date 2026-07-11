import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/scenario.dart';
import '../../../../core/services/echo_hall_service.dart';
import '../../../../core/services/audio_recording_service.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../../core/models/pronunciation_grade.dart';
import '../../../chat/domain/entities/chat_message.dart';

final conversationControllerProvider = StateNotifierProvider.autoDispose<ConversationController, ConversationState>((ref) {
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

  Future<void> startScenario(ConversationScenario scenario) async {
    // Clear any previous scenario state to prevent bleed
    state = ConversationState(
      currentScenario: scenario,
      messages: [],
      isProcessing: true,
      error: null,
    );

    try {
      // Build a hardened prompt that anchors the persona
      final hardenedPrompt = '${scenario.systemPrompt}\n\nCRITICAL: You are "${scenario.personaName}". Stay in this exact persona. Do not switch characters, introduce yourself differently, or reference other scenarios.';
      
      final replyJson = await _echoHallService.getConversationResponse(
        [], // empty history
        "$hardenedPrompt\n\nUSER: Please start the conversation according to the scenario. Your first message should be similar to: '${scenario.initialAiMessage}'"
      );

      final aiMsg = GradedChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: replyJson['chinese'] ?? scenario.initialAiMessage,
        pinyin: replyJson['pinyin'],
        english: replyJson['english'],
        suggestion: replyJson['suggestion'],
        role: ChatRole.scholar,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(messages: [aiMsg], isProcessing: false);
    } catch (e) {
      // Fallback with error so user can retry
      state = state.copyWith(
        messages: [
          GradedChatMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            content: scenario.initialAiMessage,
            role: ChatRole.scholar,
            timestamp: DateTime.now(),
          )
        ],
        isProcessing: false,
        error: "The Scholar needs a moment. Tap Retry to try again.",
      );
    }
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    final userMsg = GradedChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      role: ChatRole.user,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMsg],
      isProcessing: true,
      error: null,
    );

    await _fetchAiResponse();
  }

  Future<void> startRecording() async {
    try {
      state = state.copyWith(error: null);
      await _audioService.startRecording('user_reply');
      state = state.copyWith(isRecording: true);
    } catch (e) {
      final msg = e.toString().toLowerCase();
      if (msg.contains('permission')) {
        state = state.copyWith(
          error: "Microphone access is required. Please enable it in your device Settings.",
        );
      } else {
        state = state.copyWith(
          error: "Could not start microphone. Please check your audio settings and try again.",
        );
      }
    }
  }

  Future<void> stopRecordingAndProcess() async {
    if (!state.isRecording) return;
    
    try {
      final path = await _audioService.stopRecording();
      state = state.copyWith(isRecording: false, isProcessing: true);

      if (path == null) {
        state = state.copyWith(
          isProcessing: false,
          error: "We didn't quite catch that. Please hold the mic and try again!",
        );
        return;
      }

      final file = File(path);
      final length = await file.length();

      // Minimum recording: ~0.25s of 16kHz mono 16-bit PCM = 8000 bytes
      // WAV header adds ~44 bytes. Reject anything shorter.
      if (length < 2000) {
        state = state.copyWith(
          isProcessing: false,
          error: "Recording was too short. Hold the mic and speak clearly.",
        );
        return;
      }

      final bytes = await file.readAsBytes();
      if (bytes.length < 2000) {
        state = state.copyWith(
          isProcessing: false,
          error: "Audio buffer was empty. Please check your microphone and try again.",
        );
        return;
      }

      // Validate that we have actual audio data, not just WAV header
      final nonHeaderBytes = bytes.length > 44 ? bytes.sublist(44) : bytes;
      final hasAudioData = nonHeaderBytes.any((b) => b != 0);
      if (!hasAudioData) {
        state = state.copyWith(
          isProcessing: false,
          error: "Audio file is silent. Please speak into the microphone.",
        );
        return;
      }
      
      // 1. Send Audio to Azure for Unscripted Pronunciation Assessment
      try {
        final gradeMap = await _geminiService.gradeAudioUnscripted(bytes);
        final grade = PronunciationGrade.fromJson(gradeMap);
        
        final transcribedText = gradeMap['text'] ?? '';
        
        final userMsg = GradedChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: transcribedText.isEmpty ? "(inaudible)" : transcribedText,
          role: ChatRole.user,
          timestamp: DateTime.now(),
          grade: grade,
        );
        
        state = state.copyWith(messages: [...state.messages, userMsg]);
        await _fetchAiResponse();
      } catch (e) {
        final msg = e.toString().toLowerCase();
        if (msg.contains('nomatch') || msg.contains('no nbest') || msg.contains('inaudible')) {
          state = state.copyWith(
            isProcessing: false,
            error: "We couldn't understand your pronunciation. Please speak clearly and try again.",
          );
        } else if (msg.contains('timeout') || msg.contains('timed out')) {
          state = state.copyWith(
            isProcessing: false,
            error: "The server is taking too long to respond. Please try again.",
          );
        } else if (msg.contains('socket') || msg.contains('network') || msg.contains('connection')) {
          state = state.copyWith(
            isProcessing: false,
            error: "No internet connection. Please check your network and try again.",
          );
        } else {
          state = state.copyWith(
            isProcessing: false,
            error: "Audio processing failed. Please try again.",
          );
        }
      }
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('Permission') || msg.contains('permission')) {
        state = state.copyWith(
          isRecording: false,
          isProcessing: false,
          error: "Microphone access is required. Please enable it in your device Settings.",
        );
      } else {
        state = state.copyWith(
          isRecording: false,
          isProcessing: false,
          error: "Could not process your recording. Please try again.",
        );
      }
    }
  }

  Future<void> _fetchAiResponse() async {
    try {
      // Re-anchor persona on every turn to prevent drift
      final hardenedPrompt = '${state.currentScenario!.systemPrompt}\n\nCRITICAL: You are "${state.currentScenario!.personaName}". Stay in this exact persona. Do not switch characters.';
      
      final replyJson = await _echoHallService.getConversationResponse(state.messages, hardenedPrompt);
      
      final aiMsg = GradedChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: replyJson['chinese'] ?? '',
        pinyin: replyJson['pinyin'],
        english: replyJson['english'],
        suggestion: replyJson['suggestion'],
        role: ChatRole.scholar,
        timestamp: DateTime.now(),
      );
      
      state = state.copyWith(messages: [...state.messages, aiMsg], isProcessing: false);
    } catch (e) {
      // Catch ALL error types (not just Exception) and guarantee isProcessing reset
      final msg = e.toString().toLowerCase();
      if (msg.contains('timeout') || msg.contains('timed out')) {
        state = state.copyWith(
          isProcessing: false,
          error: "The server is taking too long to respond. Please try again.",
        );
      } else if (msg.contains('socket') || msg.contains('network') || msg.contains('connection')) {
        state = state.copyWith(
          isProcessing: false,
          error: "No internet connection. Please check your network and try again.",
        );
      } else {
        state = state.copyWith(
          isProcessing: false,
          error: "Our AI tutors are currently offline, please try again later.",
        );
      }
    }
  }

  Future<void> retry() async {
    state = state.copyWith(error: null, isProcessing: true);
    await _fetchAiResponse();
    // Safety net: if _fetchAiResponse somehow didn't reset isProcessing
    if (state.isProcessing) {
      state = state.copyWith(isProcessing: false);
    }
  }
}
