import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const _locales = <String, String>{
  'es': 'Spanish',
  'fr': 'French',
  'it': 'Italian',
  'pt': 'Portuguese',
};
const _sourcePath = 'assets/data/l10n/author_bios_en.json';
const _model = 'gemini-3.5-flash-lite';
const _batchSize = 8;

Future<void> main() async {
  final source = (jsonDecode(await File(_sourcePath).readAsString())
          as Map<String, dynamic>)
      .map((key, value) => MapEntry(key, value.toString().trim()));
  if (source.length != 62 || source.values.any((value) => value.isEmpty)) {
    throw StateError('Expected 62 nonempty English biographies.');
  }

  final apiKey = _readApiKey();
  final client = http.Client();
  try {
    for (final locale in _locales.keys) {
      final output = await _loadExisting(locale, source.keys.toSet());
      final pending =
          source.keys.where((key) => !output.containsKey(key)).toList();
      stdout.writeln('$locale: ${output.length}/62 already translated.');

      for (var offset = 0; offset < pending.length; offset += _batchSize) {
        final end = (offset + _batchSize).clamp(0, pending.length);
        final keys = pending.sublist(offset, end);
        final translated = await _translateBatch(
          client: client,
          apiKey: apiKey,
          locale: locale,
          source: {for (final key in keys) key: source[key]!},
        );
        output.addAll(translated);
        await _write(locale, source, output);
        stdout.writeln('$locale: ${output.length}/62 saved.');
      }
      _validate(locale, source, output);
    }
  } finally {
    client.close();
  }
}

Future<Map<String, String>> _translateBatch({
  required http.Client client,
  required String apiKey,
  required String locale,
  required Map<String, String> source,
}) async {
  final language = _locales[locale]!;
  final prompt = StringBuffer()
    ..writeln(
        'Translate the following short author biographies from English into natural, polished $language.')
    ..writeln(
        'Preserve every JSON key exactly. Preserve personal names, Chinese names, dates, facts, and work titles accurately. Translate prose and conventional work titles where natural. Do not add commentary or omit information.')
    ..writeln('Input JSON:')
    ..write(jsonEncode(source));
  final schema = {
    'type': 'object',
    'properties': {
      for (final key in source.keys) key: {'type': 'string'},
    },
    'required': source.keys.toList(),
  };
  final uri = Uri.parse(
    'https://generativelanguage.googleapis.com/v1beta/models/$_model:generateContent?key=$apiKey',
  );

  for (var attempt = 1; attempt <= 7; attempt++) {
    try {
      final response = await client
          .post(
            uri,
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode({
              'contents': [
                {
                  'parts': [
                    {'text': prompt.toString()},
                  ],
                },
              ],
              'generationConfig': {
                'temperature': 0.1,
                'maxOutputTokens': 8192,
                'responseMimeType': 'application/json',
                'responseSchema': schema,
              },
            }),
          )
          .timeout(const Duration(seconds: 120));
      if (response.statusCode == 200) {
        final envelope = jsonDecode(response.body) as Map<String, dynamic>;
        final candidates = envelope['candidates'] as List<dynamic>?;
        final content = candidates?.first as Map<String, dynamic>?;
        final parts = (content?['content'] as Map<String, dynamic>?)?['parts']
            as List<dynamic>?;
        final text =
            (parts?.first as Map<String, dynamic>?)?['text'] as String?;
        if (text == null) if (text == null) {
          throw const FormatException('Gemini returned no text.');
        }
        final decoded = jsonDecode(text) as Map<String, dynamic>;
        final result = decoded.map(
          (key, value) => MapEntry(key, value.toString().trim()),
        );
        if (result.keys.toSet().length != source.length ||
            !result.keys.toSet().containsAll(source.keys) ||
            result.values.any((value) => value.length < 80)) {
          throw const FormatException('Incomplete or implausibly short batch.');
        }
        return result;
      }
      if (response.statusCode != 429 && response.statusCode < 500) {
        throw HttpException(
            'Gemini HTTP ${response.statusCode}: ${response.body}');
      }
      stderr.writeln('Gemini HTTP ${response.statusCode}; retry $attempt/7.');
    } catch (error) {
      if (attempt == 7) rethrow;
      stderr.writeln('Gemini attempt $attempt/7 failed: $error');
    }
    await Future<void>.delayed(Duration(seconds: attempt * attempt * 2));
  }
  throw StateError('Gemini retry loop ended unexpectedly.');
}

Future<Map<String, String>> _loadExisting(
  String locale,
  Set<String> expectedKeys,
) async {
  final file = File(_outputPath(locale));
  if (!await file.exists()) return {};
  final decoded = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
  return {
    for (final entry in decoded.entries)
      if (expectedKeys.contains(entry.key) &&
          entry.value.toString().trim().isNotEmpty)
        entry.key: entry.value.toString().trim(),
  };
}

Future<void> _write(
  String locale,
  Map<String, String> source,
  Map<String, String> translations,
) async {
  final ordered = {
    for (final key in source.keys)
      if (translations.containsKey(key)) key: translations[key]!,
  };
  final file = File(_outputPath(locale));
  final temporary = File('${file.path}.tmp');
  await temporary.writeAsString(
    '${const JsonEncoder.withIndent('  ').convert(ordered)}\n',
  );
  if (await file.exists()) await file.delete();
  await temporary.rename(file.path);
}

void _validate(
  String locale,
  Map<String, String> source,
  Map<String, String> translations,
) {
  if (translations.keys.toSet().length != source.length ||
      !translations.keys.toSet().containsAll(source.keys)) {
    throw StateError('$locale keys do not exactly match English.');
  }
  for (final key in source.keys) {
    final value = translations[key]!.trim();
    if (value.length < 80) {
      throw StateError('$locale:$key is too short.');
    }
    if (value == source[key]) {
      throw StateError('$locale:$key remains English.');
    }
  }
  stdout.writeln('$locale: validated 62 biographies.');
}

String _readApiKey() {
  final environmentKey = Platform.environment['GEMINI_API_KEY']?.trim();
  if (environmentKey != null && environmentKey.isNotEmpty)
    return environmentKey;
  final file = File('.env');
  if (file.existsSync()) {
    for (final line in file.readAsLinesSync()) {
      final match =
          RegExp(r'^\s*GEMINI_API_KEY\s*=\s*(.+?)\s*$').firstMatch(line);
      if (match != null) {
        return match.group(1)!.replaceAll(RegExp(r'''^["']|["']$'''), '');
      }
    }
  }
  throw StateError('Set GEMINI_API_KEY or add it to the ignored .env file.');
}

String _outputPath(String locale) =>
    'assets/data/l10n/author_bios_$locale.json';
