import 'dart:convert';
import 'dart:io';
import 'package:lpinyin/lpinyin.dart';

Future<String?> fetchUrl(String url) async {
  final client = HttpClient();
  client.userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36';
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

List<String> extractCtextSentences(String html) {
  // CText puts text inside <td class="ctext">...</td>
  final regex = RegExp(r'<td class="ctext"[^>]*>(.*?)</td>', dotAll: true);
  final matches = regex.allMatches(html);
  final List<String> sentences = [];

  for (final m in matches) {
    var text = m.group(1) ?? '';
    // Strip tags
    text = text.replaceAll(RegExp(r'<[^>]+>'), ' ').replaceAll('&nbsp;', ' ').trim();
    if (text.isEmpty) continue;

    final parts = text.split(RegExp(r'(?<=[。！？；!?])'));
    for (final p in parts) {
      final s = p.trim();
      if (s.length >= 2 && !s.startsWith('#')) {
        sentences.add(s);
      }
    }
  }
  return sentences;
}

Future<void> main() async {
  print('=== Ingesting Group 1 Ancient Treatises from CText ===');

  final Map<String, Map<String, String>> ctextBooks = {
    'the_art_of_war': {
      '计篇': 'https://ctext.org/art-of-war/laying-plans/zh',
      '作战篇': 'https://ctext.org/art-of-war/waging-war/zh',
      '谋攻篇': 'https://ctext.org/art-of-war/attack-by-stratagem/zh',
      '形篇': 'https://ctext.org/art-of-war/tactical-dispositions/zh',
      '势篇': 'https://ctext.org/art-of-war/energy/zh',
      '虚实篇': 'https://ctext.org/art-of-war/weak-points-and-strong/zh',
      '军争篇': 'https://ctext.org/art-of-war/manoeuvring/zh',
      '九变篇': 'https://ctext.org/art-of-war/variation-in-tactics/zh',
      '行军篇': 'https://ctext.org/art-of-war/the-army-on-the-march/zh',
      '地形篇': 'https://ctext.org/art-of-war/terrain/zh',
      '九地篇': 'https://ctext.org/art-of-war/the-nine-situations/zh',
      '火攻篇': 'https://ctext.org/art-of-war/the-attack-by-fire/zh',
      '用间篇': 'https://ctext.org/art-of-war/the-use-of-spies/zh',
    },
    'guiguzi': {
      '捭阖第一': 'https://ctext.org/gui-gu-zi/bai-he/zh',
      '反应第二': 'https://ctext.org/gui-gu-zi/fan-ying/zh',
      '内揵第三': 'https://ctext.org/gui-gu-zi/nei-jian/zh',
      '抵巇第四': 'https://ctext.org/gui-gu-zi/di-xi/zh',
      '飞箝第五': 'https://ctext.org/gui-gu-zi/fei-qian/zh',
      '忤合第六': 'https://ctext.org/gui-gu-zi/wu-he/zh',
      '揣篇第七': 'https://ctext.org/gui-gu-zi/chuai/zh',
      '摩篇第八': 'https://ctext.org/gui-gu-zi/mo/zh',
      '量篇第九': 'https://ctext.org/gui-gu-zi/liang/zh',
      '谋篇第十': 'https://ctext.org/gui-gu-zi/mou/zh',
      '决篇第十一': 'https://ctext.org/gui-gu-zi/jue/zh',
      '符言第十二': 'https://ctext.org/gui-gu-zi/fu-yan/zh',
      '转圆第十三': 'https://ctext.org/gui-gu-zi/zhuan-yuan/zh',
      '胹乱第十四': 'https://ctext.org/gui-gu-zi/er-luan/zh',
    },
    'caigentan': {
      '修省': 'https://ctext.org/cai-gen-tan/xiu-sheng/zh',
      '应酬': 'https://ctext.org/cai-gen-tan/ying-chou/zh',
      '评议': 'https://ctext.org/cai-gen-tan/ping-yi/zh',
      '闲适': 'https://ctext.org/cai-gen-tan/xian-shi/zh',
      '概论': 'https://ctext.org/cai-gen-tan/gai-lun/zh',
    }
  };

  for (final bookEntry in ctextBooks.entries) {
    final bookId = bookEntry.key;
    final chapterUrls = bookEntry.value;
    print('\nIngesting $bookId (${chapterUrls.length} chapters) from CText...');

    final List<Map<String, dynamic>> compiledChapters = [];
    int chIdx = 1;

    for (final chEntry in chapterUrls.entries) {
      final chTitle = chEntry.key;
      final url = chEntry.value;

      final html = await fetchUrl(url);
      await Future.delayed(const Duration(milliseconds: 300)); // polite delay

      if (html == null) continue;
      final sentences = extractCtextSentences(html);
      if (sentences.isEmpty) continue;

      final List<Map<String, dynamic>> sentenceObjects = [];
      for (final s in sentences) {
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
      chIdx++;
    }

    if (compiledChapters.isNotEmpty) {
      final targetFile = File('assets/data/books/$bookId.json');
      targetFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(compiledChapters));
      print('\n  ✅ SUCCESS: $bookId written with ${compiledChapters.length} full chapters (${targetFile.lengthSync() ~/ 1024} KB)');
    }
  }

  print('\n=== CText Treatises Ingestion Finished! ===');
}
