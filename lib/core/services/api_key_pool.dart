import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiKeyPoolProvider = Provider<ApiKeyPool>((ref) => ApiKeyPool());

class ApiKeyPool {
  // Pull keys from the local .env file so they are never committed to Git
  String get nextKey => dotenv.env['OPENROUTER_API_KEY'] ?? 'MISSING_KEY';
  
  String get googleKey => dotenv.env['GEMINI_API_KEY'] ?? 'MISSING_KEY';

  String get revenueCatAppleKey => dotenv.env['REVENUECAT_APPLE_API_KEY'] ?? 'appl_YOUR_APPLE_KEY_HERE';
  
  String get revenueCatAndroidKey => dotenv.env['REVENUECAT_GOOGLE_API_KEY'] ?? 'goog_YOUR_GOOGLE_KEY_HERE';

  String get azureSpeechKey => dotenv.env['AZURE_SPEECH_KEY'] ?? 'MISSING_KEY';
  
  String get azureSpeechRegion => dotenv.env['AZURE_SPEECH_REGION'] ?? 'MISSING_REGION';

  String get youtubeApiKey => dotenv.env['YOUTUBE_API_KEY'] ?? 'MISSING_KEY';
}