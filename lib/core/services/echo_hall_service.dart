import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/chat/domain/entities/chat_message.dart';
import 'gemini_service.dart';

final echoHallServiceProvider = Provider<EchoHallService>((ref) {
  final geminiService = ref.watch(geminiServiceProvider);
  return EchoHallService(geminiService);
});

class EchoHallService {
  final GeminiService _geminiService;

  EchoHallService(this._geminiService);

  static const _jsonStructureHint = '''
You MUST respond ONLY in valid JSON format with this exact structure:
{
  "chinese": "Your natural conversational reply in Chinese characters.",
  "english": "The English translation of your reply.",
  "pinyin": "The Pinyin with tone marks for your reply.",
  "suggestion": {
    "chinese": "A suggested response the user could say back to you.",
    "pinyin": "Pinyin for the suggestion.",
    "english": "English translation for the suggestion."
  }
}''';

  Future<Map<String, dynamic>> getConversationResponse(List<ChatMessage> history, String personaInstructions) async {
    try {
      final systemPrompt = '$personaInstructions\n\n$_jsonStructureHint';

      final messages = <Map<String, dynamic>>[
        {'role': 'system', 'content': systemPrompt},
      ];
      messages.addAll(history.map((m) => {
        'role': m.role == ChatRole.user ? 'user' : 'assistant',
        'content': m.content,
      }));

      final responseText = await _geminiService.makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: messages,
        jsonMode: true,
        timeout: const Duration(seconds: 15),
      );

      final cleanText = responseText
          .replaceAll(RegExp(r'^```json\n', multiLine: true), '')
          .replaceAll(RegExp(r'^```\n?', multiLine: true), '')
          .trim();

      return jsonDecode(cleanText);
    } catch (e) {
      debugPrint('EchoHallService Error: $e');
      throw Exception('EchoHallService failed: $e');
    }
  }

  Future<String> getResponse(List<ChatMessage> history, String personaInstructions) async {
    try {
      final messages = <Map<String, dynamic>>[
        {'role': 'system', 'content': personaInstructions},
      ];
      messages.addAll(history.map((m) => {
        'role': m.role == ChatRole.user ? 'user' : 'assistant',
        'content': m.content,
      }));

      return await _geminiService.makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: messages,
        jsonMode: false,
        timeout: const Duration(seconds: 15),
      );
    } catch (e) {
      debugPrint('EchoHallService Error: $e');
      throw Exception('EchoHallService failed: $e');
    }
  }

  Future<String> getPronunciationFeedback(String character, String transcription, double confidence) async {
    final prompt = '''
Act as a supportive but pedantic Chinese Calligraphy & Language Master.
The user is practicing the character: "$character".
The STT system recognized it as: "$transcription" (Confidence: ${(confidence * 100).toStringAsFixed(0)}%).

Provide a short, 1-2 sentence "Scholar's Critique" in English. 
- If the match is high (>80%), praise their clarity and mention a subtle detail about the character's radical.
- If the match is medium (50-80%), provide a specific tip on tone or initial/final clarity.
- If the match is low (<50%), encourage them and mention a common mistake for this specific character's pronunciation.

Keep it scholarly, using terms like "ink," "stroke," or "breath."
''';

    try {
      return await _geminiService.makeOpenRouterCall(
        model: 'deepseek/deepseek-chat',
        messages: [{'role': 'user', 'content': prompt}],
        jsonMode: false,
      );
    } catch (e) {
      debugPrint('EchoHallService Pronunciation Error: $e');
      return "The Echo Hall remains silent. Try your breath again.";
    }
  }
}