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
    print('Fetch error: $e');
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
    if (trimmed.isEmpty || trimmed.contains('TXT小说天堂') || trimmed.contains('www.') || trimmed.startsWith('http')) continue;

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
  print('=== Hanzi Master: Ingesting World Classics & Modern Chinese from Ref_Book ===');

  // Query tree from memxz/Ref_Book
  final client = HttpClient();
  client.userAgent = 'HanziMasterApp/1.0';
  final uri = Uri.parse('https://api.github.com/repos/memxz/Ref_Book/git/trees/master?recursive=1');
  final req = await client.getUrl(uri);
  final resp = await req.close();
  final body = await resp.transform(utf8.decoder).join();
  final json = jsonDecode(body) as Map<String, dynamic>;
  final tree = (json['tree'] as List<dynamic>?) ?? [];
  client.close();

  // Mapping from our bookId -> pattern to match file in Ref_Book
  final Map<String, String> bookFileMap = {
    // English & American Classics
    'the_adventures_of_sherlock_holmes': '福尔摩斯',
    'pride_and_prejudice': '傲慢与偏见',
    'sense_and_sensibility': '理智与情感',
    'jane_eyre': '简·爱',
    'wuthering_heights': '呼啸山庄',
    'robinson_crusoe': '鲁滨逊漂流记',
    'gullivers_travels': '格列佛游记',
    'the_great_gatsby': '了不起的盖茨比',
    'the_old_man_and_the_sea': '老人与海',
    'animal_farm': '动物农场',
    'nineteen_eighty_four': '一九八四',
    'frankenstein': '弗兰肯斯坦',
    'the_time_machine': '时间机器',
    'alice_in_wonderland': '爱丽丝',
    'the_picture_of_dorian_gray': '道林·格雷',
    'the_adventures_of_tom_sawyer': '汤姆·索亚历险记',
    'adventures_of_huckleberry_finn': '哈克贝利·费恩',
    'moby_dick': '白鲸',
    'the_call_of_the_wild': '野性的呼唤',
    'walden': '瓦尔登湖',

    // French Classics
    'the_count_of_monte_cristo': '基督山',
    'les_miserables': '悲惨世界',
    'the_hunchback_of_notredame': '巴黎圣母院',
    'twenty_thousand_leagues': '海底两万里',
    'around_the_world_in_eighty_days': '八十天环游地球',
    'journey_to_the_center_of_the_earth': '地心游记',
    'madame_bovary': '包法利夫人',
    'the_red_and_the_black': '红与黑',
    'pere_goriot': '高老头',
    'eugenie_grandet': '欧也妮·葛朗台',
    'the_stranger': '局外人',
    'the_plague': '鼠疫',

    // German Classics
    'the_metamorphosis': '变形记',
    'the_trial': '审判',
    'the_castle': '城堡',
    'the_sorrows_of_young_werther': '少年维特',
    'faust': '浮士德',
    'siddhartha': '悉达多',
    'steppenwolf': '荒原狼',
    'demian': '德米安',
    'beneath_the_wheel': '轮下',
    'thus_spoke_zarathustra': '查拉图斯特拉',
    'the_magic_mountain': '魔山',
    'death_in_venice': '魂断威尼斯',

    // Russian & Spanish Classics
    'don_quixote': '堂吉诃德',
    'one_hundred_years_of_solitude': '百年孤独',
    'war_and_peace': '战争与和平',
    'anna_karenina': '安娜·卡列尼娜',
    'resurrection': '复活',
    'crime_and_punishment': '罪与罚',
    'the_brothers_karamazov': '卡拉马佐夫兄弟',
    'white_nights': '白夜',
    'dead_souls': '死魂灵',
    'the_government_inspector': '钦差大臣',
    'fathers_and_sons': '父与子',

    // Modern Chinese Classics
    'family_bajin': '家-巴金',
    'spring_bajin': '春-巴金',
    'autumn_bajin': '秋-巴金',
    'camel_xiangzi': '骆驼祥子',
    'border_town': '边城',
    'midnight_maodun': '子夜',
  };

  int successCount = 0;

  for (final entry in bookFileMap.entries) {
    final bookId = entry.key;
    final pattern = entry.value;

    final matchingItem = tree.firstWhere(
      (item) => (item['path'] as String).contains(pattern) && (item['path'] as String).endsWith('.txt'),
      orElse: () => null,
    );

    if (matchingItem == null) {
      print('⚠️ No matching file found for $bookId (pattern "$pattern")');
      continue;
    }

    final filePath = matchingItem['path'] as String;
    print('\nIngesting $bookId from $filePath ...');

    final rawUrl = 'https://raw.githubusercontent.com/memxz/Ref_Book/master/${Uri.encodeComponent(filePath)}';
    final content = await fetchUrl(rawUrl);

    if (content == null || content.length < 500) {
      print('❌ Failed to download $filePath');
      continue;
    }

    print('  -> Downloaded ${content.length} characters (~${content.length ~/ 1024} KB)');

    // Split into chapters using chapter regex
    final chapterRegex = RegExp(r'(第[0-9一二三四五六七八九十百千]+[回卷篇章部][^\n\r]*)');
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

  print('\n=== Ref_Book Ingestion Batch Finished: Ingested $successCount full-text books! ===');
}
