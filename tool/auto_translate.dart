import 'dart:convert';
import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  print('--- Automated ARB Translation ---');
  
  // 1. Read API Key from .env
  final envFile = File('.env');
  if (!envFile.existsSync()) {
    print('Error: .env file not found.');
    exit(1);
  }
  
  String? apiKey;
  final lines = envFile.readAsLinesSync();
  for (final line in lines) {
    if (line.startsWith('GEMINI_API_KEY=')) {
      apiKey = line.split('=')[1].trim();
      break;
    }
  }

  if (apiKey == null || apiKey.isEmpty) {
    print('Error: GEMINI_API_KEY not found in .env');
    exit(1);
  }

  // 2. Initialize Gemini Model
  final model = GenerativeModel(
    model: 'gemini-2.5-flash',
    apiKey: apiKey,
    generationConfig: GenerationConfig(
      responseMimeType: 'application/json',
    )
  );

  // 3. Find arb files
  final l10nDir = Directory('lib/l10n');
  if (!l10nDir.existsSync()) {
    print('Error: lib/l10n directory not found.');
    exit(1);
  }

  final enFile = File('lib/l10n/app_en.arb');
  if (!enFile.existsSync()) {
    print('Error: app_en.arb not found.');
    exit(1);
  }

  // 4. Parse app_en.arb as source of truth
  final enJsonStr = enFile.readAsStringSync();
  final enMap = jsonDecode(enJsonStr) as Map<String, dynamic>;
  final enKeys = enMap.keys.where((k) => !k.startsWith('@')).toList();

  final files = l10nDir.listSync().whereType<File>().where((f) => f.path.endsWith('.arb'));

  for (final file in files) {
    final fileName = file.path.split(Platform.pathSeparator).last;
    if (fileName == 'app_en.arb') continue;

    final targetLangCode = fileName.replaceAll('app_', '').replaceAll('.arb', '');
    print('Processing $targetLangCode ($fileName)...');

    final jsonStr = file.readAsStringSync();
    final Map<String, dynamic> targetMap = jsonDecode(jsonStr);
    
    final Map<String, String> missingKeys = {};
    for (final key in enKeys) {
      if (!targetMap.containsKey(key)) {
        missingKeys[key] = enMap[key].toString();
      }
    }

    if (missingKeys.isEmpty) {
      print('  All keys up to date.');
      continue;
    }

    print('  Found ${missingKeys.length} missing keys. Translating...');

    // Construct prompt
    final prompt = '''
You are a professional software translator. Translate the following English localization JSON into the language with language code "$targetLangCode".
Keep the exact same JSON keys. Only translate the values.
Ensure the translation sounds natural in the context of a modern mobile app about learning the Chinese language.
Do NOT wrap the output in markdown code blocks, just return raw JSON.

English JSON:
${jsonEncode(missingKeys)}
''';

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      final translatedText = response.text;
      if (translatedText != null && translatedText.isNotEmpty) {
        final Map<String, dynamic> translatedMap = jsonDecode(translatedText);
        
        // Merge translations
        for (final key in translatedMap.keys) {
           targetMap[key] = translatedMap[key];
        }
        
        // Write back
        const encoder = JsonEncoder.withIndent('  ');
        file.writeAsStringSync(encoder.convert(targetMap));
        print('  Successfully translated and updated $fileName');
      } else {
         print('  Error: Empty response from Gemini API for $fileName');
      }
    } catch (e) {
      print('  Failed to translate for $fileName: $e');
    }
  }
  
  print('--- Translation Complete ---');
  print('Please run `flutter gen-l10n` to update the Dart classes.');
}
