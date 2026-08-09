import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiKeyPoolProvider = Provider<ApiKeyPool>((ref) => ApiKeyPool());

/// Reads API keys from compile-time --dart-define flags (release builds)
/// with a fallback to the local .env file (local development via flutter run).
/// This ensures keys are never bundled as a readable asset in the app binary.
class ApiKeyPool {
  static String _key(String name) =>
      String.fromEnvironment(name).isNotEmpty
          ? String.fromEnvironment(name)
          : (dotenv.env[name] ?? 'MISSING_KEY');

  String get nextKey => _key('OPENROUTER_API_KEY');

  String get googleKey => _key('GEMINI_API_KEY');

  String get revenueCatAppleKey =>
      String.fromEnvironment('REVENUECAT_APPLE_API_KEY').isNotEmpty
          ? String.fromEnvironment('REVENUECAT_APPLE_API_KEY')
          : (dotenv.env['REVENUECAT_APPLE_API_KEY'] ?? 'appl_YOUR_APPLE_KEY_HERE');

  String get revenueCatAndroidKey =>
      String.fromEnvironment('REVENUECAT_GOOGLE_API_KEY').isNotEmpty
          ? String.fromEnvironment('REVENUECAT_GOOGLE_API_KEY')
          : (dotenv.env['REVENUECAT_GOOGLE_API_KEY'] ?? 'goog_YOUR_GOOGLE_KEY_HERE');

  String get azureSpeechKey => _key('AZURE_SPEECH_KEY');

  String get azureSpeechRegion =>
      String.fromEnvironment('AZURE_SPEECH_REGION').isNotEmpty
          ? String.fromEnvironment('AZURE_SPEECH_REGION')
          : (dotenv.env['AZURE_SPEECH_REGION'] ?? 'MISSING_REGION');

  int _youtubeKeyIndex = 0;

  String get youtubeApiKey {
    final keys = [
      String.fromEnvironment('YOUTUBE_API_KEY').isNotEmpty
          ? String.fromEnvironment('YOUTUBE_API_KEY')
          : dotenv.env['YOUTUBE_API_KEY'],
      String.fromEnvironment('YOUTUBE_API_KEY_2').isNotEmpty
          ? String.fromEnvironment('YOUTUBE_API_KEY_2')
          : dotenv.env['YOUTUBE_API_KEY_2'],
      String.fromEnvironment('YOUTUBE_API_KEY_3').isNotEmpty
          ? String.fromEnvironment('YOUTUBE_API_KEY_3')
          : dotenv.env['YOUTUBE_API_KEY_3'],
    ].where((k) => k != null && k.isNotEmpty).toList();

    if (keys.isEmpty) return 'MISSING_KEY';

    final key = keys[_youtubeKeyIndex % keys.length];
    _youtubeKeyIndex++;
    return key!;
  }
}