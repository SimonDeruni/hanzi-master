import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const _allLocales = <String>[
  'ar',
  'de',
  'en',
  'es',
  'fr',
  'hi',
  'id',
  'it',
  'ja',
  'ko',
  'pt',
  'ru',
  'th',
  'vi',
];

const _languageNames = <String, String>{
  'ar': 'Arabic',
  'de': 'German',
  'en': 'English',
  'es': 'Spanish',
  'fr': 'French',
  'hi': 'Hindi',
  'id': 'Indonesian',
  'it': 'Italian',
  'ja': 'Japanese',
  'ko': 'Korean',
  'pt': 'Portuguese',
  'ru': 'Russian',
  'th': 'Thai',
  'vi': 'Vietnamese',
};

final _hanPattern = RegExp(r'[\u3400-\u9fff\uf900-\ufaff]');

Future<void> main(List<String> arguments) async {
  final options = _Options.parse(arguments);
  final locales = options.locales;
  final chapters = await _loadChapters();
  final translations = await _loadTranslations(locales);

  if (options.validateOnly) {
    _validateCompleteness(chapters, translations, locales);
    _validatePoetryCompleteness(
        await _loadPoetryTranslations(locales), locales);
    return;
  }

  if (!options.force) {
    final reused =
        _reuseExactTitleTranslations(chapters, translations, locales);
    if (reused > 0 && !options.dryRun) {
      await _writeTranslations(translations, locales);
      stdout
          .writeln('Reused translations for $reused identical chapter titles.');
    }
  }
  final pending = chapters
      .where((chapter) =>
          options.force ||
          locales.any((locale) =>
              (translations[locale]?[chapter.id] ?? '').trim().isEmpty))
      .toList();
  final uniquePending = <String, _ChapterContext>{};
  for (final chapter in pending) {
    uniquePending.putIfAbsent(chapter.titleChinese, () => chapter);
  }
  final selected = options.limit == null
      ? uniquePending.values.toList()
      : uniquePending.values.take(options.limit!).toList(growable: false);

  stdout.writeln(
    'Chapter-title translations (${locales.join(', ')}): '
    '${chapters.length - pending.length}/${chapters.length} complete.',
  );
  final poems = await _loadPoems();
  final poetryTranslations = await _loadPoetryTranslations(locales);
  final pendingPoems = poems
      .where((poem) =>
          options.force ||
          locales.any((locale) =>
              (poetryTranslations[locale]?[poem.id]?['title'] ?? '')
                  .trim()
                  .isEmpty))
      .toList();
  stdout.writeln(
    'Poem-title translations (${locales.join(', ')}): '
    '${poems.length - pendingPoems.length}/${poems.length} complete.',
  );
  if (options.dryRun) {
    stdout.writeln(
      'Dry run: ${selected.length} chapter title(s) and '
      '${pendingPoems.length} poem title(s) would be sent to Gemini. No files changed.',
    );
    return;
  }

  final apiKey =
      (selected.isNotEmpty || pendingPoems.isNotEmpty) ? _readApiKey() : '';
  final client = http.Client();
  try {
    final waveSize = options.batchSize * options.concurrency;
    for (var offset = 0; offset < selected.length; offset += waveSize) {
      final waveEnd = (offset + waveSize).clamp(0, selected.length);
      final wave = selected.sublist(offset, waveEnd);
      final batches = <List<_ChapterContext>>[];
      for (var batchOffset = 0;
          batchOffset < wave.length;
          batchOffset += options.batchSize) {
        final batchEnd =
            (batchOffset + options.batchSize).clamp(0, wave.length);
        batches.add(wave.sublist(batchOffset, batchEnd));
      }
      final results = await Future.wait(batches.map(
        (batch) => _translateBatch(
          client: client,
          apiKey: apiKey,
          model: options.model,
          chapters: batch,
          locales: locales,
        ),
      ));

      for (var index = 0; index < batches.length; index++) {
        for (final chapter in batches[index]) {
          final localized = results[index][chapter.id]!;
          for (final locale in locales) {
            translations[locale]![chapter.id] = localized[locale]!;
          }
        }
      }
      _reuseExactTitleTranslations(chapters, translations, locales);
      await _writeTranslations(translations, locales);
      final complete = translations[locales.first]!.length;
      stdout.writeln('Saved $complete/${chapters.length} chapters.');
      if (waveEnd < selected.length) {
        await Future<void>.delayed(options.delay);
      }
    }

    await _translatePoems(
      client: client,
      apiKey: apiKey,
      options: options,
      locales: locales,
      poems: pendingPoems,
      translations: poetryTranslations,
    );
  } finally {
    client.close();
  }

  if (options.limit == null) {
    _validateCompleteness(chapters, translations, locales);
    _validatePoetryCompleteness(poetryTranslations, locales);
  }
}

int _reuseExactTitleTranslations(
  List<_ChapterContext> chapters,
  Map<String, Map<String, String>> translations,
  List<String> locales,
) {
  final completeByChineseTitle = <String, Map<String, String>>{};
  for (final chapter in chapters) {
    final localized = <String, String>{};
    for (final locale in locales) {
      final value = translations[locale]?[chapter.id]?.trim() ?? '';
      if (value.isEmpty) {
        localized.clear();
        break;
      }
      localized[locale] = value;
    }
    if (localized.length == locales.length) {
      completeByChineseTitle.putIfAbsent(chapter.titleChinese, () => localized);
    }
  }

  var reused = 0;
  for (final chapter in chapters) {
    final localized = completeByChineseTitle[chapter.titleChinese];
    if (localized == null) continue;
    final wasMissing = locales.any(
      (locale) => (translations[locale]?[chapter.id] ?? '').trim().isEmpty,
    );
    if (!wasMissing) continue;
    for (final locale in locales) {
      translations[locale]![chapter.id] = localized[locale]!;
    }
    reused++;
  }
  return reused;
}

Future<List<_ChapterContext>> _loadChapters() async {
  final catalog = jsonDecode(
    await File('assets/data/grand_library_catalog.json').readAsString(),
  ) as List<dynamic>;
  final books = <String, ({String chinese, String english})>{
    for (final value in catalog.cast<Map<String, dynamic>>())
      value['id'] as String: (
        chinese: value['title'] as String? ?? '',
        english: value['titleEn'] as String? ?? '',
      ),
  };

  final files = Directory('assets/data/books')
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.json'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));
  final chapters = <_ChapterContext>[];
  final ids = <String>{};
  for (final file in files) {
    final values = jsonDecode(await file.readAsString()) as List<dynamic>;
    for (final value in values.cast<Map<String, dynamic>>()) {
      final id = value['id'] as String? ?? '';
      final bookId = value['bookId'] as String? ?? '';
      final book = books[bookId];
      if (id.isEmpty || book == null || !ids.add(id)) {
        throw FormatException(
            'Invalid or duplicate chapter ID "$id" in ${file.path}.');
      }
      chapters.add(_ChapterContext(
        id: id,
        number: (value['chapterIndex'] as num?)?.toInt() ?? 0,
        bookChinese: book.chinese,
        bookEnglish: book.english,
        titleChinese: value['title'] as String? ?? '',
        titleEnglish: value['titleEn'] as String? ?? '',
      ));
    }
  }
  return chapters;
}

Future<Map<String, Map<String, String>>> _loadTranslations(
  List<String> locales,
) async {
  final result = <String, Map<String, String>>{};
  for (final locale in locales) {
    final file = File(_outputPath(locale));
    if (!file.existsSync()) {
      result[locale] = {};
      continue;
    }
    final values =
        jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    result[locale] =
        values.map((key, value) => MapEntry(key, value.toString()));
  }
  return result;
}

Future<Map<String, Map<String, String>>> _translateBatch({
  required http.Client client,
  required String apiKey,
  required String model,
  required List<_ChapterContext> chapters,
  required List<String> locales,
}) async {
  final prompt = StringBuffer()
    ..writeln(
        'You are a professional literary translator of Chinese book titles.')
    ..writeln(
        'Translate every Chinese chapter title into every requested language.')
    ..writeln(
        'Use the book and current English fields only as disambiguating context.')
    ..writeln(
        'Translate the COMPLETE Chinese title, including literary subtitles.')
    ..writeln(
        'Preserve chapter/fable/poem numbering naturally in each language.')
    ..writeln(
        'Do not retain Chinese Han characters except proper names that truly require them.')
    ..writeln(
        'For non-Japanese output, translate or romanize every Han character, including characters embedded in names or corrupted source text.')
    ..writeln('Do not add explanations, romanization, or quotation marks.')
    ..writeln(
        'Languages: ${locales.map((locale) => '$locale=${_languageNames[locale]}').join(', ')}')
    ..writeln('Input records:')
    ..writeln(jsonEncode(chapters.map((chapter) => chapter.toJson()).toList()));

  return _requestTranslations(
    client: client,
    apiKey: apiKey,
    model: model,
    prompt: prompt.toString(),
    ids: chapters.map((chapter) => chapter.id).toList(growable: false),
    locales: locales,
  );
}

Future<Map<String, Map<String, String>>> _requestTranslations({
  required http.Client client,
  required String apiKey,
  required String model,
  required String prompt,
  required List<String> ids,
  required List<String> locales,
}) async {
  final schema = <String, dynamic>{
    'type': 'array',
    'items': {
      'type': 'object',
      'properties': {
        'id': {'type': 'string'},
        'translations': {
          'type': 'object',
          'properties': {
            for (final locale in locales) locale: {'type': 'string'},
          },
          'required': locales,
        },
      },
      'required': ['id', 'translations'],
    },
  };
  final uri = Uri.parse(
    'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey',
  );

  for (var attempt = 1; attempt <= 7; attempt++) {
    try {
      final response = await client
          .post(
            uri,
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode({
              'contents': [
                {
                  'parts': [
                    {'text': prompt},
                  ],
                },
              ],
              'generationConfig': {
                'temperature': 0.15,
                'maxOutputTokens': 16384,
                'responseMimeType': 'application/json',
                'responseSchema': schema,
              },
            }),
          )
          .timeout(const Duration(seconds: 120));
      if (response.statusCode == 200) {
        final envelope = jsonDecode(response.body) as Map<String, dynamic>;
        final candidates = envelope['candidates'] as List<dynamic>?;
        final content = candidates?.firstOrNull as Map<String, dynamic>?;
        final parts = (content?['content'] as Map<String, dynamic>?)?['parts']
            as List<dynamic>?;
        final text =
            (parts?.firstOrNull as Map<String, dynamic>?)?['text'] as String?;
        if (text == null) {
          throw const FormatException('Gemini returned no text.');
        }
        return _parseBatch(text, ids, locales);
      }
      if (response.statusCode != 429 && response.statusCode < 500) {
        throw HttpException(
            'Gemini HTTP ${response.statusCode}: ${response.body}');
      }
      stderr.writeln(
          'Gemini HTTP ${response.statusCode}; retrying attempt $attempt/7.');
    } catch (error) {
      if (attempt == 7) rethrow;
      stderr.writeln('Gemini attempt $attempt/7 failed: $error');
    }
    await Future<void>.delayed(Duration(seconds: attempt * attempt * 2));
  }
  throw StateError('Gemini retry loop ended unexpectedly.');
}

Map<String, Map<String, String>> _parseBatch(
  String response,
  List<String> ids,
  List<String> locales,
) {
  final decoded = jsonDecode(response) as List<dynamic>;
  final expectedIds = ids.toSet();
  final result = <String, Map<String, String>>{};
  for (final item in decoded.cast<Map<String, dynamic>>()) {
    final id = item['id'] as String? ?? '';
    if (!expectedIds.contains(id) || result.containsKey(id)) {
      throw FormatException(
          'Gemini returned unexpected or duplicate ID "$id".');
    }
    final raw = item['translations'] as Map<String, dynamic>? ?? const {};
    final localized = <String, String>{};
    for (final locale in locales) {
      final title = raw[locale]?.toString().trim() ?? '';
      if (title.isEmpty) {
        throw FormatException('Gemini omitted $locale for "$id".');
      }
      if (locale != 'ja' && _hanPattern.hasMatch(title)) {
        throw FormatException(
          'Gemini retained Han characters in $locale for "$id".',
        );
      }
      localized[locale] = title;
    }
    result[id] = localized;
  }
  if (result.length != ids.length) {
    throw FormatException(
      'Gemini returned ${result.length}/${ids.length} records.',
    );
  }
  return result;
}

Future<void> _writeTranslations(
  Map<String, Map<String, String>> translations,
  List<String> locales,
) async {
  const encoder = JsonEncoder.withIndent('  ');
  for (final locale in locales) {
    final sorted = Map.fromEntries(
      translations[locale]!.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key)),
    );
    final file = File(_outputPath(locale));
    final temporary = File('${file.path}.tmp');
    await temporary.writeAsString('${encoder.convert(sorted)}\n');
    if (await file.exists()) await file.delete();
    await temporary.rename(file.path);
  }
}

void _validateCompleteness(
  List<_ChapterContext> chapters,
  Map<String, Map<String, String>> translations,
  List<String> locales,
) {
  final failures = <String>[];
  for (final locale in locales) {
    final values = translations[locale]!;
    for (final chapter in chapters) {
      final value = values[chapter.id]?.trim() ?? '';
      if (value.isEmpty) failures.add('$locale:${chapter.id}:missing');
      if (locale != 'ja' && value.isNotEmpty && _hanPattern.hasMatch(value)) {
        failures.add('$locale:${chapter.id}:contains-Han');
      }
    }
  }
  if (failures.isNotEmpty) {
    throw StateError(
      '${failures.length} localization problems. First: ${failures.take(20).join(', ')}',
    );
  }
  stdout.writeln(
    'Validated ${chapters.length} chapters in ${locales.length} locales '
    '(${chapters.length * locales.length} titles).',
  );
}

String _readApiKey() {
  final environmentKey = Platform.environment['GEMINI_API_KEY']?.trim();
  if (environmentKey != null && environmentKey.isNotEmpty) {
    return environmentKey;
  }
  final file = File('.env');
  if (file.existsSync()) {
    for (final line in file.readAsLinesSync()) {
      final match =
          RegExp(r'^\s*GEMINI_API_KEY\s*=\s*(.+?)\s*$').firstMatch(line);
      if (match != null) {
        return match.group(1)!.replaceAll(RegExp(r'''^["']|["']$'''), '');
      }
    }
  }
  throw StateError('Set GEMINI_API_KEY or add it to the ignored .env file.');
}

String _outputPath(String locale) =>
    'assets/data/l10n/chapter_titles_by_id_$locale.json';

Future<List<_PoemContext>> _loadPoems() async {
  final values = jsonDecode(
    await File('assets/data/famous_chinese_poetry.json').readAsString(),
  ) as List<dynamic>;
  final ids = <String>{};
  return values.cast<Map<String, dynamic>>().map((value) {
    final id = (value['link'] ?? value['id'] ?? '').toString();
    if (id.isEmpty || !ids.add(id)) {
      throw FormatException('Invalid or duplicate poem ID "$id".');
    }
    final titleEnglish = value['title_en']?.toString().trim() ?? '';
    if (titleEnglish.isEmpty) {
      throw FormatException('Poem "$id" has no English title.');
    }
    return _PoemContext(
      id: id,
      titleChinese: value['title']?.toString() ?? '',
      titleEnglish: titleEnglish,
      author: value['author_en']?.toString() ??
          value['sourceName']?.toString() ??
          '',
      dynasty: value['dynasty']?.toString() ?? '',
    );
  }).toList(growable: false);
}

Future<Map<String, Map<String, Map<String, String>>>> _loadPoetryTranslations(
    List<String> locales) async {
  final poems = await _loadPoems();
  final result = <String, Map<String, Map<String, String>>>{};
  for (final locale in locales) {
    final file = File(_poetryOutputPath(locale));
    final entries = <String, Map<String, String>>{};
    if (file.existsSync()) {
      final values =
          jsonDecode(await file.readAsString()) as Map<String, dynamic>;
      for (final entry in values.entries) {
        final raw = entry.value;
        if (raw is Map) {
          entries[entry.key] = raw.map(
            (key, value) => MapEntry(key.toString(), value.toString()),
          );
        }
      }
    }
    if (locale == 'en') {
      for (final poem in poems) {
        entries.putIfAbsent(poem.id, () => {})['title'] ??= poem.titleEnglish;
      }
    }
    result[locale] = entries;
  }
  return result;
}

Future<void> _translatePoems({
  required http.Client client,
  required String apiKey,
  required _Options options,
  required List<String> locales,
  required List<_PoemContext> poems,
  required Map<String, Map<String, Map<String, String>>> translations,
}) async {
  if (poems.isEmpty) return;
  final selected = options.limit == null
      ? poems
      : poems.take(options.limit!).toList(growable: false);
  for (var offset = 0; offset < selected.length; offset += options.batchSize) {
    final end = (offset + options.batchSize).clamp(0, selected.length);
    final batch = selected.sublist(offset, end);
    final localized = await _translatePoemBatch(
      client: client,
      apiKey: apiKey,
      model: options.model,
      poems: batch,
      locales: locales,
    );
    for (final poem in batch) {
      for (final locale in locales) {
        translations[locale]!.putIfAbsent(poem.id, () => {})['title'] =
            localized[poem.id]![locale]!;
      }
    }
    await _writePoetryTranslations(translations, locales);
    stdout.writeln('Saved poem titles through $end/${selected.length}.');
    if (end < selected.length) await Future<void>.delayed(options.delay);
  }
}

Future<Map<String, Map<String, String>>> _translatePoemBatch({
  required http.Client client,
  required String apiKey,
  required String model,
  required List<_PoemContext> poems,
  required List<String> locales,
}) async {
  final prompt = StringBuffer()
    ..writeln('You are a professional literary translator of Chinese poetry.')
    ..writeln(
        'Translate each complete poem title into every requested language.')
    ..writeln('Use the English title, author, and dynasty as context.')
    ..writeln('Use established published title translations where well known.')
    ..writeln('Do not add explanations, romanization, or quotation marks.')
    ..writeln('Do not retain Han characters except in Japanese.')
    ..writeln(
      'Languages: ${locales.map((locale) => '$locale=${_languageNames[locale]}').join(', ')}',
    )
    ..writeln('Input records:')
    ..writeln(jsonEncode(poems.map((poem) => poem.toJson()).toList()));
  return _requestTranslations(
    client: client,
    apiKey: apiKey,
    model: model,
    prompt: prompt.toString(),
    ids: poems.map((poem) => poem.id).toList(growable: false),
    locales: locales,
  );
}

Future<void> _writePoetryTranslations(
  Map<String, Map<String, Map<String, String>>> translations,
  List<String> locales,
) async {
  const encoder = JsonEncoder.withIndent('  ');
  for (final locale in locales) {
    final sorted = Map.fromEntries(
      translations[locale]!.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key)),
    );
    final file = File(_poetryOutputPath(locale));
    final temporary = File('${file.path}.tmp');
    await temporary.writeAsString('${encoder.convert(sorted)}\n');
    if (await file.exists()) await file.delete();
    await temporary.rename(file.path);
  }
}

void _validatePoetryCompleteness(
  Map<String, Map<String, Map<String, String>>> translations,
  List<String> locales,
) {
  final poems = jsonDecode(
    File('assets/data/famous_chinese_poetry.json').readAsStringSync(),
  ) as List<dynamic>;
  final ids = poems
      .cast<Map<String, dynamic>>()
      .map((poem) => (poem['link'] ?? poem['id']).toString())
      .toSet();
  final failures = <String>[];
  for (final locale in locales) {
    for (final id in ids) {
      final title = translations[locale]?[id]?['title']?.trim() ?? '';
      if (title.isEmpty) failures.add('$locale:$id:missing');
      if (locale != 'ja' && title.isNotEmpty && _hanPattern.hasMatch(title)) {
        failures.add('$locale:$id:contains-Han');
      }
    }
  }
  if (failures.isNotEmpty) {
    throw StateError(
      '${failures.length} poetry localization problems. First: '
      '${failures.take(20).join(', ')}',
    );
  }
  stdout.writeln(
    'Validated ${ids.length} poems in ${locales.length} locales '
    '(${ids.length * locales.length} titles).',
  );
}

String _poetryOutputPath(String locale) =>
    'assets/data/l10n/poetry_$locale.json';

class _ChapterContext {
  const _ChapterContext({
    required this.id,
    required this.number,
    required this.bookChinese,
    required this.bookEnglish,
    required this.titleChinese,
    required this.titleEnglish,
  });

  final String id;
  final int number;
  final String bookChinese;
  final String bookEnglish;
  final String titleChinese;
  final String titleEnglish;

  Map<String, dynamic> toJson() => {
        'id': id,
        'chapterNumber': number,
        'bookChinese': bookChinese,
        'bookEnglish': bookEnglish,
        'chapterChinese': titleChinese,
        'currentEnglish': titleEnglish,
      };
}

class _PoemContext {
  const _PoemContext({
    required this.id,
    required this.titleChinese,
    required this.titleEnglish,
    required this.author,
    required this.dynasty,
  });

  final String id;
  final String titleChinese;
  final String titleEnglish;
  final String author;
  final String dynasty;

  Map<String, dynamic> toJson() => {
        'id': id,
        'titleChinese': titleChinese,
        'titleEnglish': titleEnglish,
        'author': author,
        'dynasty': dynasty,
      };
}

class _Options {
  const _Options({
    required this.batchSize,
    required this.delay,
    required this.model,
    required this.force,
    required this.validateOnly,
    required this.limit,
    required this.concurrency,
    required this.locales,
    required this.dryRun,
  });

  final int batchSize;
  final Duration delay;
  final String model;
  final bool force;
  final bool validateOnly;
  final int? limit;
  final int concurrency;
  final List<String> locales;
  final bool dryRun;

  factory _Options.parse(List<String> arguments) {
    var batchSize = 8;
    var delay = const Duration(seconds: 4);
    var model = 'gemini-3.5-flash-lite';
    var force = false;
    var validateOnly = false;
    int? limit;
    var concurrency = 3;
    var dryRun = false;
    final requestedLocales = <String>[];
    var all = false;
    for (var index = 0; index < arguments.length; index++) {
      switch (arguments[index]) {
        case '--batch-size':
          batchSize = int.parse(arguments[++index]);
        case '--delay-ms':
          delay = Duration(milliseconds: int.parse(arguments[++index]));
        case '--model':
          model = arguments[++index];
        case '--force':
          force = true;
        case '--dry-run':
          dryRun = true;
        case '--all':
          all = true;
        case '--lang':
          requestedLocales.addAll(arguments[++index].split(','));
        case '--validate':
          validateOnly = true;
        case '--limit':
          limit = int.parse(arguments[++index]);
        case '--concurrency':
          concurrency = int.parse(arguments[++index]);
        default:
          throw ArgumentError('Unknown option: ${arguments[index]}');
      }
    }
    if (batchSize < 1 || batchSize > 25) {
      throw ArgumentError('--batch-size must be between 1 and 25.');
    }
    if (concurrency < 1 || concurrency > 5) {
      throw ArgumentError('--concurrency must be between 1 and 5.');
    }
    if (all && requestedLocales.isNotEmpty) {
      throw ArgumentError('Use either --all or --lang, not both.');
    }
    final locales = all || requestedLocales.isEmpty
        ? List<String>.from(_allLocales)
        : requestedLocales
            .map((locale) => locale.trim().toLowerCase())
            .toSet()
            .toList();
    final unsupported =
        locales.where((locale) => !_allLocales.contains(locale));
    if (unsupported.isNotEmpty) {
      throw ArgumentError('Unsupported locale(s): ${unsupported.join(', ')}.');
    }
    return _Options(
      batchSize: batchSize,
      delay: delay,
      model: model,
      force: force,
      validateOnly: validateOnly,
      limit: limit,
      concurrency: concurrency,
      locales: locales,
      dryRun: dryRun,
    );
  }
}
