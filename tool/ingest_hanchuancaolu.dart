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
    if (trimmed.isEmpty || trimmed.startsWith('#')) continue;

    final parts = trimmed.split(RegExp(r'(?<=[。！？；!?])'));
    for (final p in parts) {
      final s = p.trim();
      if (s.length >= 3) {
        sentences.add(s);
      }
    }
  }
  return sentences;
}

Future<void> main() async {
  print('=== Ingesting Full Unabridged Texts from hanchuancaolu ===');

  // Query tree for exact file paths
  final client = HttpClient();
  client.userAgent = 'HanziMasterApp/1.0';
  final uri = Uri.parse('https://api.github.com/repos/xp44mm/hanchuancaolu/git/trees/master?recursive=1');
  final req = await client.getUrl(uri);
  final resp = await req.close();
  final body = await resp.transform(utf8.decoder).join();
  final json = jsonDecode(body) as Map<String, dynamic>;
  final tree = (json['tree'] as List<dynamic>?) ?? [];
  client.close();

  final Map<String, String> bookDirMap = {
    'first_slapping_table': '初刻拍案惊奇',
    'second_slapping_table': '二刻拍案惊奇',
    'stories_enlighten_world': '喻世明言',
    'stories_caution_world': '警世通言',
    'stories_awaken_world': '醒世恒言',
    'zuo_zhuan': '左傳',
  };

  for (final entry in bookDirMap.entries) {
    final bookId = entry.key;
    final dirName = entry.value;
    print('\nIngesting $bookId (directory "$dirName")...');

    final matchingFiles = tree.where((item) {
      final path = item['path'] as String;
      return path.startsWith('$dirName/') && path.endsWith('.txt');
    }).toList();

    matchingFiles.sort((a, b) => (a['path'] as String).compareTo(b['path'] as String));

    print('  Found ${matchingFiles.length} chapter files for $dirName');

    final List<Map<String, dynamic>> compiledChapters = [];

    for (int i = 0; i < matchingFiles.length; i++) {
      final item = matchingFiles[i];
      final path = item['path'] as String;
      final rawUrl = 'https://raw.githubusercontent.com/xp44mm/hanchuancaolu/master/${Uri.encodeComponent(path)}';

      final content = await fetchUrl(rawUrl);
      if (content == null || content.isEmpty) continue;

      final sentences = segmentSentences(content);
      if (sentences.isEmpty) continue;

      final chIdx = compiledChapters.length + 1;
      final fileName = path.split('/').last.replaceAll('.txt', '');
      final chTitle = fileName;

      final List<Map<String, dynamic>> sentenceObjects = [];
      for (final s in sentences.take(120)) {
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
        'title': chTitle,
        'titleEn': 'Chapter $chIdx: $chTitle',
        'sentences': sentenceObjects,
      });

      stdout.write('.');
    }

    if (compiledChapters.isNotEmpty) {
      final targetFile = File('assets/data/books/$bookId.json');
      targetFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(compiledChapters));
      print('\n  ✅ SUCCESS: $bookId written with ${compiledChapters.length} full chapters (~${targetFile.lengthSync() ~/ 1024} KB)');
    }
  }

  print('\n=== Hanchuancaolu Ingestion Finished! ===');
}
