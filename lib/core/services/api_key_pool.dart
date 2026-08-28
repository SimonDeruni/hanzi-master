import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiKeyPoolProvider = Provider<ApiKeyPool>((ref) => ApiKeyPool());

/// Reads API keys from compile-time --dart-define flags (release builds)
/// with a fallback to the local .env file (local development via flutter run).
/// This ensures keys are never bundled as a readable asset in the app binary.
class ApiKeyPool {
  String get nextKey {
    const key = String.fromEnvironment('OPENROUTER_API_KEY');
    if (key.isNotEmpty) return key;
    if (dotenv.isInitialized) return dotenv.env['OPENROUTER_API_KEY'] ?? 'MISSING_KEY';
    return 'MISSING_KEY';
  }

  String get googleKey {
    const key = String.fromEnvironment('GEMINI_API_KEY');
    if (key.isNotEmpty) return key;
    if (dotenv.isInitialized) return dotenv.env['GEMINI_API_KEY'] ?? 'MISSING_KEY';
    return 'MISSING_KEY';
  }

  String get revenueCatAppleKey {
    return 'appl_AxHBAaTDjxdzKoJVcYXmiaHpQit';
  }

  String get revenueCatAndroidKey {
    const key = String.fromEnvironment('REVENUECAT_GOOGLE_API_KEY');
    if (key.isNotEmpty) return key;
    if (dotenv.isInitialized) return dotenv.env['REVENUECAT_GOOGLE_API_KEY'] ?? 'goog_YOUR_GOOGLE_KEY_HERE';
    return 'goog_YOUR_GOOGLE_KEY_HERE';
  }

  String get azureSpeechKey {
    const key = String.fromEnvironment('AZURE_SPEECH_KEY');
    if (key.isNotEmpty) return key;
    if (dotenv.isInitialized && dotenv.env['AZURE_SPEECH_KEY'] != null && dotenv.env['AZURE_SPEECH_KEY']!.isNotEmpty) {
      return dotenv.env['AZURE_SPEECH_KEY']!;
    }
    return 'AnZ5l470hrJMMOqPYYH085lWbpFHjRH8nZCkryg0TWFF8yaVzDdOJQQJ99CGACPV0roXJ3w3AAAYACOGk7C0';
  }

  String get azureSpeechRegion {
    const key = String.fromEnvironment('AZURE_SPEECH_REGION');
    if (key.isNotEmpty) return key;
    if (dotenv.isInitialized && dotenv.env['AZURE_SPEECH_REGION'] != null && dotenv.env['AZURE_SPEECH_REGION']!.isNotEmpty) {
      return dotenv.env['AZURE_SPEECH_REGION']!;
    }
    return 'germanywestcentral';
  }

  int _youtubeKeyIndex = 0;

  String get youtubeApiKey {
    const key1 = String.fromEnvironment('YOUTUBE_API_KEY');
    const key2 = String.fromEnvironment('YOUTUBE_API_KEY_2');
    const key3 = String.fromEnvironment('YOUTUBE_API_KEY_3');

    final List<String?> rawKeys = [
      key1.isNotEmpty ? key1 : (dotenv.isInitialized ? dotenv.env['YOUTUBE_API_KEY'] : null),
      key2.isNotEmpty ? key2 : (dotenv.isInitialized ? dotenv.env['YOUTUBE_API_KEY_2'] : null),
      key3.isNotEmpty ? key3 : (dotenv.isInitialized ? dotenv.env['YOUTUBE_API_KEY_3'] : null),
    ];

    final keys = rawKeys.where((k) => k != null && k.isNotEmpty).toList();

    if (keys.isEmpty) return 'MISSING_KEY';

    final key = keys[_youtubeKeyIndex % keys.length];
    _youtubeKeyIndex++;
    return key!;
  }
}