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
    if (trimmed.isEmpty || trimmed.startsWith('http')) continue;

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
  print('=== Ingesting Frankenstein & Jane Eyre ===');

  const frankensteinUrl = 'https://raw.githubusercontent.com/VeejaLiu/ScienceFictionCollection/master/005%20-%20Mary%20Shelley(%E7%8E%9B%E4%B8%BD%C2%B7%E9%9B%AA%E8%8E%B1)/%5B1818%5D%E3%80%8A%E5%BC%97%E5%85%B0%E8%82%AF%E6%96%AF%E5%9D%A6%E3%80%8B(Frankenstein).txt';
  final content = await fetchUrl(frankensteinUrl);

  if (content != null && content.length > 500) {
    print('✅ Downloaded Frankenstein: ${content.length} chars');
    final allSentences = segmentSentences(content);
    const chunkSize = 80;
    int chIdx = 1;
    final List<Map<String, dynamic>> compiledChapters = [];

    for (int i = 0; i < allSentences.length; i += chunkSize) {
      final end = (i + chunkSize < allSentences.length) ? i + chunkSize : allSentences.length;
      final slice = allSentences.sublist(i, end);

      final List<Map<String, dynamic>> sentenceObjects = [];
      for (final s in slice) {
        final pinyin = PinyinHelper.getPinyin(s, separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
        sentenceObjects.add({
          'chinese': s,
          'pinyin': pinyin,
          'english': '',
        });
      }

      compiledChapters.add({
        'id': 'frankenstein_shelley_ch_$chIdx',
        'bookId': 'frankenstein_shelley',
        'chapterIndex': chIdx,
        'title': '第$chIdx章',
        'titleEn': 'Chapter $chIdx',
        'sentences': sentenceObjects,
      });
      chIdx++;
    }

    final targetFile = File('assets/data/books/frankenstein_shelley.json');
    targetFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(compiledChapters));
    print('✅ SUCCESS: frankenstein_shelley written with ${compiledChapters.length} full chapters (${targetFile.lengthSync() ~/ 1024} KB)');
  }
}
