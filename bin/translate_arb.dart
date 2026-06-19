import 'dart:convert';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  print('Loading environment variables...');
  await dotenv.load(fileName: '.env');
  final apiKey = dotenv.env['GEMINI_API_KEY'];
  
  if (apiKey == null || apiKey.isEmpty) {
    print('GEMINI_API_KEY not found in .env');
    return;
  }

  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: apiKey,
  );

  final l10nDir = Directory('lib/l10n');
  final enFile = File('\${l10nDir.path}/app_en.arb');
  
  if (!await enFile.exists()) {
    print('app_en.arb not found');
    return;
  }

  final enData = jsonDecode(await enFile.readAsString()) as Map<String, dynamic>;
  final keysToTranslate = Map.fromEntries(enData.entries.where((e) => !e.key.startsWith('@')));

  final targetLanguages = {
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'it': 'Italian',
    'pt': 'Portuguese',
    'ru': 'Russian',
    'ko': 'Korean',
    'ja': 'Japanese',
    'vi': 'Vietnamese',
    'id': 'Indonesian',
    'ar': 'Arabic',
    'hi': 'Hindi'
  };

  for (final entry in targetLanguages.entries) {
    final langCode = entry.key;
    final langName = entry.value;
    final targetFile = File('\${l10nDir.path}/app_\$langCode.arb');
    
    Map<String, dynamic> targetData = {};
    if (await targetFile.exists()) {
      targetData = jsonDecode(await targetFile.readAsString()) as Map<String, dynamic>;
    } else {
      targetData['@@locale'] = langCode;
    }

    final missingKeys = keysToTranslate.keys.where((k) => !targetData.containsKey(k)).toList();
    
    if (missingKeys.isEmpty) {
      print('[\$langCode] Up to date.');
      continue;
    }

    print('[\$langCode] Translating \${missingKeys.length} new keys...');
    
    final Map<String, String> payloadToTranslate = {};
    for (final key in missingKeys) {
      payloadToTranslate[key] = keysToTranslate[key]!;
    }

    final prompt = '''
Translate the following JSON string values from English to \$langName.
Return ONLY valid JSON. Keep the keys exactly the same. Do not wrap in markdown tags like ```json.
JSON:
\${jsonEncode(payloadToTranslate)}
''';

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      if (response.text != null) {
        String cleanText = response.text!.trim();
        if (cleanText.startsWith('```json')) {
          cleanText = cleanText.substring(7);
        }
        if (cleanText.startsWith('```')) {
          cleanText = cleanText.substring(3);
        }
        if (cleanText.endsWith('```')) {
          cleanText = cleanText.substring(0, cleanText.length - 3);
        }
        
        final translatedJson = jsonDecode(cleanText.trim()) as Map<String, dynamic>;
        for (final key in translatedJson.keys) {
          targetData[key] = translatedJson[key];
        }
        
        await targetFile.writeAsString(jsonEncode(targetData));
        print('[\$langCode] Successfully updated.');
      }
    } catch (e) {
      print('[\$langCode] Error: \$e');
    }
  }
  print('All done!');
}
