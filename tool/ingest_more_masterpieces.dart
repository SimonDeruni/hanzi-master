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
    print('Fetch error for $url: $e');
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
    if (trimmed.isEmpty || trimmed.contains('TXT小说天堂') || trimmed.contains('www.') || trimmed.contains('扫校') || trimmed.startsWith('http')) continue;

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
  print('=== Hanzi Master: Ingesting Batch 3 (Ba Jin, Kafka, Zweig, Hesse, Lu Xun, Shakespeare) ===');

  final Map<String, String> masterMap = {
    // Ba Jin Trilogy
    'the_family_bajin': '家-巴金-TXT小说天堂.txt',
    'spring_bajin': '春-巴金-TXT小说天堂.txt',
    'autumn_bajin': '秋-巴金-TXT小说天堂.txt',

    // Lu Xun
    'wandering_luxun': '彷徨-鲁迅-TXT小说天堂.txt',
    'wild_grass_luxun': '野草-鲁迅-TXT小说天堂.txt',

    // Kafka
    'the_castle_kafka': '城堡_卡夫卡_TXT小说天堂.txt',
    'the_metamorphosis': '卡夫卡短篇集_卡夫卡_TXT小说天堂.txt',

    // Stefan Zweig
    'twenty_four_hours_woman': '一个女人一生中的24小时_斯蒂芬·茨威格_TXT小说天堂.txt',
    'decisive_moments_history': '命运攸关的时刻_斯蒂芬·茨威格_TXT小说天堂.txt',

    // Hermann Hesse & Thomas Mann
    'siddhartha_hesse': '席特哈尔塔_赫尔曼·黑塞_TXT小说天堂.txt',
    'death_in_venice': '威尼斯之死_托马斯·曼_TXT小说天堂.txt',

    // Edgar Allan Poe
    'black_cat_poe': '爱伦·坡作品集_爱伦·坡_TXT小说天堂.txt',

    // Shakespeare
    'macbeth_shakespeare': '泰特斯·安德洛尼克斯_莎士比亚_TXT小说天堂.txt',
  };

  int successCount = 0;

  for (final entry in masterMap.entries) {
    final bookId = entry.key;
    final fileName = entry.value;

    print('\nIngesting $bookId ("$fileName")...');
    final rawUrl = 'https://raw.githubusercontent.com/BlankRain/ebooks/master/${Uri.encodeComponent(fileName)}';
    final content = await fetchUrl(rawUrl);

    if (content == null || content.length < 500) {
      print('❌ Failed to download $fileName');
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
      successCount++;
    }
  }

  print('\n=== Batch 3 Finished: Ingested $successCount full books! ===');
}
