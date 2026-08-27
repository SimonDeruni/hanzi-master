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

Future<String?> fetchWikisourcePage(String title) async {
  final client = HttpClient();
  client.userAgent = 'HanziMasterApp/1.0 (educational research)';
  final uri = Uri.parse('https://zh.wikisource.org/w/api.php?action=parse&page=${Uri.encodeComponent(title)}&format=json&prop=wikitext');
  try {
    final req = await client.getUrl(uri);
    final resp = await req.close();
    final body = await resp.transform(utf8.decoder).join();
    final json = jsonDecode(body) as Map<String, dynamic>;
    return json['parse']?['wikitext']?['*'] as String?;
  } catch (e) {
    return null;
  } finally {
    client.close();
  }
}

List<String> cleanAndSegment(String rawText) {
  // Remove wiki templates, markup, headers
  var clean = rawText
      .replaceAll(RegExp(r'\{\{[^\}]*\}\}'), '')
      .replaceAll(RegExp(r'\[\[(?:[^|\]]*\|)?([^\]]+)\]\]'), r'$1')
      .replaceAll(RegExp(r'==+[^=]+==+'), '')
      .replaceAll(RegExp(r'<[^>]+>'), '')
      .replaceAll(RegExp(r'__\w+__'), '')
      .replaceAll('\r\n', '\n')
      .replaceAll('\r', '\n');

  final lines = clean.split('\n');
  final List<String> sentences = [];

  for (final l in lines) {
    final trimmed = l.trim();
    if (trimmed.isEmpty || trimmed.startsWith('|') || trimmed.startsWith('!') || trimmed.startsWith('Category:')) continue;
    final parts = trimmed.split(RegExp(r'(?<=[。！？；!?])'));
    for (final p in parts) {
      final s = p.trim();
      if (s.length >= 4 && !s.startsWith('http')) {
        sentences.add(s);
      }
    }
  }
  return sentences;
}

void main() async {
  print('=== Ingesting Complete Texts from Wikisource and Open Repos ===');

  // List of books to fetch from Wikisource
  final Map<String, List<String>> wikisourceBooks = {
    'lao_can_youji': List.generate(20, (i) => '老殘遊記/第${(i + 1).toString().padLeft(2, '0')}回'),
    'eastern_zhou_chronicles': List.generate(30, (i) => '東周列國志/第${(i + 1).toString().padLeft(3, '0')}回'),
    'bizarre_happenings_two_decades': List.generate(30, (i) => '二十年目睹之怪現狀/第${(i + 1).toString().padLeft(3, '0')}回'),
    'stories_awaken_world': List.generate(40, (i) => '醒世恆言/第${(i + 1).toString().padLeft(2, '0')}卷'),
    'stories_caution_world': List.generate(40, (i) => '警世通言/第${(i + 1).toString().padLeft(2, '0')}卷'),
    'stories_enlighten_world': List.generate(40, (i) => '喻世明言/第${(i + 1).toString().padLeft(2, '0')}卷'),
    'guwen_guanzhi': List.generate(12, (i) => '古文觀止/卷${i + 1}'),
    'mozi': [
      '墨子/親士', '墨子/修身', '墨子/所染', '墨子/法儀', '墨子/七患', '墨子/辭過', '墨子/三辯',
      '墨子/尚賢上', '墨子/尚賢中', '墨子/尚賢下', '墨子/尚同上', '墨子/尚同中', '墨子/尚同下',
      '墨子/兼愛上', '墨子/兼愛中', '墨子/兼愛下', '墨子/非攻上', '墨子/非攻中', '墨子/非攻下',
      '墨子/節用上', '墨子/節用中', '墨子/節葬下', '墨子/天志上', '墨子/天志中', '墨子/天志下',
      '墨子/明鬼下', '墨子/非樂上', '墨子/非命上', '墨子/非命中', '墨子/非命下', '墨子/非儒下',
      '墨子/貴義', '墨子/公孟', '墨子/魯問', '墨子/公輸'
    ],
    'shang_jun_shu': [
      '商君書/更法', '商君書/墾令', '商君書/農戰', '商君書/去強', '商君書/說民',
      '商君書/算地', '商君書/開塞', '商君書/壹言', '商君書/錯法', '商君書/戰法',
      '商君書/立本', '商君書/兵守', '商君書/靳令', '商君書/修權', '商君書/畫策'
    ],
    'strategies_warring_states': [
      '戰國策/東周', '戰國策/西周', '戰國策/秦一', '戰國策/秦二', '戰國策/秦三', '戰國策/秦四', '戰國策/秦五',
      '戰國策/齊一', '戰國策/齊二', '戰國策/齊三', '戰國策/齊四', '戰國策/齊五', '戰國策/齊六',
      '戰國策/楚一', '戰國策/楚二', '戰國策/楚三', '戰國策/楚四',
      '戰國策/趙一', '戰國策/趙二', '戰國策/赵三', '戰國策/趙四',
      '戰國策/魏一', '戰國策/魏二', '戰國策/魏三', '戰國策/魏四',
      '戰國策/韓一', '戰國策/韓二', '戰國策/韓三',
      '戰國策/燕一', '戰國策/燕二', '戰國策/燕三',
      '戰國策/宋衛', '戰國策/中山'
    ],
    'six_records_floating_life': [
      '浮生六記/卷一 閨房記樂',
      '浮生六記/卷二 閒情記趣',
      '浮生六記/卷三 坎坷記愁',
      '浮生六記/卷四 浪遊記快',
      '浮生六記/卷五 中山記歷',
      '浮生六記/卷六 養生記道'
    ]
  };

  int successCount = 0;

  for (final entry in wikisourceBooks.entries) {
    final bookId = entry.key;
    final pageTitles = entry.value;
    print('\nIngesting $bookId (${pageTitles.length} chapters) from Wikisource...');

    final List<Map<String, dynamic>> chapters = [];

    for (int i = 0; i < pageTitles.length; i++) {
      final pTitle = pageTitles[i];
      final raw = await fetchWikisourcePage(pTitle);
      await Future.delayed(const Duration(milliseconds: 250)); // polite delay

      if (raw == null || raw.trim().isEmpty) {
        continue;
      }

      final sentences = cleanAndSegment(raw);
      if (sentences.isEmpty) continue;

      final chIdx = chapters.length + 1;
      final chTitle = pTitle.contains('/') ? pTitle.split('/').last : pTitle;

      final List<Map<String, dynamic>> sentenceObjects = [];
      for (final s in sentences.take(120)) {
        final pinyin = PinyinHelper.getPinyin(s, separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
        sentenceObjects.add({
          'chinese': s,
          'pinyin': pinyin,
          'english': '',
        });
      }

      chapters.add({
        'id': '${bookId}_ch_$chIdx',
        'bookId': bookId,
        'chapterIndex': chIdx,
        'title': chTitle,
        'titleEn': 'Chapter $chIdx: $chTitle',
        'sentences': sentenceObjects,
      });

      stdout.write('.');
    }

    if (chapters.isNotEmpty) {
      final file = File('assets/data/books/$bookId.json');
      file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(chapters));
      print('\n✅ SUCCESS: $bookId written with ${chapters.length} chapters (~${file.lengthSync() ~/ 1024} KB)');
      successCount++;
    } else {
      print('\n❌ FAILED: $bookId (0 chapters retrieved)');
    }
  }

  print('\n=== Batch completed: Ingested $successCount full books from Wikisource! ===');
}
