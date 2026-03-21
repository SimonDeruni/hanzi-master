# 🛠️ AI Chatboard Configuration Guide (Gemini API)

To enable the "Scholar's Voice" in Echo Hall, you need a valid Google Gemini API key.

## 📍 Where to put the API key

The primary location for the API key in the codebase is:
**[echo_hall_service.dart](file:///c:/Users/simon/Documents/hanzi_master/lib/core/services/echo_hall_service.dart)**

### Option 1: Manual Configuration (Not recommended for Production)
Find the following line and replace `'YOUR_API_KEY_HERE'` with your actual key:
```dart
const apiKey = String.fromEnvironment('GEMINI_API_KEY', defaultValue: 'YOUR_API_KEY_HERE');
```

### Option 2: Environment Variable (Recommended)
You can provide the API key during the build process without modifying the code. This is safer and prevents accidental leaks.

**Using VS Code (`launch.json`):**
Add the following to your `toolArgs`:
```json
"--dart-define=GEMINI_API_KEY=your_actual_key_here"
```

**Using the Terminal:**
```bash
flutter run --dart-define=GEMINI_API_KEY=your_actual_key_here
```

## 🔒 Security Note
- **DO NOT** commit your API key to Git.
- The `.gitignore` file has been configured to exclude `.env` files. You can safely store your key there if you use a package like `flutter_dotenv`.
- In this project, the `String.fromEnvironment` method is preferred to keep the codebase lean.
