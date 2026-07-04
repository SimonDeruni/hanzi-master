import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiKeyPoolProvider = Provider<ApiKeyPool>((ref) => ApiKeyPool());

class ApiKeyPool {
  // Pull keys from the local .env file so they are never committed to Git
  String get nextKey => dotenv.env['OPENROUTER_API_KEY'] ?? 'MISSING_KEY';
  
  String get googleKey => dotenv.env['GEMINI_API_KEY'] ?? 'MISSING_KEY';
}
