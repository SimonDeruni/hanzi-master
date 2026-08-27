import 'dart:convert';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:lpinyin/lpinyin.dart';

Future<List<int>?> downloadBytes(String url) async {
  final client = HttpClient();
  client.userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
  try {
    final req = await client.getUrl(Uri.parse(url));
    final resp = await req.close();
    if (resp.statusCode == 200) {
      return await resp.fold<List<int>>([], (prev, elem) => prev..addAll(elem));
    }
    return null;
  } catch (e) {
    print('Error downloading $url: $e');
    return null;
  } finally {
    client.close();
  }
}

List<String> extractHtmlSentences(String html) {
  var clean = html
      .replaceAll(RegExp(r'<style[^>]*>.*?</style>', dotAll: true), '')
      .replaceAll(RegExp(r'<script[^>]*>.*?</script>', dotAll: true), '')
      .replaceAll(RegExp(r'<[^>]+>'), ' ')
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&ldquo;', '“')
      .replaceAll('&rdquo;', '”')
      .replaceAll('&lsquo;', '‘')
      .replaceAll('&rsquo;', '’')
      .replaceAll('\r\n', '\n')
      .replaceAll('\r', '\n');

  final lines = clean.split('\n');
  final List<String> sentences = [];

  for (final l in lines) {
    final trimmed = l.trim();
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
  print('=== Re-processing Jane Eyre EPUB ===');

  final rawUrl = 'https://raw.githubusercontent.com/jugetaozi/ibooks/master/${Uri.encodeComponent("简爱.epub")}';
  final bytes = await downloadBytes(rawUrl);
  if (bytes == null) return;

  final archive = ZipDecoder().decodeBytes(bytes);
  final List<String> allSentences = [];

  for (final file in archive) {
    if (file.name.endsWith('.html') || file.name.endsWith('.xhtml') || file.name.endsWith('.htm')) {
      final contentBytes = file.content as List<int>;
      String htmlContent;
      try {
        htmlContent = utf8.decode(contentBytes);
      } catch (_) {
        htmlContent = latin1.decode(contentBytes);
      }
      final sentences = extractHtmlSentences(htmlContent);
      allSentences.addAll(sentences);
    }
  }

  print('Total sentences in Jane Eyre: ${allSentences.length}');
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
      'id': 'jane_eyre_ch_$chIdx',
      'bookId': 'jane_eyre',
      'chapterIndex': chIdx,
      'title': '第$chIdx章',
      'titleEn': 'Chapter $chIdx',
      'sentences': sentenceObjects,
    });
    chIdx++;
  }

  final targetFile = File('assets/data/books/jane_eyre.json');
  targetFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(compiledChapters));
  print('✅ SUCCESS: jane_eyre written with ${compiledChapters.length} full chapters (${targetFile.lengthSync() ~/ 1024} KB)');
}
