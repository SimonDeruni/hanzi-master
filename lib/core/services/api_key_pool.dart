import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiKeyPoolProvider = Provider<ApiKeyPool>((ref) => ApiKeyPool());

class ApiKeyPool {
  final List<String> _keys = [
    'AIzaSyBh8Sfhu8g9aENfmf4BkR2iSf_TVzrchs0', // Current Key
    'EMPTY_KEY_2',
    'EMPTY_KEY_3',
    'EMPTY_KEY_4',
    'EMPTY_KEY_5',
    'EMPTY_KEY_6',
    'EMPTY_KEY_7',
    'EMPTY_KEY_8',
    'EMPTY_KEY_9',
    'EMPTY_KEY_10',
  ];
  
  int _currentIndex = 0;

  String get nextKey {
    final key = _keys[_currentIndex];
    // Only rotate if the key is not empty/placeholder
    if (key != 'EMPTY_KEY_${_currentIndex + 1}') {
       _currentIndex = (_currentIndex + 1) % _keys.length;
    }
    return key;
  }
}
