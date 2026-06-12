import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiKeyPoolProvider = Provider<ApiKeyPool>((ref) => ApiKeyPool());

class ApiKeyPool {
  final List<String> _keys = [
    'AIzaSyBh8Sfhu8g9aENfmf4BkR2iSf_TVzrchs0', // Current Key
    'AQ.Ab8RN6LzNyqWDJS5y-_o_j8pKA-1OkIm-ocfwWuiCQQIrSJCcQ',
    'AQ.Ab8RN6Lm3QFPOyzg5FdgRJr8pPpsuFqSoXSkm0w8tZkxHIiIyQ',
    'AQ.Ab8RN6Jw1wne4dkK1GceZmxu25nsh_a30BbXoWa6tDBo9Zt4Hw',
    'AQ.Ab8RN6L2ZXH7V0Vy2Q0_4hLcXOLTXOgeKm_oZbzryB_tZbmRhA',
    'AQ.Ab8RN6KAt6mePO-8RhE81flhvo_CZmtSz90c_vrF7XD2WmUASw',
    'EMPTY_KEY_7',
    'EMPTY_KEY_8',
    'EMPTY_KEY_9',
    'EMPTY_KEY_10',
  ];
  
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
