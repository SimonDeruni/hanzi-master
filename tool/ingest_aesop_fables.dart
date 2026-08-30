import 'dart:convert';
import 'dart:io';
import 'package:lpinyin/lpinyin.dart';

Future<String?> fetchUrl(String url) async {
  final client = HttpClient();
  client.userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
  try {
    final req = await client.getUrl(Uri.parse(url));
    final resp = await req.close();
    if (resp.statusCode == 200) {
      final bytes = await resp.fold<List<int>>([], (prev, elem) => prev..addAll(elem));
      try {
        return utf8.decode(bytes);
      } catch (_) {
        return latin1.decode(bytes);
      }
    }
    return null;
  } catch (e) {
    print('Fetch error: $e');
    return null;
  } finally {
    client.close();
  }
}

List<String> segmentSentences(String text) {
  final clean = text.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
  final rawLines = clean.split('\n');
  final List<String> sentences = [];

  for (final line in rawLines) {
    final trimmed = line.trim();
    if (trimmed.isEmpty || trimmed.startsWith('http') || trimmed.startsWith('---')) continue;

    final parts = trimmed.split(RegExp(r'(?<=[。！？；!?])'));
    for (final p in parts) {
      final s = p.trim();
      if (s.length >= 3 && !s.startsWith('#') && !s.startsWith('*')) {
        sentences.add(s);
      }
    }
  }
  return sentences;
}

Future<void> main() async {
  print('=== Ingesting Aesop Fables ===');
  const rawUrl = 'https://raw.githubusercontent.com/guangpingmo/AesopsFables/master/%E4%BC%8A%E7%B4%A2%E5%AF%93%E8%A8%80(Aesop\'s%20Fables).md';
  final content = await fetchUrl(rawUrl);
  if (content == null || content.isEmpty) return;

  print('Downloaded Aesop Fables: ${content.length} chars');

  // Split by markdown headers (# 或 ##)
  final sections = content.split(RegExp(r'\n(?=#{1,3}\s+)'));
  final List<Map<String, dynamic>> compiledChapters = [];
  int chIdx = 1;

  for (final sec in sections) {
    final trimmed = sec.trim();
    if (trimmed.isEmpty) continue;

    final lines = trimmed.split('\n');
    var title = lines.first.replaceAll(RegExp(r'^#+\s*'), '').trim();
    if (title.isEmpty) title = '第$chIdx寓言';

    final body = lines.skip(1).join('\n');
    final sentences = segmentSentences(body);
    if (sentences.isEmpty) continue;

    final List<Map<String, dynamic>> sentenceObjects = [];
    for (final s in sentences) {
      final pinyin = PinyinHelper.getPinyin(s, separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
      sentenceObjects.add({
        'chinese': s,
        'pinyin': pinyin,
        'english': '',
      });
    }

    compiledChapters.add({
      'id': 'aesop_fables_ch_$chIdx',
      'bookId': 'aesop_fables',
      'chapterIndex': chIdx,
      'title': title,
      'titleEn': 'Fable $chIdx: $title',
      'sentences': sentenceObjects,
    });
    chIdx++;
  }

  final targetFile = File('assets/data/books/aesop_fables.json');
  targetFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(compiledChapters));
  print('✅ SUCCESS: aesop_fables written with ${compiledChapters.length} full fables (${targetFile.lengthSync() ~/ 1024} KB)');
}
