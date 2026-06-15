import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../features/chat/domain/entities/chat_message.dart';
import 'api_key_pool.dart';

final echoHallServiceProvider = Provider<EchoHallService>((ref) {
  final pool = ref.watch(apiKeyPoolProvider);
  return EchoHallService(pool);
});

class EchoHallService {
  final ApiKeyPool _pool;

  EchoHallService(this._pool);

  Future<String> getResponse(List<ChatMessage> history, String personaInstructions) async {
    final apiKey = _pool.nextKey;

    if (apiKey.isEmpty || apiKey.startsWith('EMPTY_KEY_') || apiKey == 'YOUR_API_KEY_HERE') {
      return "The Scholar's voice is silent. The ink has not been prepared. (Missing API Key - See docs/AI_CHAT_SETUP.md)";
    }

    try {
      final messages = history.map((m) {
        return {
          'role': m.role == ChatRole.user ? 'user' : 'assistant',
          'content': m.content,
        };
      }).toList();
      
      // Inject persona instructions as system prompt
      messages.insert(0, {'role': 'system', 'content': personaInstructions});

      final response = await http.post(
        Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'google/gemini-2.5-flash',
          'messages': messages,
          'max_tokens': 220,
        }),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(utf8.decode(response.bodyBytes));
        return json['choices']?[0]?['message']?['content'] ?? "The ink failed to flow. Please try again.";
      } else {
        throw Exception('OpenRouter Error ${response.statusCode}: ${response.body}');
      }
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
      final response = await http.post(
        Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'deepseek/deepseek-chat',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'max_tokens': 150,
        }),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(utf8.decode(response.bodyBytes));
        return json['choices']?[0]?['message']?['content'] ?? "The Echo Hall remains silent. Try your breath again.";
      } else {
        throw Exception('OpenRouter Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      debugPrint('EchoHallService Pronunciation Error: $e');
      return "The Echo Hall remains silent. Try your breath again.";
    }
  }
}
