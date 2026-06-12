# Scholar's Key Pool Implementation Plan

I'm using the writing-plans skill to create the implementation plan.

**Goal:** Implement a centralized API key management system that rotates through 10 Gemini API keys to bypass free-tier quota limits.

**Architecture:** A singleton `ApiKeyPool` service manages a list of 10 keys using a round-robin rotation strategy. Both `GeminiService` and `EchoHallService` are refactored to retrieve keys dynamically from this pool instead of using hardcoded values.

**Tech Stack:** Dart, Riverpod.

---

### Task 1: Create the Key Pool Service

**Files:**
- Create: `lib/core/services/api_key_pool.dart`

- [ ] **Step 1: Define the ApiKeyPool class**
Create a service that holds a list of 10 strings and an index to track the current key.
```dart
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
```
- [ ] **Step 2: Commit**
```bash
git add lib/core/services/api_key_pool.dart
git commit -m "feat: implement ApiKeyPool service"
```

---

### Task 2: Refactor GeminiService for Multi-Key Support

**Files:**
- Modify: `lib/core/services/gemini_service.dart`

- [ ] **Step 1: Update the Provider**
Inject `apiKeyPoolProvider` into the `geminiServiceProvider`.
```dart
final geminiServiceProvider = Provider<GeminiService>((ref) {
  final pool = ref.watch(apiKeyPoolProvider);
  return GeminiService(pool: pool);
});
```
- [ ] **Step 2: Update the Class Constructor**
Modify `GeminiService` to accept the `ApiKeyPool` and re-initialize the `GenerativeModel` dynamically per request if needed, or simply use the next key for each high-level method.
```dart
class GeminiService {
  final ApiKeyPool _pool;

  GeminiService({required ApiKeyPool pool}) : _pool = pool;

  GenerativeModel _getModel() {
    return GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: _pool.nextKey,
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );
  }
  // ... refactor methods to call _getModel()
}
```
- [ ] **Step 3: Commit**
```bash
git commit -am "feat: refactor GeminiService to use Key Pool"
```

---

### Task 3: Refactor EchoHallService for Multi-Key Support

**Files:**
- Modify: `lib/core/services/echo_hall_service.dart`

- [ ] **Step 1: Update the Provider**
Inject `apiKeyPoolProvider` into `echoHallServiceProvider`.
- [ ] **Step 2: Update the Class Logic**
Refactor `getResponse` and `getPronunciationFeedback` to use `_pool.nextKey`.
- [ ] **Step 3: Commit**
```bash
git commit -am "feat: refactor EchoHallService to use Key Pool"
```

---

### Task 4: Final Hygiene & Update Tracking

- [ ] **Step 1: Run `flutter analyze`**
- [ ] **Step 2: Update `SESSION_STATE.md` and `CHANGELOG.md`**
- [ ] **Step 3: Final Commit & Push**
```bash
git push origin master
```
