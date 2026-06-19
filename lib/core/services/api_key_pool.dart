import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiKeyPoolProvider = Provider<ApiKeyPool>((ref) => ApiKeyPool());

class ApiKeyPool {
  // Use dotenv to get keys, fallback to empty string so it doesn't crash if missing
  String get nextKey => dotenv.env['OPENROUTER_API_KEY'] ?? '';
  
  String get googleKey => dotenv.env['GEMINI_API_KEY'] ?? '';
}
