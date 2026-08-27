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
  print('=== Ingesting Verne, Shelley, and Charlotte Brontë ===');

  final Map<String, String> urls = {
    'twenty_thousand_leagues': 'https://raw.githubusercontent.com/VeejaLiu/ScienceFictionCollection/master/004%20-%20Jules%20Gabriel%20Verne(%E5%84%92%E5%8B%92%C2%B7%E5%8A%A0%E5%B8%83%E9%87%8C%E5%9F%83%E5%B0%94%C2%B7%E5%87%A1%E5%B0%94%E7%BA%B3)/01-%E4%B8%89%E9%83%A8%E6%9B%B2/%5B1870%5D%E3%80%8A%E6%B5%B7%E5%BA%95%E4%B8%A4%E4%B8%87%E9%87%8C%E3%80%8B(Vingt%20mille%20lieues%20sous%20les%20mers).txt',
    'around_the_world_in_eighty_days': 'https://raw.githubusercontent.com/VeejaLiu/ScienceFictionCollection/master/004%20-%20Jules%20Gabriel%20Verne(%E5%84%92%E5%8B%92%C2%B7%E5%8A%A0%E5%B8%83%E9%87%8C%E5%9F%83%E5%B0%94%C2%B7%E5%87%A1%E5%B0%94%E7%BA%B3)/%5B1873%5D%E3%80%8A%E5%85%AB%E5%8D%81%E5%A4%A9%E7%8E%AF%E6%B8%B8%E5%9C%B0%E7%90%83%E3%80%8B.txt',
    'journey_to_the_center_of_the_earth': 'https://raw.githubusercontent.com/VeejaLiu/ScienceFictionCollection/master/004%20-%20Jules%20Gabriel%20Verne(%E5%84%92%E5%8B%92%C2%B7%E5%8A%A0%E5%B8%83%E9%87%8C%E5%9F%83%E5%B0%94%C2%B7%E5%87%A1%E5%B0%94%E7%BA%B3)/%5B1864%5D%E3%80%8A%E5%9C%B0%E5%BF%83%E6%B8%B8%E8%AE%B0%E3%80%8B.txt',
    'the_mysterious_island': 'https://raw.githubusercontent.com/VeejaLiu/ScienceFictionCollection/master/004%20-%20Jules%20Gabriel%20Verne(%E5%84%92%E5%8B%92%C2%B7%E5%8A%A0%E5%B8%83%E9%87%8C%E5%9F%83%E5%B0%94%C2%B7%E5%87%A1%E5%B0%94%E7%BA%B3)/01-%E4%B8%89%E9%83%A8%E6%9B%B2/%5B1875%5D%E3%80%8A%E7%A5%9E%E7%A7%98%E5%B2%9B%E3%80%8B.txt',
    'frankenstein_shelley': 'https://raw.githubusercontent.com/VeejaLiu/ScienceFictionCollection/master/005%20-%20Mary%20Shelley(%E7%8E%9B%E4%B8%BD%C2%B7%E9%9B%AA%E8%8E%B1)/%5B1818%5D%E3%80%8A%E5%BC%97%E5%85%B0%E8%82%AF%E6%96%AF%E5%9 honesty%E3%80%8B(Frankenstein).txt',
    'jane_eyre': 'https://raw.githubusercontent.com/Pinyin2Hanzi/train/master/hmm/article/%E7%AE%80%E7%88%B1.txt',
  };

  for (final entry in urls.entries) {
    final bookId = entry.key;
    final url = entry.value;

    print('\nFetching $bookId...');
    final content = await fetchUrl(url);

    if (content == null || content.length < 500) {
      print('❌ Failed to download $bookId');
      continue;
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

  print('\n=== Batch Ingestion Complete! ===');
}
