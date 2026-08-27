import 'dart:convert';
import 'dart:io';
import 'package:lpinyin/lpinyin.dart';

Future<String?> fetchRawText(String url) async {
  final client = HttpClient();
  client.userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
  try {
    final req = await client.getUrl(Uri.parse(url));
    final resp = await req.close();
    if (resp.statusCode == 200) {
      // Gutenberg texts can be UTF-8 or Big5/GBK. Read bytes and decode
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
    if (trimmed.isEmpty) continue;
    if (trimmed.startsWith('*** START OF') || trimmed.startsWith('*** END OF') || trimmed.startsWith('End of the Project Gutenberg')) continue;

    // Split line by sentence punctuation
    final parts = trimmed.split(RegExp(r'(?<=[。！？；!?])'));
    for (final p in parts) {
      final s = p.trim();
      if (s.length >= 2) {
        sentences.add(s);
      }
    }
  }
  return sentences;
}

void main() async {
  print('=== Ingesting Authentic Unabridged Texts from Gutenberg & Open Repos ===');

  final Map<String, String> gutenbergSources = {
    'fengshen_yanyi': 'https://www.gutenberg.org/files/24264/24264-0.txt',
    'the_scholars': 'https://www.gutenberg.org/files/24225/24225-0.txt',
    'flowers_in_the_mirror': 'https://www.gutenberg.org/files/25332/25332-0.txt',
    'officialdom_unmasked': 'https://www.gutenberg.org/files/25301/25301-0.txt',
    'flower_in_sinful_sea': 'https://www.gutenberg.org/files/25280/25280-0.txt',
    'bizarre_happenings_two_decades': 'https://www.gutenberg.org/files/25281/25281-0.txt',
    'lao_can_youji': 'https://www.gutenberg.org/files/23956/23956-0.txt',
    'liaozhai_zhiyi': 'https://www.gutenberg.org/files/24051/24051-0.txt',
  };

  for (final entry in gutenbergSources.entries) {
    final bookId = entry.key;
    final url = entry.value;
    print('\nFetching $bookId from $url ...');

    final rawText = await fetchRawText(url);
    if (rawText == null || rawText.isEmpty) {
      print('❌ Failed to fetch $bookId');
      continue;
    }

    print('  -> Downloaded ${rawText.length} characters');

    // Split by chapter markers
    final chapterRegex = RegExp(r'(第[0-9一二三四五六七八九十百千]+[回卷篇章][^\n\r]*)');
    final matches = chapterRegex.allMatches(rawText).toList();

    final List<Map<String, dynamic>> chapters = [];

    if (matches.isNotEmpty) {
      for (int i = 0; i < matches.length; i++) {
        final match = matches[i];
        final chTitle = match.group(1)?.trim() ?? '第${i + 1}回';
        final startPos = match.end;
        final endPos = (i < matches.length - 1) ? matches[i + 1].start : rawText.length;
        final chText = rawText.substring(startPos, endPos);

        final rawSentences = segmentSentences(chText);
        if (rawSentences.isEmpty) continue;

        // Limit sentences per chapter if excessively long (take first 150 sentences per chapter)
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

        chapters.add({
          'id': '${bookId}_ch_${chapters.length + 1}',
          'bookId': bookId,
          'chapterIndex': chapters.length + 1,
          'title': chTitle,
          'titleEn': 'Chapter ${chapters.length + 1}: $chTitle',
          'sentences': sentenceObjects,
        });
      }
    } else {
      // If no chapter headers, chunk into chapters of 80 sentences each
      final allSentences = segmentSentences(rawText);
      const chunkSize = 80;
      int chIndex = 1;
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

        chapters.add({
          'id': '${bookId}_ch_$chIndex',
          'bookId': bookId,
          'chapterIndex': chIndex,
          'title': '第$chIndex章',
          'titleEn': 'Chapter $chIndex',
          'sentences': sentenceObjects,
        });
        chIndex++;
      }
    }

    if (chapters.isNotEmpty) {
      final targetFile = File('assets/data/books/$bookId.json');
      targetFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(chapters));
      print('✅ Ingested $bookId: ${chapters.length} chapters, ${targetFile.lengthSync() ~/ 1024} KB');
    }
  }

  print('\n=== Gutenberg Ingestion Batch Finished! ===');
}
