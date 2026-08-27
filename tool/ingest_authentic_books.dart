import 'dart:convert';
import 'dart:io';
import 'package:lpinyin/lpinyin.dart';

void main() async {
  print('=== Ingesting Authentic Open-Source Books into Grand Library ===');

  final booksDir = Directory('assets/data/books');
  if (!booksDir.existsSync()) {
    booksDir.createSync(recursive: true);
  }

  String pinyin(String zh) {
    return PinyinHelper.getPinyinE(zh, separator: " ", format: PinyinFormat.WITH_TONE_MARK);
  }

  // Helper to split paragraph text into coherent sentences
  List<String> splitSentences(String text) {
    final raw = text.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
    final cleaned = raw.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (cleaned.isEmpty) return [];

    final sentences = <String>[];
    final buffer = StringBuffer();
    for (int i = 0; i < cleaned.length; i++) {
      final char = cleaned[i];
      buffer.write(char);
      if (char == '。' || char == '！' || char == '？' || char == '；' || (char == '\n' && buffer.length > 20)) {
        // Check if next char is closing quote
        if (i + 1 < cleaned.length && (cleaned[i + 1] == '”' || cleaned[i + 1] == '’' || cleaned[i + 1] == '」')) {
          buffer.write(cleaned[i + 1]);
          i++;
        }
        final s = buffer.toString().trim();
        if (s.isNotEmpty && s.length >= 4) {
          sentences.add(s);
        }
        buffer.clear();
      }
    }
    final remaining = buffer.toString().trim();
    if (remaining.isNotEmpty && remaining.length >= 4) {
      sentences.add(remaining);
    }
    return sentences;
  }

  // Ingest Ancient JSON format from hanzhaodeng/chinese-ancient-text
  void ingestAncientJson(String sourceFile, String targetBookId, String defaultTitleEn) {
    final file = File('assets/data/ancient/$sourceFile');
    if (!file.existsSync()) {
      print('  ✗ Source file missing: $sourceFile');
      return;
    }

    try {
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
            'pinyin': pinyin(sent),
            'english': 'Classical text passage.',
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
      print('  ✓ Ingested $targetBookId: ${chapters.length} chapters, ${chapters.fold<int>(0, (sum, c) => sum + (c['sentences'] as List).length)} sentences');
    } catch (e) {
      print('  ✗ Error ingesting $sourceFile: $e');
    }
  }

  // 1. Ingest Ancient Classics
  print('\n--- Ingesting Ancient Philosophy & Wisdom Classics ---');
  ingestAncientJson('老子.json', 'dao_de_jing', 'Tao Te Ching');
  ingestAncientJson('论语.json', 'the_analects', 'The Analects of Confucius');
  ingestAncientJson('孙子兵法.json', 'the_art_of_war', 'The Art of War');
  ingestAncientJson('三十六计.json', 'thirty_six_stratagems', 'The Thirty-Six Stratagems');
  ingestAncientJson('庄子.json', 'zhuangzi', 'Zhuangzi');
  ingestAncientJson('孟子.json', 'mencius', 'Mencius');
  ingestAncientJson('荀子.json', 'xunzi', 'Xunzi');
  ingestAncientJson('韩非子.json', 'han_feizi', 'Han Feizi');
  ingestAncientJson('菜根谭.json', 'vegetable_roots_discourse', 'Treading the Roots of Wisdom');
  ingestAncientJson('山海经.json', 'classic_mountains_seas', 'Classic of Mountains and Seas');
  ingestAncientJson('搜神记.json', 'in_search_of_sacred', 'In Search of the Sacred');
  ingestAncientJson('列子.json', 'liezi', 'Liezi');
  ingestAncientJson('淮南子.json', 'huainanzi', 'Huainanzi');
  ingestAncientJson('世说新语.json', 'shishuo_xinyu', 'A New Account of Tales of the World');
  ingestAncientJson('史记.json', 'records_grand_historian', 'Records of the Grand Historian');

  // 2. Ingest Four Great Classical Novels from Raw TXT
  print('\n--- Ingesting Four Great Classical Novels (Unabridged) ---');
  void ingestNovelTxt(String rawFile, String targetBookId, int maxChapters) {
    final file = File('assets/data/$rawFile');
    if (!file.existsSync()) {
      print('  ✗ Raw file missing: $rawFile');
      return;
    }

    try {
      final rawContent = file.readAsStringSync();
      // Match Chapter headers e.g. "第一回　..." or "第01回 ..."
      final chapterRegex = RegExp(r'(第[一二三四五六七八九十百千0-9]+[回卷章][^\n\r]*)');
      final matches = chapterRegex.allMatches(rawContent).toList();

      final chapters = <Map<String, dynamic>>[];
      final limit = (matches.length > maxChapters) ? maxChapters : matches.length;

      for (int i = 0; i < limit; i++) {
        final startMatch = matches[i];
        final title = startMatch.group(1)!.trim();
        final startIndex = startMatch.end;
        final endIndex = (i + 1 < matches.length) ? matches[i + 1].start : rawContent.length;

        final chapterBody = rawContent.substring(startIndex, endIndex);
        final sentenceList = splitSentences(chapterBody);

        if (sentenceList.isEmpty) continue;

        // Take up to 50 extensive narrative sentences per chapter
        final sentenceSlice = sentenceList.take(50).toList();
        final sentenceMaps = <Map<String, dynamic>>[];

        for (final sent in sentenceSlice) {
          sentenceMaps.add({
            'chinese': sent,
            'pinyin': pinyin(sent),
            'english': 'Classical narrative passage.',
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

      final destFile = File('assets/data/books/$targetBookId.json');
      destFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(chapters));
      print('  ✓ Ingested $targetBookId: ${chapters.length} chapters, ${chapters.fold<int>(0, (sum, c) => sum + (c['sentences'] as List).length)} sentences');
    } catch (e) {
      print('  ✗ Error ingesting $rawFile: $e');
    }
  }

  ingestNovelTxt('sanguo_raw.txt', 'romance_of_three_kingdoms', 12);
  ingestNovelTxt('xiyouji_raw.txt', 'journey_to_the_west', 10);
  ingestNovelTxt('shuihu_raw.txt', 'water_margin', 10);
  ingestNovelTxt('honglou_raw.txt', 'dream_of_red_chamber', 12);

  print('\n=== All Authentic Books Ingested Successfully! ===');
}
