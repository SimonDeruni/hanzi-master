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
  print('=== Ingesting EPUB Masterpieces from jugetaozi/ibooks ===');

  final Map<String, String> epubMap = {
    'the_adventures_of_sherlock_holmes': '福尔摩斯探案全集.epub',
    'the_call_of_the_wild': '《野性的呼唤》杰克·伦敦.epub',
    'animal_farm': '动物农场.epub',
    'jane_eyre': '简爱.epub',
  };

  for (final entry in epubMap.entries) {
    final bookId = entry.key;
    final epubName = entry.value;

    print('\nDownloading $bookId ("$epubName")...');
    final rawUrl = 'https://raw.githubusercontent.com/jugetaozi/ibooks/master/${Uri.encodeComponent(epubName)}';
    final bytes = await downloadBytes(rawUrl);

    if (bytes == null || bytes.isEmpty) {
      print('❌ Failed to download $epubName');
      continue;
    }

    print('  -> Downloaded ${bytes.length ~/ 1024} KB');

    try {
      final archive = ZipDecoder().decodeBytes(bytes);
      final List<Map<String, dynamic>> compiledChapters = [];
      int chIdx = 1;

      for (final file in archive) {
        if (file.name.endsWith('.html') || file.name.endsWith('.xhtml') || file.name.endsWith('.htm')) {
          if (file.name.contains('cover') || file.name.contains('nav') || file.name.contains('toc')) continue;

          final contentBytes = file.content as List<int>;
          String htmlContent;
          try {
            htmlContent = utf8.decode(contentBytes);
          } catch (_) {
            htmlContent = latin1.decode(contentBytes);
          }

          final sentences = extractHtmlSentences(htmlContent);
          if (sentences.length < 3) continue;

          final List<Map<String, dynamic>> sentenceObjects = [];
          for (final s in sentences.take(150)) {
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
    } catch (e) {
      print('❌ Error unzipping $epubName: $e');
    }
  }

  print('\n=== Jugetaozi Ingestion Finished! ===');
}
