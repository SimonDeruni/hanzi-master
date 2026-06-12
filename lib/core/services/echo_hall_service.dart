import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../features/chat/domain/entities/chat_message.dart';
import 'api_key_pool.dart';

final echoHallServiceProvider = Provider<EchoHallService>((ref) {
  final pool = ref.watch(apiKeyPoolProvider);
  return EchoHallService(pool);
});

class EchoHallService {
  final ApiKeyPool _pool;

  EchoHallService(this._pool);

  GenerativeModel _getModel(String apiKey) {
    return GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
    );
  }

  Future<String> getResponse(List<ChatMessage> history, String personaInstructions) async {
    final apiKey = _pool.nextKey;

    if (apiKey.isEmpty || apiKey.startsWith('EMPTY_KEY_') || apiKey == 'YOUR_API_KEY_HERE') {
      return "The Scholar's voice is silent. The ink has not been prepared. (Missing API Key - See docs/AI_CHAT_SETUP.md)";
    }

    try {
      final model = _getModel(apiKey);
      final chat = model.startChat(
        history: history.map((m) => Content(
          m.role == ChatRole.user ? 'user' : 'model',
          [TextPart(m.content)],
        )).toList(),
      );

      final response = await chat.sendMessage(Content.text(personaInstructions));
      return response.text ?? "The ink failed to flow. Please try again.";
    } catch (e) {
      debugPrint('EchoHallService Error: $e');
      return "The Scholar is momentarily unavailable. Please try again in a moment.";
    }
  }

  Future<String> getPronunciationFeedback(String character, String transcription, double confidence) async {
    final apiKey = _pool.nextKey;

    if (apiKey.isEmpty || apiKey.startsWith('EMPTY_KEY_') || apiKey == 'YOUR_API_KEY_HERE') {
      return "AI feedback is currently unavailable. Please ensure the API key is set correctly.";
    }

    final prompt = """
Act as a supportive but pedantic Chinese Calligraphy & Language Master.
The user is practicing the character: "$character".
The STT system recognized it as: "$transcription" (Confidence: ${(confidence * 100).toStringAsFixed(0)}%).

Provide a short, 1-2 sentence "Scholar's Critique" in English. 
- If the match is high (>80%), praise their clarity and mention a subtle detail about the character's radical.
- If the match is medium (50-80%), provide a specific tip on tone or initial/final clarity.
- If the match is low (<50%), encourage them and mention a common mistake for this specific character's pronunciation.

Keep it scholarly, using terms like "ink," "stroke," or "breath."
""";

    try {
      final model = _getModel(apiKey);
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      return response.text ?? "The Echo Hall remains silent. Try your breath again.";
    } catch (e) {
      debugPrint('EchoHallService Pronunciation Error: $e');
      return "The Echo Hall remains silent. Try your breath again.";
    }
  }
}
