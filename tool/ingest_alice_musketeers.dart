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
    if (trimmed.isEmpty || trimmed.contains('TXT小说天堂') || trimmed.contains('www.') || trimmed.startsWith('http')) continue;

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

Future<void> ingestBook(String bookId, String url) async {
  print('\nIngesting $bookId from $url ...');
  final content = await fetchUrl(url);
  if (content == null || content.length < 500) {
    print('❌ Failed to download $bookId');
    return;
  }

  print('  -> Downloaded ${content.length} characters (~${content.length ~/ 1024} KB)');

  final chapterRegex = RegExp(r'(第[0-9一二三四五六七八九十百千]+[回卷篇章部幕节集][^\n\r]*)');
  final matches = chapterRegex.allMatches(content).toList();
  final List<Map<String, dynamic>> compiledChapters = [];

  if (matches.length >= 3) {
    for (int i = 0; i < matches.length; i++) {
      final match = matches[i];
      final chTitle = match.group(1)?.trim() ?? '第${i + 1}章';
      final startPos = match.end;
      final endPos = (i < matches.length - 1) ? matches[i + 1].start : content.length;
      final chText = content.substring(startPos, endPos);

      final rawSentences = segmentSentences(chText);
      if (rawSentences.isEmpty) continue;

      final sentencesToUse = rawSentences.take(150).toList();
      final List<Map<String, dynamic>> sentenceObjects = [];
      for (final s in sentencesToUse) {
        final pinyin = PinyinHelper.getPinyin(s, separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
        sentenceObjects.add({
          'chinese': s,
          'pinyin': pinyin,
          'english': '',
        });
      }

      compiledChapters.add({
        'id': '${bookId}_ch_${compiledChapters.length + 1}',
        'bookId': bookId,
        'chapterIndex': compiledChapters.length + 1,
        'title': chTitle,
        'titleEn': 'Chapter ${compiledChapters.length + 1}: $chTitle',
        'sentences': sentenceObjects,
      });
    }
  } else {
    final allSentences = segmentSentences(content);
    const chunkSize = 80;
    int chIdx = 1;

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
        'id': '${bookId}_ch_$chIdx',
        'bookId': bookId,
        'chapterIndex': chIdx,
        'title': '第$chIdx章',
        'titleEn': 'Chapter $chIdx',
        'sentences': sentenceObjects,
      });
      chIdx++;
    }
  }

  if (compiledChapters.isNotEmpty) {
    final targetFile = File('assets/data/books/$bookId.json');
    targetFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(compiledChapters));
    print('  ✅ SUCCESS: $bookId written with ${compiledChapters.length} full chapters (${targetFile.lengthSync() ~/ 1024} KB)');
  }
}

Future<void> main() async {
  await ingestBook('the_three_musketeers', 'https://raw.githubusercontent.com/memxz/Ref_Book/master/%E3%80%90%E9%9B%B6%E4%BA%94%E7%94%B5%E5%AD%90%E4%B9%A6%E3%80%91%E4%B8%89%E4%B8%AA%E7%81%AB%E6%9E%AA%E6%89%8B_%5Btxt.02405.com%5D.txt');
  await ingestBook('alice_in_wonderland', 'https://raw.githubusercontent.com/BlankRain/ebooks/master/%E7%88%B1%E4%B8%BD%E4%B8%9D%E6%BC%AB%E6%B8%B8%E5%A5%87%E5%A2%83%E8%AE%B0_%E5%88%98%E6%98%93%E6%96%AF%C2%B7%E5%8D%A1%E7%BD%97%E5%B0%94_TXT%E5%B0%8F%E8%AF%B4%E5%A4%A9%E5%A0%82.txt');
}
