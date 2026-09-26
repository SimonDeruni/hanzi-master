import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiKeyPoolProvider = Provider<ApiKeyPool>((ref) => ApiKeyPool());

/// Reads API keys from compile-time --dart-define flags (release builds)
/// with a fallback to the local .env file (local development via flutter run).
///
/// **No credential may ever be written into this file.** Two were: an OpenRouter
/// secret and an Azure Speech key sat here as fallbacks, which put a metered
/// credential in source control *and* in every binary built from it. Both were
/// removed on 2026-09-26 and now return `'MISSING_KEY'`, so an unconfigured key
/// fails loudly rather than quietly spending something that leaked.
/// `test/core/secret_guard_test.dart` exists so it cannot happen again.
///
/// The RevenueCat keys below (`appl_…`, `goog_…`) are **publishable SDK keys by
/// design** and are not secrets — do not "fix" them.
class ApiKeyPool {
  String get nextKey {
    const key = String.fromEnvironment('OPENROUTER_API_KEY');
    if (key.isNotEmpty) return key;
    if (dotenv.isInitialized &&
        dotenv.env['OPENROUTER_API_KEY'] != null &&
        dotenv.env['OPENROUTER_API_KEY']!.isNotEmpty) {
      return dotenv.env['OPENROUTER_API_KEY']!;
    }
    // No fallback key ships here. A hard-coded credential in this file is a
    // credential in the repository *and* in every built binary; callers check
    // with `_isConfiguredKey`, so a missing key now fails loudly instead of
    // silently spending a credential that leaked with the source.
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
    // Same reasoning as `nextKey` above: the Azure Speech key was hard-coded
    // here, so it was both committed and shipped. It is a *metered* credential,
    // which made it the most costly leak of the two.
    return 'MISSING_KEY';
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