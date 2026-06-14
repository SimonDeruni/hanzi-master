import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiKeyPoolProvider = Provider<ApiKeyPool>((ref) => ApiKeyPool());

class ApiKeyPool {
  final List<String> _keys = [
    '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', // Current Key

  ];
  
  // Direct Google API Key for Audio processing (bypassing OpenRouter)
  final String googleKey = 'AQ.Ab8RN6Jw1wne4dkK1GceZmxu25nsh_a30BbXoWa6tDBo9Zt4Hw';
  
  int _currentIndex = 0;

  String get nextKey {
    // Find the next non-empty key
    for (int i = 0; i < _keys.length; i++) {
      int checkIndex = (_currentIndex + i) % _keys.length;
      if (!_keys[checkIndex].startsWith('EMPTY_KEY')) {
        // Set the index for the next call to the one after the key we just found
        _currentIndex = (checkIndex + 1) % _keys.length;
        return _keys[checkIndex];
      }
    }
    // Fallback if all keys are empty
    return _keys[0];
  }
}
