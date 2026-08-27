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
    if (trimmed.isEmpty) continue;
    if (trimmed.startsWith('*** START OF') || trimmed.startsWith('*** END OF') || trimmed.startsWith('End of the Project Gutenberg')) continue;

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
  print('=== Ingesting Batch 2: Poetry & Additional Dynastic Novels ===');

  // 1. Shijing (诗经)
  print('\nFetching 诗经 (Classic of Poetry) from GitHub...');
  final shijingRaw = await fetchUrl('https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%AF%97%E7%BB%8F/shijing.json');
  if (shijingRaw != null) {
    final List<dynamic> poems = jsonDecode(shijingRaw);
    final List<Map<String, dynamic>> chapters = [];
    print('  -> Found ${poems.length} poems');

    for (int i = 0; i < poems.length; i++) {
      final p = poems[i] as Map<String, dynamic>;
      final title = p['title'] as String? ?? '诗经第${i + 1}首';
      final chapter = p['chapter'] as String? ?? '国风';
      final section = p['section'] as String? ?? '';
      final content = (p['content'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];

      final List<Map<String, dynamic>> sentenceObjects = [];
      for (final line in content) {
        final pinyin = PinyinHelper.getPinyin(line, separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
        sentenceObjects.add({
          'chinese': line,
          'pinyin': pinyin,
          'english': '',
        });
      }

      chapters.add({
        'id': 'classic_of_poetry_ch_${i + 1}',
        'bookId': 'classic_of_poetry',
        'chapterIndex': i + 1,
        'title': '$chapter·$section: $title',
        'titleEn': 'Poem ${i + 1}: $title ($chapter)',
        'sentences': sentenceObjects,
      });
    }

    final file = File('assets/data/books/classic_of_poetry.json');
    file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(chapters));
    print('✅ SUCCESS: classic_of_poetry written with ${chapters.length} poems (${file.lengthSync() ~/ 1024} KB)');
  }

  // 2. Chuci (楚辞)
  print('\nFetching 楚辞 (Songs of Chu) from GitHub...');
  final chuciRaw = await fetchUrl('https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E6%A5%9A%E8%BE%9E/chuci.json');
  if (chuciRaw != null) {
    final List<dynamic> pieces = jsonDecode(chuciRaw);
    final List<Map<String, dynamic>> chapters = [];
    print('  -> Found ${pieces.length} pieces');

    for (int i = 0; i < pieces.length; i++) {
      final p = pieces[i] as Map<String, dynamic>;
      final title = p['title'] as String? ?? '楚辞第${i + 1}篇';
      final section = p['section'] as String? ?? '';
      final author = p['author'] as String? ?? '屈原';
      final content = (p['content'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];

      final List<Map<String, dynamic>> sentenceObjects = [];
      for (final line in content) {
        final pinyin = PinyinHelper.getPinyin(line, separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
        sentenceObjects.add({
          'chinese': line,
          'pinyin': pinyin,
          'english': '',
        });
      }

      chapters.add({
        'id': 'songs_of_chu_ch_${i + 1}',
        'bookId': 'songs_of_chu',
        'chapterIndex': i + 1,
        'title': '$section: $title ($author)',
        'titleEn': 'Piece ${i + 1}: $title by $author',
        'sentences': sentenceObjects,
      });
    }

    final file = File('assets/data/books/songs_of_chu.json');
    file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(chapters));
    print('✅ SUCCESS: songs_of_chu written with ${chapters.length} pieces (${file.lengthSync() ~/ 1024} KB)');
  }

  // 3. Additional Gutenberg novels
  final Map<String, String> moreGutenberg = {
    'eastern_zhou_chronicles': 'https://www.gutenberg.org/files/24177/24177-0.txt',
    'xingshi_hengyan': 'https://www.gutenberg.org/files/25310/25310-0.txt',
    'jingshi_tongyan': 'https://www.gutenberg.org/files/25309/25309-0.txt',
    'yushi_mingyan': 'https://www.gutenberg.org/files/25308/25308-0.txt',
    'first_slapping_table': 'https://www.gutenberg.org/files/25307/25307-0.txt',
    'second_slapping_table': 'https://www.gutenberg.org/files/25306/25306-0.txt',
  };

  for (final entry in moreGutenberg.entries) {
    final bookId = entry.key;
    final url = entry.value;
    print('\nFetching $bookId from $url ...');
    final rawText = await fetchUrl(url);
    if (rawText == null || rawText.isEmpty) {
      print('❌ Failed to fetch $bookId');
      continue;
    }

    print('  -> Downloaded ${rawText.length} characters');
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

        final sentencesToUse = rawSentences.take(120).toList();
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
    }

    if (chapters.isNotEmpty) {
      final targetFile = File('assets/data/books/$bookId.json');
      targetFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(chapters));
      print('✅ SUCCESS: $bookId written with ${chapters.length} chapters (${targetFile.lengthSync() ~/ 1024} KB)');
    }
  }

  print('\n=== Batch 2 Finished! ===');
}
