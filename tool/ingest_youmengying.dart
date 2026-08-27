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

Future<void> main() async {
  print('=== Ingesting You Meng Ying ===');
  final raw = await fetchUrl('https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E5%B9%BD%E6%A2%A6%E5%BD%B1/youmengying.json');
  if (raw == null) return;

  final List<dynamic> items = jsonDecode(raw);
  print('Found ${items.length} aphorisms');

  final List<Map<String, dynamic>> chapters = [];
  const chunkSize = 20;
  int chIdx = 1;

  for (int i = 0; i < items.length; i += chunkSize) {
    final end = (i + chunkSize < items.length) ? i + chunkSize : items.length;
    final slice = items.sublist(i, end);

    final List<Map<String, dynamic>> sentenceObjects = [];
    for (final item in slice) {
      final content = item['content'] as String? ?? '';
      if (content.isEmpty) continue;
      final pinyin = PinyinHelper.getPinyin(content, separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
      sentenceObjects.add({
        'chinese': content,
        'pinyin': pinyin,
        'english': '',
      });
    }

    chapters.add({
      'id': 'you_meng_ying_ch_$chIdx',
      'bookId': 'you_meng_ying',
      'chapterIndex': chIdx,
      'title': '幽梦影 卷$chIdx',
      'titleEn': 'Volume $chIdx: Aphorisms ${i + 1}-$end',
      'sentences': sentenceObjects,
    });
    chIdx++;
  }

  final targetFile = File('assets/data/books/you_meng_ying.json');
  targetFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(chapters));
  print('✅ SUCCESS: you_meng_ying written with ${chapters.length} full chapters (${targetFile.lengthSync() ~/ 1024} KB)');
}
