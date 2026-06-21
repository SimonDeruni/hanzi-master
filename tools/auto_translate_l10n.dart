import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main(List<String> args) async {
  final envFile = File('.env');
  String apiKey = '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';

  if (apiKey == null) {
    print('No API key found in .env');
    return;
  }

  final dir = Directory('lib/l10n');
  final enFile = File('${dir.path}/app_en.arb');
  if (!enFile.existsSync()) {
    print('app_en.arb not found');
    return;
  }

  final enData = jsonDecode(enFile.readAsStringSync()) as Map<String, dynamic>;
  final keysToTranslate = enData.keys.where((k) => !k.startsWith('@')).toList();

  final files = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.arb') && !f.path.endsWith('app_en.arb'));

  for (final file in files) {
    final targetLang = file.path.split('_').last.replaceAll('.arb', '');
    final fileData = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    
    final missingKeys = keysToTranslate.where((k) => !fileData.containsKey(k)).toList();
    
    if (missingKeys.isEmpty) {
      print('No missing keys for $targetLang');
      continue;
    }

    print('Translating ${missingKeys.length} keys for $targetLang...');
    
    final Map<String, String> toTranslate = {};
    for (final key in missingKeys) {
      toTranslate[key] = enData[key].toString();
    }

    final prompt = '''
You are an expert app localizer. Translate the following English strings into $targetLang.
Keep the translation concise, natural, and appropriate for a language learning app UI.
Preserve any Flutter interpolations like {variable}.

Translate this JSON:
${jsonEncode(toTranslate)}

Respond ONLY with valid JSON containing the translated key-value pairs.
''';

    try {
      final response = await http.post(
        Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'google/gemini-2.5-flash',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'response_format': {'type': 'json_object'}
        }),
      );

      if (response.statusCode == 200) {
        final respJson = jsonDecode(utf8.decode(response.bodyBytes));
        final content = respJson['choices']?[0]?['message']?['content'] ?? '';
        final cleanContent = content.replaceAll(RegExp(r'^```json\n', multiLine: true), '').replaceAll(RegExp(r'^```\n?', multiLine: true), '');
        
        final translatedData = jsonDecode(cleanContent) as Map<String, dynamic>;
        
        for (final key in translatedData.keys) {
          fileData[key] = translatedData[key];
        }

        file.writeAsStringSync(JsonEncoder.withIndent('  ').convert(fileData));
        print('Updated ${file.path}');
      } else {
        print('Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Error translating $targetLang: $e');
    }
  }
}
