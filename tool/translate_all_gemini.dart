import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const langs = ['ar','de','es','fr','hi','id','it','ja','ko','pt','ru','vi'];
const apiBase = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=';

String getKey() {
  for (final l in File('.env').readAsLinesSync()) {
    if (l.startsWith('GEMINI_API_KEY=')) return l.split('=')[1].trim();
  }
  throw Exception('No GEMINI_API_KEY');
}

Future<List<String>> translate(List<String> texts, String lang, String key) async {
  if (texts.isEmpty) return [];
  final buf = StringBuffer();
  buf.writeln('Translate these ${texts.length} English texts to language code "$lang".');
  buf.writeln('Return ONLY numbered translations, one per line. ALWAYS translate.');
  buf.writeln('Example: 1. "Chapter 1" -> in French: "1. Chapitre 1"');
  for (int i = 0; i < texts.length; i++) {
    buf.writeln('${i + 1}. "${texts[i]}"');
  }
  final url = Uri.parse('$apiBase$key');
  for (int a = 1; a <= 3; a++) {
    try {
      final r = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [{'parts': [{'text': buf.toString()}]}],
          'generationConfig': {'temperature': 0.05, 'maxOutputTokens': 8192},
        }),
      ).timeout(Duration(seconds: 90));
      if (r.statusCode == 200) {
        final data = jsonDecode(r.body);
        final result = data['candidates'][0]['content']['parts'][0]['text'] as String;
        final out = <String>[];
        for (final line in result.split('\n')) {
          final m = RegExp(r'^\d+\.\s*"?(.+?)"?\s*$').firstMatch(line.trim());
          if (m != null) out.add(m.group(1)!.trim());
        }
        if (out.length == texts.length) return out;
        print('  Parse: got ${out.length}, want ${texts.length}');
        if (out.isNotEmpty && out.length >= texts.length ~/ 2) return out;
      } else {
        print('  HTTP ${r.statusCode}: ${r.body.length > 200 ? r.body.substring(0,200) : r.body}');
      }
    } catch (e) {
      if (a == 3) { print('  FAIL: $e'); break; }
      await Future.delayed(Duration(seconds: 3 * a));
    }
  }
  return texts;
}

Future<List<String>> translate(List<String> texts, String lang, String key) async {
  if (texts.isEmpty) return [];
  final buf = StringBuffer();
  buf.writeln('Translate these ${texts.length} English texts to language code "$lang".');
  buf.writeln('Return ONLY numbered translations, one per line. ALWAYS translate.');
  buf.writeln('Example input: "Chapter 1" -> in French: "Chapitre 1"');
  for (int i = 0; i < texts.length; i++) {
    buf.writeln('${i + 1}. "${texts[i]}"');
  }
  final url = Uri.parse('$apiBase$key');
  for (int a = 1; a <= 3; a++) {
    try {
      final r = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [{'parts': [{'text': buf.toString()}]}],
          'generationConfig': {'temperature': 0.05, 'maxOutputTokens': 8192},
        }),
      ).timeout(Duration(seconds: 90));
      if (r.statusCode == 200) {
        final data = jsonDecode(r.body);
        final result = data['candidates'][0]['content']['parts'][0]['text'] as String;
        final out = <String>[];
        for (final line in result.split('\n')) {
          final m = RegExp(r'^\d+\.\s*"?(.+?)"?\s*$').firstMatch(line.trim());
          if (m != null) out.add(m.group(1)!.trim());
        }
        if (out.length == texts.length) return out;
        print('  Parse: got ${out.length}, want ${texts.length}');
        if (out.isNotEmpty) return out;
      }
    } catch (e) {
      if (a == 3) { print('  FAIL: $e'); break; }
      await Future.delayed(Duration(seconds: 5 * a));
    }
  }
  return texts;
}

void main() async {
  final key = getKey();
  print('Key: ${key.substring(0, 6)}...${key.substring(key.length - 4)}');

  // Build chapter title source map
  print('\n=== BUILDING CHAPTER TITLES ===');
  final src = <String, String>{};
  for (final f in Directory('assets/data/books').listSync().whereType<File>().toList()
    ..sort((a, b) => a.path.compareTo(b.path))) {
    final bid = f.uri.pathSegments.last.replaceAll('.json', '');
    for (final ch in (json.decode(await f.readAsString()) as List)) {
      var t = ch['titleEn'] as String? ?? ch['title'] as String? ?? '';
      final cm = RegExp(r'[\u4e00-\u9fff]').firstMatch(t);
      if (cm != null) {
        t = t.substring(0, cm.start).trim();
        if (t.isEmpty || t.endsWith(':') || t.endsWith('：')) {
          t = 'Chapter ${ch['chapterIndex']}';
        } else {
          t = t.replaceAll(RegExp(r'[：:\s]+$'), '');
        }
      }
      src['${bid}_${ch['chapterIndex']}'] = t;
    }
  }
  final keys = src.keys.toList();
  print('Total: ${keys.length}');

  for (final lang in langs) {
    final f = File('assets/data/l10n/chapter_titles_$lang.json');
    if (f.existsSync()) { print('  $lang: exists'); continue; }
    print('  Translating $lang (${keys.length} titles)...');
    final res = <String, dynamic>{};
    for (int i = 0; i < keys.length; i += 40) {
      final batch = keys.sublist(i, (i + 40 > keys.length) ? keys.length : i + 40);
      final texts = batch.map((k) => src[k]!).toList();
      final trans = await translate(texts, lang, key);
      for (int j = 0; j < batch.length; j++) {
        res[batch[j]] = (j < trans.length) ? trans[j] : texts[j];
      }
      stdout.write('\r    ${i + 40 > keys.length ? keys.length : i + 40}/${keys.length}');
      await Future.delayed(Duration(milliseconds: 200));
    }
    f.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(res));
    print('  -> done');
  }
  print('\nALL DONE');
}