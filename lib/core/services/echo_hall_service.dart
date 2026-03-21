import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../features/chat/domain/entities/chat_message.dart';

final echoHallServiceProvider = Provider<EchoHallService>((ref) {
  // NOTE: For a real app, this key should be in a .env file or secure storage.
  // We use a placeholder here for the user to replace.
  const apiKey = String.fromEnvironment('GEMINI_API_KEY', defaultValue: 'YOUR_API_KEY_HERE');
  return EchoHallService(apiKey);
});

class EchoHallService {
  final String _apiKey;
  late final GenerativeModel _model;

  EchoHallService(this._apiKey) {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
    );
  }

  Future<String> getResponse(List<ChatMessage> history, String personaInstructions) async {
    if (_apiKey.isEmpty || _apiKey == 'YOUR_API_KEY_HERE') {
      return "The Scholar's voice is resting right now. Please check back later.";
    }

    try {
    final chat = _model.startChat(
      history: history.map((m) => Content(
        m.role == ChatRole.user ? 'user' : 'model',
        [TextPart(m.content)],
      )).toList(),
    );

    final response = await chat.sendMessage(Content.text(personaInstructions));
    return response.text ?? "The ink failed to flow. Please try again.";
  } catch (e) {
      return "The Scholar is momentarily unavailable. Please try again in a moment.";
    }
  }

  Future<String> getPronunciationFeedback(String character, String transcription, double confidence) async {
    if (_apiKey.isEmpty || _apiKey == 'YOUR_API_KEY_HERE') {
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

    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content);
    return response.text ?? "The Echo Hall remains silent. Try your breath again.";
  }
}
