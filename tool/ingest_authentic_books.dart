import 'dart:convert';
import 'dart:io';
import 'package:lpinyin/lpinyin.dart';

String toPinyin(String zh) {
  return PinyinHelper.getPinyinE(zh, separator: " ", format: PinyinFormat.WITH_TONE_MARK);
}

List<String> splitSentences(String text) {
  final raw = text
      .replaceAll('TXT小说天堂', '')
      .replaceAll('www.xiaoshuotxt.com', '')
      .replaceAll('www.xiashuotxt.com', '')
      .replaceAll('www.xiAoshUotxt.cOm', '')
      .replaceAll('ＷＷw.xiＡosＨuotxt.ＣＯＭ', '')
      .replaceAll('wＷw．xiＡoshＵotxt.cＯm', '')
      .replaceAll(RegExp(r'大[`\s,"]*学[`\s,"]*生[`\s,"]*小[`\s,"]*说[`\s,"]*网'), '')
      .replaceAll(RegExp(r'[\r\n]+'), '\n');

  final sentences = <String>[];
  final buffer = StringBuffer();

  for (int i = 0; i < raw.length; i++) {
    final char = raw[i];
    buffer.write(char);

    if (char == '。' || char == '！' || char == '？' || char == '；' || (char == '\n' && buffer.length > 25)) {
      if (i + 1 < raw.length && (raw[i + 1] == '”' || raw[i + 1] == '’' || raw[i + 1] == '」' || raw[i + 1] == '"' || raw[i + 1] == '\'')) {
        buffer.write(raw[i + 1]);
        i++;
      }
      final s = buffer.toString().trim();
      if (s.isNotEmpty && s.length >= 3) {
        sentences.add(s);
      }
      buffer.clear();
    }
  }

  final remaining = buffer.toString().trim();
  if (remaining.isNotEmpty && remaining.length >= 3) {
    sentences.add(remaining);
  }
  return sentences;
}

void ingestClassicalTxt(String rawPath, String targetBookId) {
  final file = File(rawPath);
  if (!file.existsSync()) {
    print('  ✗ File not found: $rawPath');
    return;
  }

  print('Ingesting classical novel: $targetBookId from $rawPath...');
  final content = file.readAsStringSync();
  final chapterRegex = RegExp(r'(第[一二三四五六七八九十百千0-9]+[回卷章][^\n\r]*)');
  final matches = chapterRegex.allMatches(content).toList();

  final chapters = <Map<String, dynamic>>[];
  for (int i = 0; i < matches.length; i++) {
    final startMatch = matches[i];
    final title = startMatch.group(1)!.trim();
    final startIndex = startMatch.end;
    final endIndex = (i + 1 < matches.length) ? matches[i + 1].start : content.length;

    final body = content.substring(startIndex, endIndex);
    final sentenceList = splitSentences(body);

    if (sentenceList.isEmpty) continue;

    final sentenceMaps = <Map<String, dynamic>>[];
    for (final sent in sentenceList) {
      sentenceMaps.add({
        'chinese': sent,
        'pinyin': toPinyin(sent),
        'english': '',
      });
    }

    chapters.add({
      'id': '${targetBookId}_ch_${i + 1}',
      'bookId': targetBookId,
      'chapterIndex': i + 1,
      'title': title,
      'titleEn': 'Chapter ${i + 1}: $title',
      'sentences': sentenceMaps,
    });
  }

  final targetFile = File('assets/data/books/$targetBookId.json');
  targetFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(chapters));
  final totalChars = chapters.fold<int>(0, (sum, c) => sum + (c['sentences'] as List).fold<int>(0, (sSum, s) => sSum + (s['chinese'] as String).length));
  print('  ✓ Completed $targetBookId: ${chapters.length} chapters, $totalChars characters (UNCAPPED)');
}

void ingestAncientJson(String sourceFile, String targetBookId) {
  final file = File('assets/data/ancient/$sourceFile');
  if (!file.existsSync()) {
    print('  ✗ Ancient source missing: $sourceFile');
    return;
  }

  print('Ingesting ancient philosophy: $targetBookId from $sourceFile...');
  final jsonMap = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  final articles = jsonMap['articles'] as List<dynamic>? ?? [];
  final chapters = <Map<String, dynamic>>[];

  int chapterIdx = 1;
  for (final art in articles) {
    final artMap = art as Map<String, dynamic>;
    final title = (artMap['title'] as String?)?.trim() ?? '第$chapterIdx章';
    final contentList = artMap['content'] as List<dynamic>? ?? [];

    final allText = contentList.join('\n');
    final sentenceList = splitSentences(allText);
    if (sentenceList.isEmpty) continue;

    final sentenceMaps = <Map<String, dynamic>>[];
    for (final sent in sentenceList) {
      sentenceMaps.add({
        'chinese': sent,
        'pinyin': toPinyin(sent),
        'english': '',
      });
    }

    chapters.add({
      'id': '${targetBookId}_ch_$chapterIdx',
      'bookId': targetBookId,
      'chapterIndex': chapterIdx,
      'title': title,
      'titleEn': 'Chapter $chapterIdx: $title',
      'sentences': sentenceMaps,
    });
    chapterIdx++;
  }

  final destFile = File('assets/data/books/$targetBookId.json');
  destFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(chapters));
  final totalChars = chapters.fold<int>(0, (sum, c) => sum + (c['sentences'] as List).fold<int>(0, (sSum, s) => sSum + (s['chinese'] as String).length));
  print('  ✓ Completed $targetBookId: ${chapters.length} chapters, $totalChars characters (UNCAPPED)');
}

Future<void> ingestBlankRainTxt(HttpClient client, String remoteFilename, String targetBookId) async {
  print('Fetching and ingesting: $targetBookId ($remoteFilename)...');
  final encodedPath = Uri.encodeComponent(remoteFilename);
  final url = 'https://raw.githubusercontent.com/BlankRain/ebooks/master/$encodedPath';

  try {
    final req = await client.getUrl(Uri.parse(url));
    final resp = await req.close();
    if (resp.statusCode != 200) {
      print('  ✗ Failed to download $remoteFilename (Status: ${resp.statusCode})');
      return;
    }

    final bytes = await resp.fold<List<int>>([], (prev, chunk) => prev..addAll(chunk));
    String text;
    try {
      text = utf8.decode(bytes);
    } catch (_) {
      text = String.fromCharCodes(bytes);
    }

    final chapterRegex = RegExp(r'(?:\n|\r\n)(第[一二三四五六七八九十百千0-9]+[章节回部卷][^\n\r]*)');
    var matches = chapterRegex.allMatches(text).toList();

    if (matches.isEmpty) {
      final altRegex = RegExp(r'(?:\n|\r\n)([0-9]+[\s\t]+[^\n\r]{2,30})');
      matches = altRegex.allMatches(text).toList();
    }

    final chapters = <Map<String, dynamic>>[];

    if (matches.isNotEmpty) {
      if (matches.first.start > 500) {
        final preBody = text.substring(0, matches.first.start);
        final preSentences = splitSentences(preBody);
        if (preSentences.isNotEmpty) {
          chapters.add({
            'id': '${targetBookId}_ch_1',
            'bookId': targetBookId,
            'chapterIndex': 1,
            'title': '序幕 / 导言',
            'titleEn': 'Chapter 1: Prologue',
            'sentences': preSentences.map((s) => {'chinese': s, 'pinyin': toPinyin(s), 'english': ''}).toList(),
          });
        }
      }

      for (int i = 0; i < matches.length; i++) {
        final startMatch = matches[i];
        final title = startMatch.group(1)!.trim();
        final startIndex = startMatch.end;
        final endIndex = (i + 1 < matches.length) ? matches[i + 1].start : text.length;

        final body = text.substring(startIndex, endIndex);
        final sentenceList = splitSentences(body);
        if (sentenceList.isEmpty) continue;

        final chIdx = chapters.length + 1;
        chapters.add({
          'id': '${targetBookId}_ch_$chIdx',
          'bookId': targetBookId,
          'chapterIndex': chIdx,
          'title': title,
          'titleEn': 'Chapter $chIdx: $title',
          'sentences': sentenceList.map((s) => {'chinese': s, 'pinyin': toPinyin(s), 'english': ''}).toList(),
        });
      }
    } else {
      final allSentences = splitSentences(text);
      const sentencesPerChapter = 80;
      int chIdx = 1;
      for (int i = 0; i < allSentences.length; i += sentencesPerChapter) {
        final end = (i + sentencesPerChapter < allSentences.length) ? i + sentencesPerChapter : allSentences.length;
        final slice = allSentences.sublist(i, end);
        chapters.add({
          'id': '${targetBookId}_ch_$chIdx',
          'bookId': targetBookId,
          'chapterIndex': chIdx,
          'title': '第$chIdx章',
          'titleEn': 'Chapter $chIdx',
          'sentences': slice.map((s) => {'chinese': s, 'pinyin': toPinyin(s), 'english': ''}).toList(),
        });
        chIdx++;
      }
    }

    if (chapters.isNotEmpty) {
      final targetFile = File('assets/data/books/$targetBookId.json');
      targetFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(chapters));
      final totalChars = chapters.fold<int>(0, (sum, c) => sum + (c['sentences'] as List).fold<int>(0, (sSum, s) => sSum + (s['chinese'] as String).length));
      print('  ✓ Saved $targetBookId: ${chapters.length} chapters, $totalChars characters (UNCAPPED)');
    }
  } catch (e) {
    print('  ✗ Error processing $targetBookId: $e');
  }
}

void main() async {
  print('================================================================');
  print('🚀 REBUILDING ALL TIER 2 BOOKS WITH 100% UNABRIDGED FULL TEXT');
  print('================================================================\n');

  // 1. Classical Epics
  ingestClassicalTxt('build/unit_test_assets/assets/data/xiyouji_raw.txt', 'journey_to_the_west');
  ingestClassicalTxt('build/unit_test_assets/assets/data/sanguo_raw.txt', 'romance_of_three_kingdoms');
  ingestClassicalTxt('build/unit_test_assets/assets/data/honglou_raw.txt', 'dream_of_red_chamber');

  // 2. Ancient Philosophy (All 13 chapters of Sun Tzu)
  ingestAncientJson('孙子兵法.json', 'the_art_of_war');

  // 3. World & Modern Classics from BlankRain
  final client = HttpClient();
  client.userAgent = 'HanziMasterIngest/1.0';

  final blankRainMap = {
    'the_great_gatsby': '了不起的盖茨比_菲茨杰拉德_TXT小说天堂.txt',
    'nineteen_eighty_four': '一九八四_乔治·奥威尔_TXT小说天堂.txt',
    'count_of_monte_cristo': '基督山伯爵_大仲马_TXT小说天堂.txt',
    'les_miserables': '悲惨世界_维克多·雨果_TXT小说天堂.txt',
    'ninety_three_hugo': '九三年_维克多·雨果_TXT小说天堂.txt',
    'lady_of_camellias': '茶花女_小仲马_TXT小说天堂.txt',
    'twenty_thousand_leagues': '海底两万里_儒勒·凡尔纳_TXT小说天堂.txt',
    'the_mysterious_island': '神秘岛_儒勒·凡尔纳_TXT小说天堂.txt',
    'madame_bovary': '包法利夫人_福楼拜_TXT小说天堂.txt',
    'pere_goriot': '高老头_巴尔扎克_TXT小说天堂.txt',
    'eugenie_grandet': '欧也妮·葛朗台_巴尔扎克_TXT小说天堂.txt',
    'boule_de_suif': '羊脂球_莫泊桑_TXT小说天堂.txt',
    'don_quixote': '堂吉诃德_塞万提斯_TXT小说天堂.txt',
    'crime_and_punishment': '罪与罚_陀思妥耶夫斯基_TXT小说天堂.txt',
    'brothers_karamazov': '卡拉马佐夫兄弟_陀思妥耶夫斯基_TXT小说天堂.txt',
    'dead_souls_gogol': '死魂灵_果戈里_TXT小说天堂.txt',
    'the_captains_daughter': '上尉的女儿_普希金_TXT小说天堂.txt',
    'wuthering_heights': '呼啸山庄_艾米莉·勃朗特_TXT小说天堂.txt',
    'romeo_and_juliet': '罗密欧与朱丽叶_莎士比亚_TXT小说天堂.txt',
    'merchant_of_venice': '威尼斯商人_莎士比亚_TXT小说天堂.txt',
    'robinson_crusoe': '鲁滨逊漂流记_丹尼尔·笛福_TXT小说天堂.txt',
    'call_of_the_wild': '野性的呼唤_杰克·伦敦_TXT小说天堂.txt',
    'wandering_luxun': '彷徨-鲁迅-TXT小说天堂.txt',
    'teahouse_laoshe': '茶馆-老舍-TXT小说天堂.txt',
    'fortress_besieged': '围城-钱钟书-TXT小说天堂.txt',
    'the_family_bajin': '家-巴金-TXT小说天堂.txt',
    'spring_bajin': '春-巴金-TXT小说天堂.txt',
    'the_castle_kafka': '城堡_卡夫卡_TXT小说天堂.txt',
    'animal_farm': '动物庄园_乔治·奥威尔_TXT小说天堂.txt',
    'anna_karenina': '安娜·卡列尼娜_傅石球_TXT小说天堂.txt',
    'hunchback_notre_dame': '巴黎圣母院_维克多·雨果_TXT小说天堂.txt',
    'the_red_and_the_black': '红与黑_司汤达_TXT小说天堂.txt',
    'sense_and_sensibility': '理智与情感_简·奥斯汀_TXT小说天堂.txt',
    'faust_goethe': '浮士德_歌德_TXT小说天堂.txt',
    'hamlet_shakespeare': '哈姆雷特_莎士比亚_TXT小说天堂.txt',
    'letter_unknown_woman': '一个陌生女人的来信_斯蒂芬·茨威格_TXT小说天堂.txt',
    'the_magic_mountain': '魔山_托马斯·曼_TXT小说天堂.txt',
    'the_trial_kafka': '审判_卡夫卡_TXT小说天堂.txt',
    'steppenwolf_hesse': '荒原狼_赫尔曼·黑塞_TXT小说天堂.txt',
    'intrigue_and_love': '阴谋与爱情_席勒_TXT小说天堂.txt',
    'war_and_peace': '战争与和平_列夫·托尔斯泰_TXT小说天堂.txt',
  };

  for (final entry in blankRainMap.entries) {
    await ingestBlankRainTxt(client, entry.value, entry.key);
  }

  client.close();
  print('\n=== All Tier 2 Books Successfully Ingested Uncapped! ===');
}

