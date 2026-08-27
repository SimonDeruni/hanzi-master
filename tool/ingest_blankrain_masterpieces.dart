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
  print('=== Hanzi Master: Ingesting Authentic Masterpieces from BlankRain/ebooks ===');

  // Exact verified map: book_id -> exact file path in repo
  final Map<String, String> masterMap = {
    'les_miserables': '悲惨世界_维克多·雨果_TXT小说天堂.txt',
    'hunchback_notre_dame': '巴黎圣母院_维克多·雨果_TXT小说天堂.txt',
    'ninety_three_hugo': '九三年_维克多·雨果_TXT小说天堂.txt',
    'count_of_monte_cristo': '基督山伯爵_大仲马_TXT小说天堂.txt',
    'lady_of_camellias': '茶花女_小仲马_TXT小说天堂.txt',
    'madame_bovary': '包法利夫人_福楼拜_TXT小说天堂.txt',
    'pere_goriot': '高老头_巴尔扎克_TXT小说天堂.txt',
    'eugenie_grandet': '欧也妮·葛朗台_巴尔扎克_TXT小说天堂.txt',
    'boule_de_suif': '羊脂球_莫泊桑_TXT小说天堂.txt',
    'the_red_and_the_black': '红与黑_司汤达_TXT小说天堂.txt',
    'the_stranger_camus': '加缪-局外人_阿尔贝·加缪_TXT小说天堂.txt',
    'the_plague_camus': '鼠疫_阿尔贝·加缪_TXT小说天堂.txt',
    'the_trial_kafka': '审判_卡夫卡_TXT小说天堂.txt',
    'faust_goethe': '浮士德_歌德_TXT小说天堂.txt',
    'steppenwolf_hesse': '荒原狼_赫尔曼·黑塞_TXT小说天堂.txt',
    'letter_unknown_woman': '一个陌生女人的来信_斯蒂芬·茨威格_TXT小说天堂.txt',
    'intrigue_and_love': '阴谋与爱情_席勒_TXT小说天堂.txt',
    'the_magic_mountain': '魔山_托马斯·曼_TXT小说天堂.txt',
    'don_quixote': '堂吉诃德_塞万提斯_TXT小说天堂.txt',
    'the_decameron': '十日谈_薄伽丘_TXT小说天堂.txt',
    'war_and_peace': '战争与和平_列夫·托尔斯泰_TXT小说天堂.txt',
    'anna_karenina': '安娜·卡列尼娜_傅石球_TXT小说天堂.txt',
    'crime_and_punishment': '罪与罚_陀思妥耶夫斯基_TXT小说天堂.txt',
    'brothers_karamazov': '卡拉马佐夫兄弟_陀思妥耶夫斯基_TXT小说天堂.txt',
    'white_nights_dostoevsky': '外国文学-白夜_陀思妥耶夫斯基_TXT小说天堂.txt',
    'dead_souls_gogol': '死魂灵_果戈里_TXT小说天堂.txt',
    'the_captains_daughter': '上尉的女儿_普希金_TXT小说天堂.txt',
    'fathers_and_sons': '父与子_屠格涅夫_TXT小说天堂.txt',
    'pride_and_prejudice': '傲慢与偏见_简·奥斯汀_TXT小说天堂.txt',
    'sense_and_sensibility': '理智与情感_简·奥斯汀_TXT小说天堂.txt',
    'wuthering_heights': '呼啸山庄_艾米莉·勃朗特_TXT小说天堂.txt',
    'romeo_and_juliet': '罗密欧与朱丽叶_莎士比亚_TXT小说天堂.txt',
    'hamlet_shakespeare': '哈姆雷特_莎士比亚_TXT小说天堂.txt',
    'merchant_of_venice': '威尼斯商人_莎士比亚_TXT小说天堂.txt',
    'robinson_crusoe': '鲁滨逊漂流记_丹尼尔·笛福_TXT小说天堂.txt',
    'walden_thoreau': '瓦尔登湖_亨利·大卫·梭罗_TXT小说天堂.txt',
    'the_great_gatsby': '了不起的盖茨比_菲茨杰拉德_TXT小说天堂.txt',
    'the_old_man_and_sea': '老人与海_海明威_TXT小说天堂.txt',
    'nineteen_eighty_four': '一九八四_乔治·奥威尔_TXT小说天堂.txt',
    'picture_dorian_gray': '道林格雷的画像_奥斯卡·王尔德_TXT小说天堂.txt',
    'huckleberry_finn': '哈克贝利.芬历险记_马克·吐温_TXT小说天堂.txt',
    'moby_dick_melville': '白鲸_赫尔曼·麦尔维尔_TXT小说天堂.txt',

    // 20th Century Modern Chinese
    'rickshaw_boy': '骆驼祥子-老舍-TXT小说天堂.txt',
    'four_generations_roof': '四世同堂-老舍-TXT小说天堂.txt',
    'teahouse_laoshe': '茶馆-老舍-TXT小说天堂.txt',
    'border_town': '边城-沈从文-TXT小说天堂.txt',
    'fortress_besieged': '围城-钱钟书-TXT小说天堂.txt',
    'love_fallen_city': '倾城之恋_张爱玲_TXT小说天堂.txt',
    'golden_cangue': '金锁记-张爱玲-TXT小说天堂.txt',
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

    // Split into chapters using chapter regex
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
      // Chunk sentences into chapters of 80 sentences each
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

  print('\n=== Masterpieces Ingestion Finished: Successfully Ingested $successCount Books! ===');
}
