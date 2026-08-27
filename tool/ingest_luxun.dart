import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lpinyin/lpinyin.dart';

void main() async {
  print('=== Downloading and Ingesting Lu Xun Collections ===');

  String pinyin(String zh) {
    return PinyinHelper.getPinyinE(zh, separator: " ", format: PinyinFormat.WITH_TONE_MARK);
  }

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

  Future<void> ingestLuXunCollection(String dirName, String targetBookId) async {
    final apiUrl = Uri.parse('https://api.github.com/repos/Ac-heron/luxun/contents/全集/${Uri.encodeComponent(dirName)}');
    try {
      final res = await http.get(apiUrl, headers: {'User-Agent': 'Dart'});
      if (res.statusCode != 200) {
        print('  ✗ Failed to list $dirName: ${res.statusCode}');
        return;
      }

      final items = jsonDecode(res.body) as List<dynamic>;
      final chapters = <Map<String, dynamic>>[];
      int chapterIdx = 1;

      for (final item in items) {
        final name = item['name'] as String;
        if (!name.endsWith('.md') || name.contains('目录') || name.contains('自序')) continue;

        final downloadUrl = item['download_url'] as String?;
        if (downloadUrl == null) continue;

        final fileRes = await http.get(Uri.parse(downloadUrl));
        if (fileRes.statusCode != 200) continue;

        final mdContent = utf8.decode(fileRes.bodyBytes);
        final title = name.replaceAll('.md', '');
        final sentenceList = splitSentences(mdContent);

        if (sentenceList.isEmpty) continue;

        final sentenceMaps = <Map<String, dynamic>>[];
        for (final sent in sentenceList.take(60)) {
          sentenceMaps.add({
            'chinese': sent,
            'pinyin': pinyin(sent),
            'english': 'Lu Xun literary work passage.',
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

      if (chapters.isNotEmpty) {
        final destFile = File('assets/data/books/$targetBookId.json');
        destFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(chapters));
        print('  ✓ Ingested $targetBookId: ${chapters.length} chapters, ${chapters.fold<int>(0, (sum, c) => sum + (c['sentences'] as List).length)} sentences');
      }
    } catch (e) {
      print('  ✗ Error in $dirName: $e');
    }
  }

  await ingestLuXunCollection('呐喊', 'call_to_arms_luxun');
  await ingestLuXunCollection('彷徨', 'wandering_luxun');
  await ingestLuXunCollection('朝花夕拾', 'dawn_blossoms_luxun');
  await ingestLuXunCollection('故事新编', 'old_tales_retold');

  print('=== Lu Xun Collections Ingested! ===');
}
