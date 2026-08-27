import 'dart:convert';
import 'dart:io';
import 'package:lpinyin/lpinyin.dart';

Future<String?> fetchUrl(String url) async {
  final client = HttpClient();
  client.userAgent = 'HanziMasterIngestionBot/1.0 (educational research)';
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
    if (trimmed.isEmpty) continue;
    if (trimmed.startsWith('*** START OF') || trimmed.startsWith('*** END OF') || trimmed.startsWith('End of the Project Gutenberg') || trimmed.startsWith('http')) continue;

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

Future<bool> ingestFromRawText(String bookId, String rawText, {int sentencesPerChapter = 80}) async {
  if (rawText.trim().isEmpty) return false;

  final chapterRegex = RegExp(r'(第[0-9一二三四五六七八九十百千]+[回卷篇章][^\n\r]*)');
  final matches = chapterRegex.allMatches(rawText).toList();
  final List<Map<String, dynamic>> chapters = [];

  if (matches.length >= 3) {
    for (int i = 0; i < matches.length; i++) {
      final match = matches[i];
      final chTitle = match.group(1)?.trim() ?? '第${i + 1}回';
      final startPos = match.end;
      final endPos = (i < matches.length - 1) ? matches[i + 1].start : rawText.length;
      final chText = rawText.substring(startPos, endPos);

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
    // If no chapter headers, chunk sentences into chapters
    final allSentences = segmentSentences(rawText);
    if (allSentences.length < 10) return false;

    int chIndex = 1;
    for (int i = 0; i < allSentences.length; i += sentencesPerChapter) {
      final end = (i + sentencesPerChapter < allSentences.length) ? i + sentencesPerChapter : allSentences.length;
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
    print('  ✅ SUCCESS: $bookId written with ${chapters.length} chapters (${targetFile.lengthSync() ~/ 1024} KB)');
    return true;
  }
  return false;
}

void main() async {
  print('=== Hanzi Master: Master Full-Text Library Ingestion Pipeline ===');

  // Multi-source dictionary mapping book ID -> list of candidate URLs
  final Map<String, List<String>> candidateSources = {
    // 1. Classical Chinese Novels & Epics
    'eastern_zhou_chronicles': [
      'https://www.gutenberg.org/files/24177/24177-0.txt',
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E4%B8%9C%E5%91%A8%E5%88%97%E5%9B%BD%E5%BF%97.txt',
    ],
    'romance_sui_tang': [
      'https://www.gutenberg.org/files/25333/25333-0.txt',
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E9%9A%8B%E5%94%90%E6%BC%94%E4%B9%89.txt',
    ],
    'story_of_yue_fei': [
      'https://www.gutenberg.org/files/25334/25334-0.txt',
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E8%AF%B4%E5%B2%B3%E5%85%A8%E4%BC%A0.txt',
    ],
    'yang_family_generals': [
      'https://www.gutenberg.org/files/25335/25335-0.txt',
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E6%9D%A8%E5%AE%B6%E5%B0%86.txt',
    ],
    'judge_bao_cases': [
      'https://www.gutenberg.org/files/25336/25336-0.txt',
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E5%8C%85%E5%85%AC%E6%A1%88.txt',
    ],
    'shi_gong_cases': [
      'https://www.gutenberg.org/files/25337/25337-0.txt',
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E6%96%BD%E5%85%AC%E6%A1%88.txt',
    ],
    'legend_of_ji_gong': [
      'https://www.gutenberg.org/files/25338/25338-0.txt',
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E6%B5%8E%E5%85%AC%E5%85%A8%E4%BC%A0.txt',
    ],
    'stories_awaken_world': [
      'https://www.gutenberg.org/files/25310/25310-0.txt',
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E9%86%92%E4%B8%96%E6%81%92%E8%A8%80.txt',
    ],
    'stories_caution_world': [
      'https://www.gutenberg.org/files/25309/25309-0.txt',
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E8%AD%A6%E4%B8%96%E9%80%9A%E8%A8%80.txt',
    ],
    'stories_enlighten_world': [
      'https://www.gutenberg.org/files/25308/25308-0.txt',
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E5%96%BB%E4%B8%96%E6%98%8E%E8%A8%80.txt',
    ],
    'first_slapping_table': [
      'https://www.gutenberg.org/files/25307/25307-0.txt',
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E5%88%9D%E5%88%BB%E6%8B%8D%E6%A1%88%E6%83%8A%E5%A5%87.txt',
    ],
    'second_slapping_table': [
      'https://www.gutenberg.org/files/25306/25306-0.txt',
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E4%BA%8C%E5%88%BB%E6%8B%8D%E6%A1%88%E6%83%8A%E5%A5%87.txt',
    ],

    // 2. Ancient Philosophical & Historical Works
    'strategies_warring_states': [
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E6%88%98%E5%9B%BD%E7%AD%96.txt',
    ],
    'zuo_zhuan': [
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E5%B7%A6%E4%BC%A0.txt',
    ],
    'guanzi': [
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E7%AE%A1%E5%AD%90.txt',
    ],
    'shang_jun_shu': [
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E5%95%86%E5%90%9B%E4%B9%A6.txt',
    ],
    'sun_bin_art_of_war': [
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E5%AD%99%E8%87%91%E5%85%B5%E6%B3%95.txt',
    ],
    'wuzi_art_of_war': [
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E5%90%B4%E5%AD%90%E5%85%B5%E6%B3%95.txt',
    ],
    'six_secret_teachings': [
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E5%85%AD%E9%9F%AC.txt',
    ],

    // 3. Supernatural & Folklore
    'strange_tales_youyang': [
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E9%85%89%E9%98%B3%E6%9D%82%E4%BF%87.txt',
    ],
    'notes_thatched_cottage': [
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E9%98%85%E5%BE%AE%E8%8D%89%E5%A0%82%E7%AC%94%E8%AE%B0.txt',
    ],
    'six_records_floating_life': [
      'https://raw.githubusercontent.com/chinese-poetry/ancient-books/master/%E6%B5%AE%E7%94%9F%E5%85%AD%E8%AE%B0.txt',
    ]
  };

  int successCount = 0;
  int failCount = 0;
  final List<String> succeededBooks = [];
  final List<String> failedBooks = [];

  for (final entry in candidateSources.entries) {
    final bookId = entry.key;
    final urls = entry.value;
    print('\nFetching $bookId ...');
    bool ingested = false;

    for (final u in urls) {
      final raw = await fetchUrl(u);
      if (raw != null && raw.length >= 1000) {
        print('  -> Downloaded ${raw.length} chars from $u');
        final ok = await ingestFromRawText(bookId, raw);
        if (ok) {
          ingested = true;
          succeededBooks.add(bookId);
          successCount++;
          break;
        }
      }
    }

    if (!ingested) {
      print('  ❌ Failed to fetch full text for: $bookId');
      failedBooks.add(bookId);
      failCount++;
    }
  }

  print('\n======================================================');
  print('📊 MASTER INGESTION BATCH COMPLETED');
  print('======================================================');
  print('Successfully Ingested: $successCount books');
  print('Failed to Ingest: $failCount books');
}
