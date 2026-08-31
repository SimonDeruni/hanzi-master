import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Languages to translate into — 12 target languages matching the existing pattern.
const targetLanguages = [
  'ar', 'de', 'es', 'fr', 'hi', 'id', 'it', 'ja', 'ko', 'pt', 'ru', 'vi',
];

/// Google Translate API base URL (free, no key required).
const googleTranslateUrl =
    'https://translate.googleapis.com/translate_a/single?client=gtx&dt=t';

/// Batch size for parallel translation requests.
const batchSize = 40;

/// Delay between batches to avoid rate limiting.
const batchDelay = Duration(milliseconds: 100);

/// Translates a single text string from English to [targetLang] using Google
/// Translate. Retries up to 3 times on failure; falls back to original text.
Future<String> translateText(String text, String targetLang) async {
  if (text.isEmpty) return text;

  final urlStr =
      '$googleTranslateUrl&sl=en&tl=$targetLang&q=${Uri.encodeComponent(text)}';

  for (int attempt = 1; attempt <= 3; attempt++) {
    try {
      final response = await http
          .get(Uri.parse(urlStr))
          .timeout(const Duration(seconds: 20));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String translated = '';
        for (var obj in data[0]) {
          translated += (obj[0] ?? '');
        }
        return translated.trim();
      }
    } catch (e) {
      if (attempt == 3) {
        print('  FAILED after 3 attempts: "$text" -> $targetLang: $e');
        return text; // fallback to original
      }
      await Future.delayed(Duration(seconds: attempt));
    }
  }
  return text;
}

/// ===========================================================================
/// 1. Translate Famous Chinese Poetry (famous_chinese_poetry.json)
///    Creates assets/data/l10n/poetry_<lang>.json
///    Format: Map of poem link/id -> { "title": "...", "summary": "..." }
/// ===========================================================================
Future<void> translatePoetry() async {
  print('\n=== 📜 TRANSLATING FAMOUS CHINESE POETRY (100 poems) ===\n');
  final file = File('assets/data/famous_chinese_poetry.json');
  final List<dynamic> poems = json.decode(await file.readAsString());

  // Build the English source map: id -> {title_en, summary_en}
  final Map<String, Map<String, String>> sourceMap = {};
  for (final poem in poems) {
    final id = poem['link'] as String;
    sourceMap[id] = {
      'title': poem['title_en'] as String? ?? '',
      'summary': poem['summary_en'] as String? ?? '',
    };
  }

  final allIds = sourceMap.keys.toList();

  for (final lang in targetLanguages) {
    final outPath = 'assets/data/l10n/poetry_$lang.json';
    final outFile = File(outPath);
    if (outFile.existsSync()) {
      print('  Skipping poetry_$lang.json (already exists)');
      continue;
    }

    print('  Translating ${allIds.length} poems to $lang...');
    final Map<String, dynamic> result = {};

    int translated = 0;
    for (int i = 0; i < allIds.length; i += batchSize) {
      final batch = allIds.sublist(
          i, (i + batchSize > allIds.length) ? allIds.length : i + batchSize);

      await Future.wait(batch.map((id) async {
        final src = sourceMap[id]!;
        final title = await translateText(src['title']!, lang);
        final summary = await translateText(src['summary']!, lang);
        result[id] = {'title': title, 'summary': summary};
        translated++;
        stdout.write('\r    $translated/${allIds.length} translated to $lang...');
      }));

      if (i + batchSize < allIds.length) {
        await Future.delayed(batchDelay);
      }
    }

    const encoder = JsonEncoder.withIndent('  ');
    outFile.writeAsStringSync(encoder.convert(result));
    print('\r    ✅ $translated/${allIds.length} poems translated to $lang');
  }
  print('  ✅ Poetry translation complete!\n');
}

/// ===========================================================================
/// 2. Translate Mandarin Bean Stories (mandarin_bean_stories.json)
///    Creates assets/data/l10n/mandarin_bean_stories_<lang>.json
///    Format: Map of story link -> { "title": "...", "summary": "..." }
/// ===========================================================================
Future<void> translateMandarinBeanStories() async {
  print('\n=== 📖 TRANSLATING MANDARIN BEAN STORIES (150 stories) ===\n');
  final file = File('assets/data/mandarin_bean_stories.json');
  final List<dynamic> stories = json.decode(await file.readAsString());

  // Build the English source map: link -> {title_en, summary_en}
  final Map<String, Map<String, String>> sourceMap = {};
  for (final story in stories) {
    final link = story['link'] as String? ?? '';
    if (link.isEmpty) continue;
    sourceMap[link] = {
      'title': story['title_en'] as String? ?? story['title'] as String? ?? '',
      'summary': story['summary_en'] as String? ?? story['summary'] as String? ?? '',
    };
  }

  final allLinks = sourceMap.keys.toList();

  for (final lang in targetLanguages) {
    final outPath = 'assets/data/l10n/mandarin_bean_stories_$lang.json';
    final outFile = File(outPath);
    if (outFile.existsSync()) {
      print('  Skipping mandarin_bean_stories_$lang.json (already exists)');
      continue;
    }

    print('  Translating ${allLinks.length} stories to $lang...');
    final Map<String, dynamic> result = {};

    int translated = 0;
    for (int i = 0; i < allLinks.length; i += batchSize) {
      final batch = allLinks.sublist(
          i, (i + batchSize > allLinks.length) ? allLinks.length : i + batchSize);

      await Future.wait(batch.map((link) async {
        final src = sourceMap[link]!;
        final title = await translateText(src['title']!, lang);
        final summary = await translateText(src['summary']!, lang);
        result[link] = {'title': title, 'summary': summary};
        translated++;
        stdout.write('\r    $translated/${allLinks.length} translated to $lang...');
      }));

      if (i + batchSize < allLinks.length) {
        await Future.delayed(batchDelay);
      }
    }

    const encoder = JsonEncoder.withIndent('  ');
    outFile.writeAsStringSync(encoder.convert(result));
    print('\r    ✅ $translated/${allLinks.length} stories translated to $lang');
  }
  print('  ✅ Mandarin Bean translation complete!\n');
}
/// ===========================================================================
/// 3. Translate Book Chapter Titles (all 110 books, ~6,645 chapters)
///    Creates assets/data/l10n/chapter_titles_<lang>.json
///    Format: Map of "bookId_chapterIndex" -> "translated title"
/// ===========================================================================
Future<void> translateChapterTitles() async {
  print('\n=== 📚 TRANSLATING BOOK CHAPTER TITLES (110 books, ~6,645 chapters) ===\n');

  final booksDir = Directory('assets/data/books');
  final files = booksDir.listSync().whereType<File>().toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  // Build source map: "bookId_chapterIndex" -> titleEn
  final Map<String, String> sourceMap = {};
  for (final f in files) {
    final bookId = f.uri.pathSegments.last.replaceAll('.json', '');
    final List<dynamic> chapters = json.decode(await f.readAsString());
    for (final ch in chapters) {
      final idx = ch['chapterIndex'] as int;
      final titleEn = ch['titleEn'] as String? ?? ch['title'] as String? ?? '';
      // Clean: if titleEn still contains Chinese characters, extract only the
      // English prefix before any Chinese text.
      String cleanTitle = titleEn;
      final chineseMatch =
          RegExp(r'[\u4e00-\u9fff]').firstMatch(titleEn);
      if (chineseMatch != null) {
        cleanTitle = titleEn.substring(0, chineseMatch.start).trim();
        if (cleanTitle.isEmpty ||
            cleanTitle.endsWith(':') ||
            cleanTitle.endsWith('：')) {
          cleanTitle = 'Chapter $idx';
        } else {
          cleanTitle = cleanTitle.replaceAll(RegExp(r'[：:\s]+$'), '');
        }
      }
      sourceMap['${bookId}_$idx'] = cleanTitle;
    }
  }

  final allKeys = sourceMap.keys.toList();
  print('  Total chapter titles to translate: ${allKeys.length}');

  for (final lang in targetLanguages) {
    final outPath = 'assets/data/l10n/chapter_titles_$lang.json';
    final outFile = File(outPath);
    if (outFile.existsSync()) {
      print('  Skipping chapter_titles_$lang.json (already exists)');
      continue;
    }

    print('  Translating ${allKeys.length} chapter titles to $lang...');
    final Map<String, dynamic> result = {};

    int translated = 0;
    for (int i = 0; i < allKeys.length; i += batchSize) {
      final batch = allKeys.sublist(
          i, (i + batchSize > allKeys.length) ? allKeys.length : i + batchSize);

      await Future.wait(batch.map((key) async {
        final translatedTitle =
            await translateText(sourceMap[key]!, lang);
        result[key] = translatedTitle;
        translated++;
        stdout.write('\r    $translated/${allKeys.length} translated to $lang...');
      }));

      if (i + batchSize < allKeys.length) {
        await Future.delayed(batchDelay);
      }
    }

    const encoder = JsonEncoder.withIndent('  ');
    outFile.writeAsStringSync(encoder.convert(result));
    print('\r    ✅ $translated/${allKeys.length} chapter titles translated to $lang');
  }
  print('  ✅ Chapter titles translation complete!\n');
}

/// ===========================================================================
/// Main entry point.
/// ===========================================================================
void main() async {
  print('╔══════════════════════════════════════════════════════════════╗');
  print('║     TRANSLATE ALL CONTENT INTO 12 LANGUAGES                ║');
  print('╚══════════════════════════════════════════════════════════════╝');
  print('');
  print('Languages: ${targetLanguages.join(', ')}');
  print('');

  // Step 1: Poetry
  await translatePoetry();

  // Step 2: Mandarin Bean stories
  await translateMandarinBeanStories();

  // Step 3: Book chapter titles
  await translateChapterTitles();

  print('');
  print('╔══════════════════════════════════════════════════════════════╗');
  print('║     ✅ ALL TRANSLATIONS COMPLETE!                          ║');
  print('╚══════════════════════════════════════════════════════════════╝');
  print('Generated files in assets/data/l10n/:');
  for (final lang in targetLanguages) {
    final poetry = File('assets/data/l10n/poetry_$lang.json');
    final mb = File('assets/data/l10n/mandarin_bean_stories_$lang.json');
    final ct = File('assets/data/l10n/chapter_titles_$lang.json');
    print('  $lang:');
    print('    poetry_$lang.json          ${poetry.existsSync() ? "✅" : "❌"}');
    print('    mandarin_bean_stories_$lang.json ${mb.existsSync() ? "✅" : "❌"}');
    print('    chapter_titles_$lang.json  ${ct.existsSync() ? "✅" : "❌"}');
  }
}