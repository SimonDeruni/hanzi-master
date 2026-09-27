import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guard rails for the **content** catalogs - the text that is *not* in
/// `lib/l10n/*.arb`.
///
/// Book synopses, show summaries, poetry, chapter titles, radicals, author
/// biographies, deck blurbs and the Mandarin Bean stories all live as one JSON
/// file per locale under `assets/data/l10n/`, with English as the runtime
/// fallback. Nothing checked that layer, so a locale could quietly ship English
/// prose - or stop shipping a file entirely - without a single test objecting.
/// The ARB ratchets cannot see it, which is exactly how the gaps pinned below
/// survived.
///
/// Every rule here is a **ratchet**: it fails when a locale gets *worse* and
/// passes when it gets better, so each baseline may only ever be lowered. The
/// numbers were produced by `scratch/content_l10n_audit.py`, which prints the
/// same figures with concrete examples and is the tool to run when this file
/// fails.
///
/// ## Gaps pinned on 2026-09-26 (audit: `audit/audit_37_content_localization.md`)
/// 1. Three Thai catalogs are absent, so Thai falls back to English wholesale.
/// 2. Five Hindi chapter titles carry the literal marker
///    *"Hindi translation unavailable, using English: ..."*, which ships to the
///    user as visible text.
/// 3. `idiom_stories_*` is read by no code path at all. The thirteen
///    `mandarin_bean_stories_<locale>.json` overlays were orphaned the same way
///    when this file was first written; that was **fixed on 2026-09-26**
///    (`story_fetcher_service.dart` now loads them for both fields and passes
///    `localizedTitles` / `localizedSummaries` into `LibraryStory`), and the
///    summaries inside them were **completed on 2026-09-27** - all thirteen
///    locales now hold 150/150, which is why the ceilings at the bottom of this
///    file are zero.
void main() {
  group('Content catalog locale coverage', () {
    test('every family ships a file for each content locale', () {
      final Set<String> offenders = <String>{};
      for (final String family in _kFamilies) {
        // A family nothing reads is not a coverage gap, it is dead weight - the
        // orphan rule owns it instead. Demanding thirteen files of a catalog no
        // screen loads would only push orphaned data around.
        if (_kKnownOrphanFamilies.contains(family)) {
          continue;
        }
        for (final String locale in _kLocales) {
          if (!File('assets/data/l10n/${family}_$locale.json').existsSync()) {
            offenders.add('${family}_$locale.json');
          }
        }
      }

      final Set<String> unexpected =
          offenders.difference(_kKnownMissingLocaleFiles);
      expect(
        unexpected,
        isEmpty,
        reason: 'A content catalog lost (or never gained) a locale file, so that '
            'language silently falls back to English. Add the file or add it to '
            'kKnownMissingLocaleFiles with a date: $unexpected',
      );

      // Ratchet down: a file that now exists must leave the allowlist.
      final Set<String> stale =
          _kKnownMissingLocaleFiles.difference(offenders);
      expect(
        stale,
        isEmpty,
        reason: 'These files exist now - delete them from '
            'kKnownMissingLocaleFiles so the ratchet tightens: $stale',
      );
    });

    test('no locale file ships an English placeholder marker', () {
      // The pipeline that wrote `chapter_titles_by_id_hi.json` left the literal
      // string "Hindi translation unavailable, using English: <English text>"
      // in five rows. A marker like this is not a fallback the UI can hide - it
      // is the chapter title the reader sees.
      final RegExp marker =
          RegExp(r'^(?:[A-Z][a-z]+ )?translation unavailable', caseSensitive: false);
      final List<String> offenders = <String>[];
      for (final FileSystemEntity entity in _l10nFiles()) {
        final String name = entity.uri.pathSegments.last;
        final dynamic decoded = jsonDecode(_read(entity.path));
        if (decoded is! Map<String, dynamic>) {
          // List-shaped catalogs (the orphaned `idiom_stories_*`) carry no keys
          // to pin; the orphan rule is what keeps an eye on them.
          continue;
        }
        for (final MapEntry<String, dynamic> entry in decoded.entries) {
          if (marker.hasMatch(entry.value.toString().trim())) {
            offenders.add('$name:${entry.key}');
          }
        }
      }

      final List<String> unexpected =
          offenders.where((String row) => !_kKnownPlaceholderRows.contains(row))
              .toList();
      expect(
        unexpected,
        isEmpty,
        reason: 'A locale ships a translation-pipeline placeholder as user text. '
            'Translate the row and delete it from kKnownPlaceholderRows: '
            '$unexpected',
      );

      final List<String> stale = _kKnownPlaceholderRows
          .where((String row) => !offenders.contains(row))
          .toList();
      expect(
        stale,
        isEmpty,
        reason: 'Those rows are clean now - remove them from '
            'kKnownPlaceholderRows: $stale',
      );
    });

    test('every per-locale catalog family is actually read by code', () {
      // A translated file that nothing loads is not a translation, it is a file.
      // This is how the Mandarin Bean overlays went unnoticed: the *base*
      // `assets/data/mandarin_bean_stories.json` is referenced, and the only
      // "reference" to the overlays is a stale comment in
      // `story_summary_screen.dart` promising a read that does not exist. The
      // pattern therefore insists on a real path literal (`l10n/<family>_`
      // followed by `$`, `'` or `"`), which a comment cannot satisfy, and on the
      // generic loader being called with the family name.
      final String corpus = _libCorpus();
      final List<String> offenders = <String>[];
      for (final String family in _kFamilies) {
        final RegExp literal =
            RegExp('l10n/${RegExp.escape(family)}_(?:\\\$|\'|")');
        final bool wired = literal.hasMatch(corpus) ||
            corpus.contains("loadLocalizedTitlesById('$family'");
        if (!wired) {
          offenders.add(family);
        }
      }

      final List<String> unexpected = offenders
          .where((String family) => !_kKnownOrphanFamilies.contains(family))
          .toList();
      expect(
        unexpected,
        isEmpty,
        reason: 'These locale catalogs exist but no code reads them, so the '
            'translations never reach a screen. Wire them up or delete them: '
            '$unexpected',
      );

      final List<String> stale = _kKnownOrphanFamilies
          .where((String family) => !offenders.contains(family))
          .toList();
      expect(
        stale,
        isEmpty,
        reason: 'These families are read now - remove them from '
            'kKnownOrphanFamilies: $stale',
      );
    });

    test('the Mandarin Bean story translation never regresses', () {
      final List<dynamic> base = jsonDecode(
        _read('assets/data/mandarin_bean_stories.json'),
      ) as List<dynamic>;
      final Map<String, Map<String, dynamic>> baseByLink =
          <String, Map<String, dynamic>>{};
      for (final dynamic raw in base) {
        final Map<String, dynamic> entry =
            Map<String, dynamic>.from(raw as Map<dynamic, dynamic>);
        baseByLink[(entry['link'] ?? entry['title']).toString()] = entry;
      }
      expect(baseByLink, hasLength(150),
          reason: 'The English base changed shape; the ceiling map below and '
              'scratch/content_l10n_audit.py both assume 150 stories.');

      for (final String locale in _kLocales) {
        final Map<String, dynamic> data = jsonDecode(
          _read('assets/data/l10n/mandarin_bean_stories_$locale.json'),
        ) as Map<String, dynamic>;
        expect(data, hasLength(150),
            reason: '$locale dropped or gained stories.');

        int englishSummaries = 0;
        int englishTitles = 0;
        for (final MapEntry<String, dynamic> entry in data.entries) {
          final Map<String, dynamic> source = baseByLink[entry.key] ?? const {};
          final Map<String, dynamic> value =
              Map<String, dynamic>.from(entry.value as Map<dynamic, dynamic>);
          if (value['summary'] != null &&
              value['summary'].toString().trim().isNotEmpty &&
              value['summary'] == source['summary_en']) {
            englishSummaries++;
          }
          if (value['title'] != null &&
              value['title'].toString().trim().isNotEmpty &&
              value['title'] == source['title_en']) {
            englishTitles++;
          }
        }

        expect(
          englishSummaries,
          lessThanOrEqualTo(_kEnglishSummaryCeiling[locale]!),
          reason: '$locale regressed on summaries ($englishSummaries English of '
              '150, ceiling ${_kEnglishSummaryCeiling[locale]}). Finish the '
              'sweep with scratch/translate_summaries_gemini.py, then lower the '
              'ceiling - never raise it.',
        );
        expect(
          englishTitles,
          lessThanOrEqualTo(_kEnglishTitleCeiling[locale]!),
          reason: '$locale regressed on titles ($englishTitles English of 150, '
              'ceiling ${_kEnglishTitleCeiling[locale]}).',
        );
      }
    });
    test('no book in the corpus carries an ebook watermark', () {
      // Audit 38 found pirate-site watermarks inside the *prose* of 28 books -
      // `w w w. xiao shuotxt. co m`, `ＷＷw.xiＡosＨuotxt.ＣＯＭ`, `bookcover` -
      // so the reader displayed them, the TTS read them aloud, and tapping one
      // did a dictionary lookup that could not resolve. Removed by
      // `scratch/clean_book_watermarks.py`; this keeps them out.
      //
      // Fold the separators away instead of writing an elaborate fuzzy regex:
      // the watermarks are one string spelled a dozen ways, so squashing
      // whitespace, dots and CJK punctuation to nothing and lowercasing reduces
      // every spelling to the same needle.
      final RegExp separators = RegExp(r'[\s.．。｡·,、\u3000]');
      final List<String> offenders = <String>[];
      for (final FileSystemEntity entity
          in Directory('assets/data/books').listSync()) {
        if (entity is! File || !entity.path.endsWith('.json')) continue;
        final String squashed =
            entity.readAsStringSync().toLowerCase().replaceAll(separators, '');
        if (squashed.contains('xiaoshuotxt') ||
            squashed.contains('bookcover')) {
          offenders.add(entity.uri.pathSegments.last);
        }
      }
      expect(
        offenders,
        isEmpty,
        reason: 'An ebook watermark is back in the book corpus. Re-run '
            'python scratch/clean_book_watermarks.py: $offenders',
      );
    });
  });
}

// ------------------------------------------------------------------- fixtures
const List<String> _kLocales = <String>[
  'ar',
  'de',
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

/// Every `<family>_<locale>.json` family in `assets/data/l10n/`.
const List<String> _kFamilies = <String>[
  'author_bios',
  'book_titles',
  'books',
  'chapter_titles',
  'chapter_titles_by_id',
  'channels',
  'deck_descriptions',
  'idiom_stories',
  'mandarin_bean_stories',
  'poetry',
  'radicals',
  'shows',
];

/// Allowlist for the missing-file rule. Thai is the only locale short of a
/// catalog; each of these three files needs a Thai translation to clear.
const Set<String> _kKnownMissingLocaleFiles = <String>{
  'shows_th.json',
  'channels_th.json',
  'chapter_titles_th.json',
};

/// Allowlist for the placeholder-marker rule. **Empty**, and it must stay empty:
/// the five Journey to the West rows (chapters 40-44) that carried the literal
/// string *"Hindi translation unavailable, using English: ..."* were translated
/// on 2026-09-26, so the rule now has nothing to excuse.
const Set<String> _kKnownPlaceholderRows = <String>{};

/// Allowlist for the orphan rule.
///
/// * `idiom_stories` - six files, byte-identical to each other and written in
///   English, with no reader since the story pipeline moved on. Delete them or
///   wire them; either way they must leave this list.
///
/// `mandarin_bean_stories` used to be on this list too: the thirteen overlays
/// held all 150 titles translated while `loadLocalizedTitlesById` was never
/// called with that prefix, so `LibraryStory.localizedSummaries` stayed empty and
/// the reader fell back to `summaryEn`. Wired up in
/// `StoryFetcherService._loadBeanOverlay` (2026-09-26, audit 37 P0), which is
/// why it is no longer here - and why this list is now one entry shorter.
const Set<String> _kKnownOrphanFamilies = <String>{
  'idiom_stories',
};

/// Per-locale ceiling on summaries that are still the English string, out of 150.
///
/// **Re-measured 2026-09-27: zero, everywhere.** `scratch/summaries_factory.py`
/// finished the sweep in one pooled run (841 summaries written, the other 280
/// already hand-written), so all thirteen locales now hold 150/150. These are
/// ratchets and may only ever go down - any non-zero value here means a
/// translation was lost (or a revert clobbered one), which is exactly what this
/// rule is for. `python scratch/summaries_progress.py` re-measures.
const Map<String, int> _kEnglishSummaryCeiling = <String, int>{
  'ar': 0,
  'de': 0,
  'es': 0,
  'fr': 0,
  'hi': 0,
  'id': 0,
  'it': 0,
  'ja': 0,
  'ko': 0,
  'pt': 0,
  'ru': 0,
  'th': 0,
  'vi': 0,
};

/// Per-locale ceiling on titles that are still the English string, out of 150.
const Map<String, int> _kEnglishTitleCeiling = <String, int>{
  'ar': 0,
  'de': 0,
  'es': 0,
  'fr': 1,
  'hi': 0,
  'id': 0,
  'it': 0,
  'ja': 0,
  'ko': 0,
  'pt': 0,
  'ru': 0,
  'th': 0,
  'vi': 0,
};

String _read(String path) {
  final String raw = File(path).readAsStringSync();
  return raw.startsWith('\uFEFF') ? raw.substring(1) : raw;
}

List<File> _l10nFiles() => Directory('assets/data/l10n')
    .listSync()
    .whereType<File>()
    .where((File file) => file.path.endsWith('.json'))
    .toList();

/// Every `.dart` file under `lib/`, concatenated - the corpus the orphan rule
/// searches for an asset path.
String _libCorpus() {
  final StringBuffer buffer = StringBuffer();
  for (final FileSystemEntity entity
      in Directory('lib').listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      buffer.write(entity.readAsStringSync());
      buffer.write('\n');
    }
  }
  return buffer.toString();
}
