import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiKeyPoolProvider = Provider<ApiKeyPool>((ref) => ApiKeyPool());

/// Reads API keys from compile-time --dart-define flags (release builds)
/// with a fallback to the local .env file (local development via flutter run).
/// This ensures keys are never bundled as a readable asset in the app binary.
class ApiKeyPool {
  static String _key(String name) {
    if (String.fromEnvironment(name).isNotEmpty) {
      return String.fromEnvironment(name);
    }
    if (dotenv.isInitialized) {
      return dotenv.env[name] ?? 'MISSING_KEY';
    }
    return 'MISSING_KEY';
  }

  String get nextKey => _key('OPENROUTER_API_KEY');

  String get googleKey => _key('GEMINI_API_KEY');

  String get revenueCatAppleKey {
    if (String.fromEnvironment('REVENUECAT_APPLE_API_KEY').isNotEmpty) {
      return String.fromEnvironment('REVENUECAT_APPLE_API_KEY');
    }
    if (dotenv.isInitialized) {
      return dotenv.env['REVENUECAT_APPLE_API_KEY'] ?? 'appl_YOUR_APPLE_KEY_HERE';
    }
    return 'appl_YOUR_APPLE_KEY_HERE';
  }

  String get revenueCatAndroidKey {
    if (String.fromEnvironment('REVENUECAT_GOOGLE_API_KEY').isNotEmpty) {
      return String.fromEnvironment('REVENUECAT_GOOGLE_API_KEY');
    }
    if (dotenv.isInitialized) {
      return dotenv.env['REVENUECAT_GOOGLE_API_KEY'] ?? 'goog_YOUR_GOOGLE_KEY_HERE';
    }
    return 'goog_YOUR_GOOGLE_KEY_HERE';
  }

  String get azureSpeechKey => _key('AZURE_SPEECH_KEY');

  String get azureSpeechRegion {
    if (String.fromEnvironment('AZURE_SPEECH_REGION').isNotEmpty) {
      return String.fromEnvironment('AZURE_SPEECH_REGION');
    }
    if (dotenv.isInitialized) {
      return dotenv.env['AZURE_SPEECH_REGION'] ?? 'MISSING_REGION';
    }
    return 'MISSING_REGION';
  }

  int _youtubeKeyIndex = 0;

  String get youtubeApiKey {
    final List<String?> rawKeys = [
      String.fromEnvironment('YOUTUBE_API_KEY').isNotEmpty
          ? String.fromEnvironment('YOUTUBE_API_KEY')
          : (dotenv.isInitialized ? dotenv.env['YOUTUBE_API_KEY'] : null),
      String.fromEnvironment('YOUTUBE_API_KEY_2').isNotEmpty
          ? String.fromEnvironment('YOUTUBE_API_KEY_2')
          : (dotenv.isInitialized ? dotenv.env['YOUTUBE_API_KEY_2'] : null),
      String.fromEnvironment('YOUTUBE_API_KEY_3').isNotEmpty
          ? String.fromEnvironment('YOUTUBE_API_KEY_3')
          : (dotenv.isInitialized ? dotenv.env['YOUTUBE_API_KEY_3'] : null),
    ];

    final keys = rawKeys.where((k) => k != null && k.isNotEmpty).toList();

    if (keys.isEmpty) return 'MISSING_KEY';

    final key = keys[_youtubeKeyIndex % keys.length];
    _youtubeKeyIndex++;
    return key!;
  }
}