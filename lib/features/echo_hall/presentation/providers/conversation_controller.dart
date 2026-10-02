import 'dart:async';
import 'dart:io';
import 'package:hanzi_master/core/providers/l10n_provider.dart';
import 'package:hanzi_master/core/utils/network_failure.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/network_notice.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/scenario.dart';
import '../../../../core/services/echo_hall_service.dart';
import '../../../../core/services/audio_recording_service.dart';
import '../../../../core/services/gemini_service.dart';
import 'package:hanzi_master/core/models/pronunciation_grade.dart';
import '../../../chat/domain/entities/chat_message.dart';
import '../../../../core/utils/pinyin_utils.dart';

import 'package:lpinyin/lpinyin.dart';

import '../../../../core/services/local_translation_service.dart';

final conversationControllerProvider = StateNotifierProvider.autoDispose<ConversationController, ConversationState>((ref) {
  return ConversationController(
    echoHallService: ref.watch(echoHallServiceProvider),
    audioService: ref.watch(audioRecordingServiceProvider),
    geminiService: ref.watch(geminiServiceProvider),
    localTranslationService: ref.watch(localTranslationServiceProvider),
    // Read lazily from the catch block, never watched here: a locale change must
    // not rebuild this notifier and discard the conversation in progress.
    l10n: () => ref.read(l10nProvider),
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
  final LocalTranslationService _localTranslationService;

  /// Resolved at the moment of an error, so a provider failure can be described
  /// in the learner's own language instead of an English literal.
  final AppLocalizations Function() _l10n;

  ConversationController({
    required EchoHallService echoHallService,
    required AudioRecordingService audioService,
    required GeminiService geminiService,
    required LocalTranslationService localTranslationService,
    required AppLocalizations Function() l10n,
  })  : _echoHallService = echoHallService,
        _audioService = audioService,
        _geminiService = geminiService,
        _localTranslationService = localTranslationService,
        _l10n = l10n,
        super(ConversationState());

  Future<void> startScenario(ConversationScenario scenario) async {
    // Atomically wipe ALL previous state before loading the new scenario.
    // Using the hardcoded initialAiMessage guarantees the greeting always
    // matches the avatar — no LLM call means no possibility of persona bleed.
    final initialPinyin = (scenario.initialPinyin != null && scenario.initialPinyin!.isNotEmpty)
        ? PinyinUtils.convertNumericToMarks(scenario.initialPinyin!)
        : PinyinHelper.getPinyinE(scenario.initialAiMessage, separator: ' ', format: PinyinFormat.WITH_TONE_MARK);

    final isEnglishTarget = _localTranslationService.targetLanguage.toLowerCase() == 'english';
    final initialTranslation = isEnglishTarget ? scenario.initialEnglish : null;

    final initialMsgId = DateTime.now().millisecondsSinceEpoch.toString();
    state = ConversationState(
      currentScenario: scenario,
      messages: [
        GradedChatMessage(
          id: initialMsgId,
          content: scenario.initialAiMessage,
          role: ChatRole.scholar,
          timestamp: DateTime.now(),
          english: initialTranslation,
          pinyin: initialPinyin,
        ),
      ],
      isProcessing: false,
      error: null,
    );

    // If target language is non-English, pre-warm translation into the localized target language
    if (!isEnglishTarget && scenario.initialAiMessage.isNotEmpty) {
      unawaited(() async {
        try {
          final translated = await _localTranslationService.translate(scenario.initialAiMessage);
          if (mounted && state.messages.isNotEmpty && state.messages.first.id == initialMsgId) {
            final updatedMsg = state.messages.first.copyWith(english: translated);
            final updatedList = List<GradedChatMessage>.from(state.messages);
            updatedList[0] = updatedMsg;
            state = state.copyWith(messages: updatedList);
          }
        } catch (_) {}
      }());
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
          audioPath: path,
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
        } else if (NetworkFailure.isOffline(e)) {
          // Replaces a hand-rolled `contains('socket') || contains('network')`
          // sniff that missed the Firebase codes, and an English literal that
          // was the same sentence left untranslated in the other thirteen
          // locales the app ships. A timeout lands here too - `isOffline` counts
          // it, because an unanswered request is indistinguishable from a radio
          // that is off, from the learner's chair.
          state = state.copyWith(
            isProcessing: false,
            error: NetworkNotice.messageOf(_l10n()),
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

  String getChatHistory(String messageId) {
    final index = state.messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return "";
    
    // Take up to 10 previous messages for context
    final startIndex = (index - 10).clamp(0, index);
    final historyMessages = state.messages.sublist(startIndex, index);
    
    final buffer = StringBuffer();
    for (var msg in historyMessages) {
      final roleStr = msg.role == ChatRole.user ? "User" : "Scholar";
      buffer.writeln("$roleStr: ${msg.content}");
    }
    return buffer.toString().trim();
  }

  Future<void> regradeMessage(String messageId, String intendedHanzi, String intendedPinyin) async {
    final index = state.messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return;
    
    final msg = state.messages[index];
    if (msg.audioPath == null) return;
    
    try {
      final file = File(msg.audioPath!);
      if (!await file.exists()) return;
      
      final bytes = await file.readAsBytes();
      final gradeMap = await _geminiService.gradeAudio(bytes, intendedHanzi, intendedPinyin);
      final newGrade = PronunciationGrade.fromJson(gradeMap);
      
      final updatedMsg = msg.copyWith(
        grade: newGrade,
        content: intendedHanzi, // Update the content to the intended one!
      );
      
      final newMessages = List<GradedChatMessage>.from(state.messages);
      newMessages[index] = updatedMsg;
      
      state = state.copyWith(messages: newMessages);
    } catch (e) {
      // Ignore errors during re-grade, or log them
    }
  }

  Future<void> _fetchAiResponse() async {
    try {
      // 1. Translate the user's last message to target language if it is missing its translation
      final messages = List<GradedChatMessage>.from(state.messages);
      final lastUserIdx = messages.lastIndexWhere((m) => m.role == ChatRole.user);
      if (lastUserIdx != -1 && (messages[lastUserIdx].english == null || messages[lastUserIdx].english!.isEmpty)) {
        try {
          final translation = await _localTranslationService.translate(messages[lastUserIdx].content);
          final oldMsg = messages[lastUserIdx];
          messages[lastUserIdx] = GradedChatMessage(
            id: oldMsg.id,
            content: oldMsg.content,
            pinyin: oldMsg.pinyin,
            english: translation,
            suggestion: oldMsg.suggestion,
            role: ChatRole.user,
            timestamp: oldMsg.timestamp,
            grade: oldMsg.grade,
          );
          state = state.copyWith(messages: messages);
        } catch (e) {
          // Non-fatal, just log and continue
          debugPrint("ConversationController: Reverse translation error: $e");
        }
      }

      // Re-anchor persona on every turn to prevent drift
      final scenario = state.currentScenario!;
      final hardenedPrompt = '''${scenario.systemPrompt}

### MANDATORY PERSONA ENFORCEMENT ###
- You are playing the role of: "${scenario.personaName}" in the scenario: "${scenario.title}".
- Setting & Context: "${scenario.description}".
- Target HSK Level: HSK ${scenario.targetHskLevel}.
- RULE 1: NEVER break character or reveal that you are an AI, language model, or virtual assistant.
- RULE 2: ALWAYS respond strictly from the perspective of "${scenario.personaName}" in natural, authentic conversational Chinese suitable for your persona and role.
- RULE 3: Keep your responses interactive, natural, and concise (1-3 sentences). Continue the roleplay seamlessly.''';
      
      final replyJson = await _echoHallService.getConversationResponse(state.messages, hardenedPrompt);
      
      String? rawPinyin = replyJson['pinyin'];
      String? rawSuggestionPinyin = replyJson['suggestion']?['pinyin'];
      
      Map<String, dynamic>? formattedSuggestion;
      if (replyJson['suggestion'] != null) {
        formattedSuggestion = Map<String, dynamic>.from(replyJson['suggestion']);
        if (rawSuggestionPinyin != null) {
          formattedSuggestion['pinyin'] = PinyinUtils.convertNumericToMarks(rawSuggestionPinyin);
        }
      }

      final chineseText = (replyJson['chinese'] as String? ?? '').trim();
      final pinyinToUse = (rawPinyin != null && rawPinyin.isNotEmpty)
          ? PinyinUtils.convertNumericToMarks(rawPinyin)
          : PinyinHelper.getPinyinE(chineseText, separator: ' ', format: PinyinFormat.WITH_TONE_MARK);

      final aiMsg = GradedChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: chineseText,
        pinyin: pinyinToUse,
        english: replyJson['english'],
        suggestion: formattedSuggestion,
        role: ChatRole.scholar,
        timestamp: DateTime.now(),
      );
      
      state = state.copyWith(messages: [...state.messages, aiMsg], isProcessing: false);
    } catch (e) {
      // Catch ALL error types (not just Exception) and guarantee isProcessing
      // reset. The fallback is the key that already said exactly this sentence,
      // in all fourteen locales, and had never been referenced.
      final AppLocalizations l10n = _l10n();
      state = state.copyWith(
        isProcessing: false,
        error: NetworkFailure.isOffline(e)
            ? NetworkNotice.messageOf(l10n)
            : l10n.ourAiTutorsAreCurrentlyOfflinePleas,
      );
    }
  }

  Future<void> translateMessage(String messageId) async {
    final index = state.messages.indexWhere((m) => m.id == messageId);
    if (index == -1) return;

    final msg = state.messages[index];
    final pinyin = (msg.pinyin != null && msg.pinyin!.isNotEmpty)
        ? msg.pinyin!
        : PinyinHelper.getPinyinE(msg.content, separator: ' ', format: PinyinFormat.WITH_TONE_MARK);

    // Skip if already translated
    if (msg.english != null && msg.english!.isNotEmpty) {
      if (msg.pinyin == null || msg.pinyin!.isEmpty) {
        final updatedMsg = msg.copyWith(pinyin: pinyin);
        final newMessages = List<GradedChatMessage>.from(state.messages);
        newMessages[index] = updatedMsg;
        state = state.copyWith(messages: newMessages);
      }
      return;
    }

    try {
      final translation = await _localTranslationService.translate(msg.content);
      final updatedMsg = msg.copyWith(english: translation, pinyin: pinyin);
      final newMessages = List<GradedChatMessage>.from(state.messages);
      newMessages[index] = updatedMsg;
      state = state.copyWith(messages: newMessages);
    } catch (e) {
      debugPrint("ConversationController: Lazy translation error: $e");
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
